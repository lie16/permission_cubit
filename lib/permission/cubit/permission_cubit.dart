import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../permission_repositories.dart';


part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionRepositories repository;
  PermissionCubit(this.repository) : super(PermissionRequestInitial());

  void requestCameraPermission() {
    emit(
      PermissionRequestInitial(),
    );

    repository.requestCameraPermission().then((value) {
      handlingPermission(value);
    });
  }

  void requestLocationPermission() {
    emit(
      PermissionRequestInitial(),
    );
    log(' cubit req initial');

    repository.requestLocationPermission().then((value) {
      handlingPermission(value);
    });
  }

  void requestAllPermission() {
    emit(
      PermissionRequestInitial(),
    );
    log('requestAllPermission');

    repository.requestAllPermission().then((value) {
      if (value[Permission.camera] == PermissionStatus.denied ||
          value[Permission.location] == PermissionStatus.denied ||
          value[Permission.storage] == PermissionStatus.denied) {
        emit(
          PermissionRequestAllFailed(
            permissionStatus: value,
          ),
        );
      }
      emit(
        PermissionRequestAllSuccess(
          permissionStatus: value,
        ),
      );
    });
  }

  void openAppSetting(){
    emit(
      PermissionRequestInitial(),
    );
    log('open app setting');
    repository.openAppSetting().then((value) {
      log('open app setting value =$value');
      emit(PermissionRequestOpenAppSettings(result: value));
      // emit(PermissionRequestInitial());
    });
    
  }

  void handlingPermission(PermissionStatus value) {
    if (value == PermissionStatus.granted) {
      emit(
        PermissionRequestGranted(),
      );
    }
    if (value == PermissionStatus.denied) {
      emit(
        PermissionRequestDenied(),
      );
    }
    if (value == PermissionStatus.permanentlyDenied) {
      emit(
        PermissionRequestPermanentlyDenied(),
      );
    }
  }

  
}
