import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'permission/cubit/permission_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionCubit, PermissionState>(
        builder: (context, permissionState) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Permission'),
        ),
        body: Center(
          child: const Text(
            'Permission test',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            gpsOnPressed(permissionState);
          },
          tooltip: 'Permission',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }

  void gpsOnPressed(PermissionState permissionState) async {
    log("Gps On Pressed");
    // if(permissionState is PermissionRequestOpenAppSettings){
    //   BlocProvider.of<PermissionCubit>(context).requestLocationPermission();
    // } else {
    //   BlocProvider.of<PermissionCubit>(context).requestLocationPermission();
    // }
    BlocProvider.of<PermissionCubit>(context).requestLocationPermission();

    log('permission state gps = $permissionState');
    if (permissionState is PermissionRequestDenied) {
      // disini sudah dihandle oleh package
      log("Permission Request Denied");
    }

    if (permissionState is PermissionRequestPermanentlyDenied) {
      // Todo tambah dialog buat minta dia terima permission, dan arahkan ke setting
      log("Permission Request Permanently Denied");
      dialogBuilder(context, permissionState)
          .then((value) => log('dialog uud selesai'));
    }

    if (permissionState is PermissionRequestGranted) {
      log("Permission Request Granted");
    }
    log('selesai duluan');
  }

  Future<void> dialogBuilder(
    BuildContext context,
    PermissionState permissionState,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Location permission are required',
          ),
          content: Text("Pleace allow location permission."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('no'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<PermissionCubit>(context).openAppSetting();
                Navigator.of(context).pop();
              },
              child: Text(
                'open setting',
              ),
            ),
          ],
        );
      },
    );
  }
}
