part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errorMessage;
  RegisterFailure({required this.errorMessage});
}

class ResetPasswordStarted extends AuthState {}

class ResetPasswordFailed extends AuthState {
  final String errMessage;
  ResetPasswordFailed({required this.errMessage});
}

class ResetPasswordSuccessed extends AuthState {}
