import 'dart:async';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationHelper {
  static const String mapAPIKEY = '';
  //
  static Location location = Location();

  static Future<bool> isLocationEnabled() async {
    bool serviceEnabled = false;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    return serviceEnabled;
  }

  static Future<bool> hasLocationPermission() async {
    PermissionStatus permissionGranted;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    return permissionGranted == PermissionStatus.granted;
  }

  static Future<geocoding.Placemark?> getAddressFromLatLan(
    double? latitude,
    double? longitude,
  ) async {
    if (latitude == null || longitude == null) {
      return null;
    } else {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        // Prefer the placemark with the most fields filled in (locality + subLocality
        // are the most stable — street numbers can flip for small GPS jitter).
        geocoding.Placemark currentPlacemark = placemarks.reduce((a, b) {
          int scoreA = _placemarkScore(a);
          int scoreB = _placemarkScore(b);
          return scoreA >= scoreB ? a : b;
        });
        return currentPlacemark;
      }
    }
    return null;
  }

  static Future<ResolvedLocation?> resolveLocationDetails(
    double? latitude,
    double? longitude,
  ) async {
    final placemark = await getAddressFromLatLan(latitude, longitude);

    if (placemark == null) {
      return null;
    }

    final addressParts =
        [
              placemark.street,
              placemark.subLocality,
              placemark.locality,
              placemark.administrativeArea,
            ]
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList();

    return ResolvedLocation(
      fullAddress: addressParts.join(', '),
      pincode: placemark.postalCode ?? '',
    );
  }

  static Future<LatLng> getCurrentLocation() async {
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
      distanceFilter: 0,
    );

    // Try one-shot first — faster and works with network/WiFi location,
    // which is available immediately even right after GPS is turned on.
    try {
      final oneShot = await location.getLocation().timeout(
        const Duration(seconds: 8),
      );
      final latLng = _toLatLng(oneShot);
      if (latLng != null) return latLng;
    } on TimeoutException {
      // fall through to stream
    } catch (_) {
      // fall through to stream
    }

    // Fall back to stream to wait for a fresh GPS fix.
    try {
      final fresh = await location.onLocationChanged
          .map(_toLatLng)
          .firstWhere((value) => value != null)
          .timeout(const Duration(seconds: 20));

      if (fresh != null) return fresh;
    } on TimeoutException {
      // fall through
    }

    throw Exception(
      'Unable to get your current location. Please ensure GPS is enabled and try again.',
    );
  }

  // static Future<LatLng?> _fetchLocation({
  //   required LocationAccuracy accuracy,
  //   required Duration timeout,
  // }) async {
  //   await location.changeSettings(
  //     accuracy: accuracy,
  //     interval: 1000,
  //     distanceFilter: 0,
  //   );

  //   try {
  //     final currentLocation = await location.getLocation().timeout(timeout);
  //     final latLng = _toLatLng(currentLocation);

  //     if (latLng != null) {
  //       return latLng;
  //     }
  //   } on TimeoutException {
  //     return null;
  //   }

  //   try {
  //     final streamedLocation = await location.onLocationChanged
  //         .map(_toLatLng)
  //         .firstWhere((value) => value != null)
  //         .timeout(timeout);

  //     if (streamedLocation != null) {
  //       return streamedLocation;
  //     }
  //   } on TimeoutException {
  //     return null;
  //   }

  //   return null;
  // }

  static int _placemarkScore(geocoding.Placemark p) {
    return [
      p.locality,
      p.subLocality,
      p.administrativeArea,
      p.postalCode,
      p.street,
    ].where((v) => v != null && v.trim().isNotEmpty).length;
  }

  static LatLng? _toLatLng(LocationData locationData) {
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      return null;
    }

    return LatLng(latitude, longitude);
  }

  static Future<String> getFullAddress(
    double? latitude,
    double? longitude,
  ) async {
    final resolvedLocation = await resolveLocationDetails(latitude, longitude);
    return resolvedLocation?.fullAddress ?? '';
  }

  static Future<String> getPincode(double? latitude, double? longitude) async {
    final resolvedLocation = await resolveLocationDetails(latitude, longitude);
    return resolvedLocation?.pincode ?? '';
  }
}

class ResolvedLocation {
  final String fullAddress;
  final String pincode;

  const ResolvedLocation({required this.fullAddress, required this.pincode});
}
