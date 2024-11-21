
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import '../user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(AuthenticationInitial()) {

    on<AuthenticateWithPassword>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final success = await userRepository.authenticateWithPassword(event.password);
        if (success) {
          emit(AuthenticationSuccess());
        } else {
          emit(AuthenticationFailure("Authentication failed"));
        }
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });

    on<AuthenticateWithFingerprint>((event, emit) async {
      emit(AuthenticationLoading());
      final LocalAuthentication localAuth = LocalAuthentication();

      try {
        // Check if the device supports biometric authentication
        bool isBiometricSupported = await localAuth.isDeviceSupported();
        bool canCheckBiometrics = await localAuth.canCheckBiometrics;

        if (isBiometricSupported && canCheckBiometrics) {
          // Attempt to authenticate using biometrics
          bool isAuthenticated = await localAuth.authenticate(
            localizedReason: 'Please authenticate to access this feature',
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
            ),
          );

          print('isAu $isAuthenticated');

          if (isAuthenticated) {
            emit(AuthenticationSuccess());
          } else {
            emit(AuthenticationFailure("Fingerprint authentication failed"));
          }
        } else {
          emit(AuthenticationFailure("Biometric authentication is not available"));
        }
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });

    on<AuthenticateWithFaceID>((event, emit) async {
      final LocalAuthentication auth = LocalAuthentication();

      try {
        // Check if the device supports biometric authentication
        bool canCheckBiometrics = await auth.canCheckBiometrics;
        bool isDeviceSupported = await auth.isDeviceSupported();

        if (canCheckBiometrics && isDeviceSupported) {
          // Attempt to authenticate using Face ID
          bool isAuthenticated = await auth.authenticate(
            localizedReason: 'Please authenticate to access your account',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (isAuthenticated) {
            emit(AuthenticationSuccess());
          } else {
            emit(AuthenticationFailure("FaceId authentication failed"));
          }
        }

      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });

    on<AuthenticateWithPIN>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        if (event.pin == '1234') {
          emit(AuthenticationSuccess());
        } else {
          emit(AuthenticationFailure("PIN authentication failed"));
        }
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });
  }
}