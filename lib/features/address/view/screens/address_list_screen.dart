import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/no_data.dart';
import 'package:alchef/common/widgets/primary_loader.dart';
import 'package:alchef/features/address/controller/address_list_controller.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/view/screens/set_location_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key, this.onSelectAddress});

  final Function(Address address)? onSelectAddress;

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final controller = Get.isRegistered<AddressListController>()
      ? Get.find<AddressListController>()
      : Get.put(AddressListController());

  @override
  void initState() {
    controller.fetchAddresses();
    super.initState();
  }

  void _addLocation() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetLocationScreen(fromSignup: false),
      ),
    );
    controller.fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return CustomScaffold(
      appbarTitle: 'Saved Address',
      body: Obx(() {
        if (controller.isLoading.value) {
          return PrimaryLoader();
        }

        final addressList = controller.addressList;

        if (addressList.isEmpty) {
          return const NoData(onRetry: null);
        }

        if (controller.error != null) {
          return ErrorContent(message: controller.error, onRetry: null);
        }

        return ListView.separated(
          padding: EdgeInsets.all(s.pagePadding),
          itemCount: addressList.length,
          separatorBuilder: (_, _) => SizedBox(height: s.spacingLg),
          itemBuilder: (context, index) {
            final address = addressList[index];
            return InkWell(
              onTap: () {
                if (widget.onSelectAddress != null) {
                  widget.onSelectAddress!(address);
                }
              },
              borderRadius: BorderRadius.circular(s.cardRadius),
              child: Container(
                padding: EdgeInsets.all(s.cardPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(s.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.addressName,
                            style: TextStyle(
                              fontSize: s.fontLg,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: s.spacingXs),
                          Text(
                            address.address,
                            style: TextStyle(
                              fontSize: s.fontMd,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetLocationScreen(
                              fromSignup: false,
                              userAddress: address,
                            ),
                          ),
                        );
                        controller.fetchAddresses();
                      },
                      icon: Icon(Icons.edit, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLocation,
        child: const Icon(Icons.add),
      ),
    );
  }
}
