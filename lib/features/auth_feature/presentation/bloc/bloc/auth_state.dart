part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class SignInWithEmailLoadingState extends AuthState {}

class SignInWithEmailSuccessState extends AuthState {}

class SignInWithEmailErrorState extends AuthState {
  final String error;

  SignInWithEmailErrorState(this.error);
}

class SignInWithGoogleLoadingState extends AuthState {}
class ChangePasswordVisibilityState extends AuthState {
  final bool passwordVisible;

  ChangePasswordVisibilityState({required this.passwordVisible});
  ChangePasswordVisibilityState copyWith({bool? passwordVisible}) {
    return ChangePasswordVisibilityState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
class SignInWithGoogleSuccessState extends AuthState {}

class SignInWithGoogleErrorState extends AuthState {
  final String error;

  SignInWithGoogleErrorState(this.error);
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpErrorState extends AuthState {
  final String error;

  SignUpErrorState(this.error);
}

class ForgotPasswordLoadingState extends AuthState {}

class ForgotPasswordSuccessState extends AuthState {}

class ForgotPasswordErrorState extends AuthState {
  final String error;

  ForgotPasswordErrorState(this.error);
}
class GetUserDataLoadingState extends AuthState {}

class GetUserDataSuccessState extends AuthState {}

class GetUserDataErrorState extends AuthState {
  final String error;

  GetUserDataErrorState(this.error);
}
class LogoutLoadingState extends AuthState {}
class LogoutSuccessState extends AuthState {}
