import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_home_page.dart';
import 'permission/cubit/permission_cubit.dart';
import 'permission/permission_repositories.dart';

void main() {
  runApp(MyApp(
    permissionRepositories: PermissionRepositories(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.permissionRepositories});
  final PermissionRepositories permissionRepositories;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionCubit(
              permissionRepositories,
          ),
        ),
        
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    ),
    );
  }
}