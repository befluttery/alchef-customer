import 'package:alchef/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/custom_text_field.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/address/controller/address_controller.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/model/address_type_model.dart';
import 'package:alchef/features/address/view/widgets/fetching_location.dart';
import 'package:alchef/features/address/view/widgets/location_not_permitted.dart';
import 'package:alchef/features/address/view/widgets/location_turned_off.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({
    super.key,
    this.userAddress,
    this.fromSignup = false,
  });

  final Address? userAddress;
  final bool fromSignup;

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final controller = Get.put(AddressController());

  @override
  void initState() {
    if (widget.userAddress != null) {
      controller.addressController.text = widget.userAddress!.address;
      controller.location.value = LatLng(
        double.tryParse(widget.userAddress!.latitude) ?? 0.0,
        double.tryParse(widget.userAddress!.longitude) ?? 0.0,
      );
      controller.cityController.text = widget.userAddress!.city;
      controller.buildingNameController.text = widget.userAddress!.streetFlat;
      controller.selectedAddressType.value = widget.userAddress!.addressName;
    } else {
      controller.fetchEmirates();
      controller.checkLocationPermissions();
    }
    super.initState();
  }

  List<AddressTypeModel> addressTypes = [
    AddressTypeModel(
      name: 'Home',
      icon: AppImages.homeAddress,
      isSelected: false,
    ),
    AddressTypeModel(
      name: 'Work',
      icon: AppImages.workAddress,
      isSelected: false,
    ),
    AddressTypeModel(
      name: 'Others',
      icon: AppImages.otherAddress,
      isSelected: false,
    ),
  ];

  void _proceed() async {
    if (controller.formKey.currentState?.validate() == true) {
      if (widget.fromSignup) {
        final request = AddAddressRequest(
          userId: AuthHelper.userId,

          addressName: controller.selectedAddressType.value,
          address: controller.addressController.text.trim(),
          streetFlat: controller.buildingNameController.text.trim(),
          city: controller.cityController.text.trim(),
          emirateId: controller.selectedEmirateId.value ?? 0,
          latitude: controller.location.value?.latitude.toString() ?? '',
          longitude: controller.location.value?.longitude.toString() ?? '',
        );
        Navigator.pop(context, request);
      } else {
        if (widget.userAddress != null) {
          // controller.handleEditAddress(
          //   addressId: widget.userAddress?.id,
          // );
        } else {
          final success = await controller.handleAddAddress();
          if (success && mounted) {
            Navigator.pop(context);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return GetBuilder<AddressController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Select Location'),
          actions: [
            Obx(() {
              if ((!controller.isLocationPermitted.value ||
                      !controller.isLocationTurnedOn.value ||
                      controller.fetchingLocation.value) &&
                  widget.userAddress == null) {
                return SizedBox();
              } else {
                return IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    AppImages.searchIcon,
                    height: 24,
                    color: Colors.white,
                  ),
                );
              }
            }),
          ],
        ),
        body: Obx(() {
          if (widget.userAddress == null &&
              !controller.isLocationPermitted.value) {
            return LocationNotPermitted(
              onCheckPermission: controller.checkLocationPermissions,
              onOpenSettings: () {
                Navigator.pop(context);
                openAppSettings();
              },
            );
          }

          if (widget.userAddress == null &&
              !controller.isLocationTurnedOn.value) {
            return LocationTurnedOff(
              onEnableLocation: controller.turnOnLocation,
            );
          }

          if (controller.fetchingLocation.value) {
            return FetchingLocation();
          }

          return Column(
            children: [
              // if (controller.location.value == null)
              //   SizedBox(
              //     height: DeviceHelper.screenHeight(context) * 0.4,
              //     child: const PrimaryLoader(),
              //   )
              // else
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).viewInsets.bottom > 0
                      ? 0
                      : DeviceHelper.screenHeight(context) * 0.32,
                ),
                child: Container(color: Colors.grey.shade200),

                // GoogleMap(
                //   onMapCreated: (mapController) {
                //     controller.googleMapController = mapController;
                //   },
                //   initialCameraPosition: CameraPosition(
                //     target: controller.location.value!,
                //     zoom: 15,
                //   ),
                //   onCameraMove: (position) {
                //     UiHelper.unfocus();
                //     controller.location.value = LatLng(
                //       position.target.latitude,
                //       position.target.longitude,
                //     );
                //   },
                //   onCameraIdle: () {
                //     final location = controller.location.value;
                //     if (location != null) {
                //       controller.updateLocation(
                //         location.latitude,
                //         location.longitude,
                //       );
                //     }
                //   },
                //   onTap: (argument) {
                //     UiHelper.unfocus();
                //     controller.updateLocation(
                //       argument.latitude,
                //       argument.longitude,
                //     );
                //   },
                //   markers: {
                //     Marker(
                //       markerId: const MarkerId('currentlocation'),
                //       position: controller.location.value!,
                //     ),
                //   },
                // ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          // readyOnly: true,
                          controller: controller.addressController,
                          label: 'Full Address',
                          hintText: 'Enter Address',
                          isFloatingLabel: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Row(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                isFloatingLabel: false,
                                label: 'Apartment/Building name',
                                hintText: 'Eg., Apartment, House',
                                controller: controller.buildingNameController,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter Door No';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: s.spacingMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'City',
                                hintText: 'Enter city',
                                controller: controller.cityController,
                                isFloatingLabel: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            //
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Emirate',
                                    style: TextStyle(
                                      fontSize: s.fontMd,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: s.spacingXs),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Select emirate',
                                    ),
                                    items: controller.emirates
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) {
                                      controller.selectedEmirateId.value = v;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select emirate';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Address Type',
                          style: TextStyle(
                            fontSize: s.fontMd,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => Row(
                            children: List.generate(addressTypes.length, (
                              index,
                            ) {
                              final type = addressTypes[index];
                              bool isSelected =
                                  controller.selectedAddressType.value
                                      .toLowerCase() ==
                                  type.name.toLowerCase();
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedAddressType.value =
                                      type.name;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        type.icon,
                                        height: 18,
                                        color: isSelected
                                            ? AppColors.primary
                                            : Colors.grey.shade600,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        type.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.w500
                                              : null,
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _proceed,
                          child: Text('Save Location'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
