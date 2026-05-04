import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/repo/address_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:alchef/core/utils/location_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';

class AddressController extends GetxController {
  var isLocationPermitted = false.obs;
  var isLocationTurnedOn = false.obs;
  var fetchingLocation = false.obs;
  var location = Rxn<LatLng>();

  GoogleMapController? googleMapController;
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final buildingNameController = TextEditingController();
  final cityController = TextEditingController();
  var selectedAddressType = 'Home'.obs;

  var emirates = <Emirate>[].obs;
  var selectedEmirateId = Rxn<int>();

  Future<void> fetchEmirates() async {
    try {
      final result = await AddressRepository.getEmirates();
      emirates.value = result;
    } catch (e) {
      UiHelper.showErrorMessage(e);
    }
  }

  Future<void> checkLocationPermissions() async {
    try {
      bool hasLocationPermission = await LocationHelper.hasLocationPermission();

      isLocationPermitted.value = hasLocationPermission;

      if (!hasLocationPermission) {
        return;
      }
      await turnOnLocation();
    } catch (e) {
      //
    }
  }

  Future<void> turnOnLocation() async {
    try {
      bool isLocationEnabled = await LocationHelper.isLocationEnabled();

      isLocationTurnedOn.value = isLocationEnabled;

      if (isLocationEnabled) {
        await Future.delayed(Duration(milliseconds: 150));
        await getDeviceLocation();
      }
      update();
    } catch (e) {
      fetchingLocation.value = false;
    }
  }

  Future<void> getDeviceLocation() async {
    try {
      fetchingLocation.value = true;
      update();
      final deviceLocation = await LocationHelper.getCurrentLocation();
      await updateLocation(deviceLocation.latitude, deviceLocation.longitude);
    } catch (e) {
      fetchingLocation.value = false;
      update();
      UiHelper.showErrorMessage(e);
    }
  }

  Future<void> updateLocation(double latitude, double longitude) async {
    try {
      fetchingLocation.value = true;
      location.value = LatLng(latitude, longitude);
      final address = await LocationHelper.getFullAddress(latitude, longitude);
      addressController.text = address;
    } catch (e) {
      UiHelper.showToast('Failed to resolve address. Please try again.');
    } finally {
      fetchingLocation.value = false;
      update();
    }
  }

  Future<bool> handleAddAddress({int? addressId}) async {
    try {
      UiHelper.unfocus();
      if (formKey.currentState?.validate() == true) {
        UiHelper.showLoadingDialog();
        final input = AddAddressRequest(
          userId: AuthHelper.userId,
          addressId: null,
          city: cityController.text.trim(),
          address: addressController.text.trim(),
          streetFlat: buildingNameController.text.trim(),
          latitude: location.value?.latitude.toString() ?? '',
          longitude: location.value?.longitude.toString() ?? '',
          emirateId: selectedEmirateId.value ?? 0,
          addressName: selectedAddressType.value,
        );

        final result = await AddressRepository.addAddress(input);

        if (result.isNotEmpty) {
          UiHelper.showToast(result);
        }
        return true;
      }
      return false;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return false;
    } finally {
      UiHelper.closeLoadingDialog();
    }
  }

  Future<bool> handleEditAddress({int? addressId}) async {
    try {
      UiHelper.unfocus();
      if (formKey.currentState?.validate() == true) {
        UiHelper.showLoadingDialog();
        final input = AddAddressRequest(
          userId: AuthHelper.userId,
          addressId: addressId,
          city: cityController.text.trim(),
          address: addressController.text.trim(),
          streetFlat: buildingNameController.text.trim(),
          latitude: location.value?.latitude.toString() ?? '',
          longitude: location.value?.longitude.toString() ?? '',
          emirateId: selectedEmirateId.value ?? 0,
          addressName: selectedAddressType.value,
        );

        final result = await AddressRepository.addAddress(input);

        if (result.isNotEmpty) {
          UiHelper.showToast(result);
        }
        return true;
      }
      return false;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return false;
    } finally {
      UiHelper.closeLoadingDialog();
    }
  }
}
