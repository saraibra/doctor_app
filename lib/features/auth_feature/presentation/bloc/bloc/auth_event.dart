part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class SignInWithEmailEvent extends AuthEvent{
  final BuildContext context;

  SignInWithEmailEvent(this.context);
}
class SignUpWithEmailEvent extends AuthEvent{  final BuildContext context;

  SignUpWithEmailEvent(this.context);
}
class SignWithGoogleEvent extends AuthEvent{  final BuildContext context;

  SignWithGoogleEvent(this.context);
}
class ForgotPasswordEvent extends AuthEvent{  final BuildContext context;
ForgotPasswordEvent(this.context);
}
class ChangePasswordVisiblityEven extends AuthEvent{
  final BuildContext context;
  final bool passwordVisibility;
  ChangePasswordVisiblityEven(this.context, this.passwordVisibility);
}
class GetUserDataEvent extends AuthEvent{
GetUserDataEvent();
}
class LogoutEvent extends AuthEvent{  final BuildContext context;
LogoutEvent(this.context);
}