import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepositories {
  PermissionRepositories();

  Future<int> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

    log('handle permission');
    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('service Not Enabled');
      return 0;
    }

    permission = await geolocatorPlatform.checkPermission();
    log('cek permission $permission');

    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      log('permission denied = $permission');
      if (permission == LocationPermission.denied) {
        return 0;
      }
      if (permission == LocationPermission.deniedForever) {
        return 1;
      } else {
        return 2;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return 1;
    } else {
      return 2;
    }
    // geolocatorPlatform.getLocationAccuracy();
  }

  Future<Map<Permission, PermissionStatus>> requestAllPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();
    log('repo request');
    return statuses;
  }

  Future<PermissionStatus> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    return status;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    log('$status');
    if (status.isDenied) {
      log('status is Denied');
      status = await Permission.location.request();
      log('status res = $status');
    }
    return status;
  }

  Future<bool> openAppSetting() {
    return openAppSettings();
  }
}
