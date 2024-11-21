import 'package:flutter/material.dart';
import 'package:flutter_auth_app/features/auth/view/biometric_authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/bloc/authentication_bloc.dart';
import 'features/auth/user_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(UserRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BiometricAuthentication(),
      ),
    );
  }
}