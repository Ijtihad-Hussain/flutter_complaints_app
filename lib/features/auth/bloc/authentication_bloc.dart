
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(AuthenticationInitial()) {
    on<AuthenticateEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final success = await userRepository.authenticate(event.password);
        if (success) {
          emit(AuthenticationSuccess());
        } else {
          emit(AuthenticationFailure("Authentication failed"));
        }
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });
  }
}