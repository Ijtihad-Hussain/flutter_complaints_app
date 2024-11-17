import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticateEvent extends AuthenticationEvent {
  final String password;

  AuthenticateEvent(this.password);

  @override
  List<Object> get props => [password];
}