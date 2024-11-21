import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticateWithPassword extends AuthenticationEvent {
  final String password;

  AuthenticateWithPassword(this.password);

  @override
  List<Object> get props => [password];
}

class AuthenticateWithFingerprint extends AuthenticationEvent {

}

class AuthenticateWithFaceID extends AuthenticationEvent {

}

class AuthenticateWithPIN extends AuthenticationEvent {
  final String pin;

  AuthenticateWithPIN(this.pin);
}