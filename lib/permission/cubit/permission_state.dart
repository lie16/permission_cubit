part of 'permission_cubit.dart';

@immutable
abstract class PermissionState {}

class PermissionRequestInitial extends PermissionState {}

class PermissionRequestDenied extends PermissionState {}

class PermissionRequestGranted extends PermissionState {}

class PermissionRequestPermanentlyDenied extends PermissionState {}

class PermissionRequestAllSuccess extends PermissionState {
  final Map<Permission, PermissionStatus> permissionStatus;
  
  PermissionRequestAllSuccess({
    required this.permissionStatus,
  });
}

class PermissionRequestAllFailed extends PermissionState {
  final Map<Permission, PermissionStatus> permissionStatus;
  
  PermissionRequestAllFailed({
    required this.permissionStatus,
  });
}

class PermissionRequestOpenAppSettings extends PermissionState {
  final bool result;
  
  PermissionRequestOpenAppSettings({
    required this.result,
  });
}