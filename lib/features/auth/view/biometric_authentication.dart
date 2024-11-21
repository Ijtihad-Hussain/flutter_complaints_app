import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../complaints/view/compalints_page.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';
import 'auth_with_password.dart';

class BiometricAuthentication extends StatelessWidget {
  const BiometricAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Biometric Authentication')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _authenticateWithFingerPrint(context),
            child: Text('Authenticate with Fingerprint'),
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationLoading) {
              } else if (state is AuthenticationSuccess) {
                Fluttertoast.showToast(
                  msg: "You are authorized",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                // Navigate to the Complaints Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintsPage()),
                );
              } else if (state is AuthenticationFailure) {
                Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: Container(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticateWithFaceID());
            },
            child: Text('Authenticate with Face ID'),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthWithPassword()),
              );
            },
            child: Text('Authenticate with Password'),
          ),
        ],
      ),
    );
  }

  void _authenticateWithFingerPrint(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticateWithFingerprint());
  }

}