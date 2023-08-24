abstract class AuthState {}

class AuthInitialState extends AuthState {}
class UnAuthenticatedState extends AuthState {}
class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
class AuthVerifySuccessState extends AuthState {}
class AuthCheckTheCodeState extends AuthState {}
class AuthRegisterState extends AuthState {}
class AuthLoggedState extends AuthState {}
class AuthLoadingState extends AuthState {}
