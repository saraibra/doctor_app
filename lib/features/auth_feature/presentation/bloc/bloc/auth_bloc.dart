import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_app/core/utils/cashe_helper.dart';
import 'package:doctor_app/features/auth_feature/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/methods.dart';
import '../../../../../main_feature/presentation/screens/main_screen.dart'
    show MainScreen;
import '../../../domain/usecases/email_sign_in.dart';
import '../../../domain/usecases/forgot_password.dart';
import '../../../domain/usecases/get_user_data.dart';
import '../../../domain/usecases/google_sign_in.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/register_user.dart';
import '../../../domain/usecases/update_user_data.dart';
import '../../screens/sign_in_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
   User? userData ;
  final EmailLoginUseCase emailLoginUseCase;
  final GoogleSigninUseCase googleSigninUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final LogoutUseCase logoutUseCase;
  bool passwordVisibility = true;
  AuthBloc(
    this.emailLoginUseCase,
    this.googleSigninUseCase,
    this.registerUseCase,
    this.forgotPasswordUseCase,
    this.updateUserDataUseCase,
    this.getUserDataUseCase, this.logoutUseCase,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInWithEmailEvent) {
        emit(SignInWithEmailLoadingState());
        final Either<Failure, Unit> result = await emailLoginUseCase.call(
          email: emailController.text,
          password: passwordController.text,
        );
        result.fold(
          (failure) =>
              emit(SignInWithEmailErrorState(_getFailureErrorMessage(failure))),
          (r) {
            emit(SignInWithEmailSuccessState());
            navigateTo(context: event.context, widget: MainScreen());
            clearData();
          },
        );
      } else if (event is SignUpWithEmailEvent) {
        emit(SignUpLoadingState());

        final Either<Failure, Unit> result = await registerUseCase.call(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneController.text,
        );
        result.fold(
          (failure) => emit(SignUpErrorState(_getFailureErrorMessage(failure))),
          (result) {
            emit(SignUpSuccessState());
            navigateTo(context: event.context, widget: MainScreen());
            clearData();
          },
        );
      } else if (event is ForgotPasswordEvent) {
        emit(ForgotPasswordLoadingState());

        final Either<Failure, Unit> result = await forgotPasswordUseCase.call(
          email: emailController.text,
        );
        result.fold(
          (failure) =>
              emit(ForgotPasswordErrorState(_getFailureErrorMessage(failure))),
          (result) {
            emit(ForgotPasswordSuccessState());
            navigateTo(context: event.context, widget: SignInScreen());
            clearData();
          },
        );
      } else if (event is SignWithGoogleEvent) {
        emit(SignInWithGoogleLoadingState());
        final Either<Failure, Unit> result = await googleSigninUseCase.call();
        result.fold(
          (failure) => emit(
            SignInWithGoogleErrorState(_getFailureErrorMessage(failure)),
          ),
          (result) => emit(SignInWithGoogleSuccessState()),
        );
      }
      else if (event is GetUserDataEvent) {
        emit(GetUserDataLoadingState());
        String uid = CasheHelper.getData(key: 'uid') ?? '';
        final Either<Failure, User> result = await getUserDataUseCase.call(uid: uid);
        result.fold(
          (failure) =>
              emit(GetUserDataErrorState(_getFailureErrorMessage(failure))),
          (result) {
            userData = result;


            emit(GetUserDataSuccessState());
            //navigateTo(context: event.context, widget: MainScreen());
          },
        );
      } else
      if(event is ChangePasswordVisiblityEven){
        passwordVisibility = !event.passwordVisibility;
        print(passwordVisibility);

        emit(ChangePasswordVisibilityState(
          passwordVisible: passwordVisibility,
        ));
      }
      if(event is LogoutEvent){
        emit(LogoutLoadingState());
        final Either<Failure, Unit> result = await logoutUseCase.call(
        );
        result.fold(
          (failure) =>
              emit(SignInWithEmailErrorState(_getFailureErrorMessage(failure))),
          (r) {
            CasheHelper.removeData(key: 'uid');
            navigateAndFinish(context: event.context, widget: SignInScreen());
            emit(LogoutSuccessState());

            clearData();
          },
        );
      }
    });
  }

  String _getFailureErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverError;
      case EmptyCasheFailure:
        return AppStrings.cashError;
      case OfflineFailure:
        return AppStrings.offlineErrpr;
      default:
        return AppStrings.unexpectedError;
    }
  }
   changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
   // emit(ChangePasswordVisibilityState());
    }
  String vaildateEmail(String value) {
    if (value.isEmpty) {
      return AppStrings.kEmailNullError;
    } else if (!AppStrings.emailValidatorRegExp.hasMatch(value)) {
      return AppStrings.kInvalidEmailError;
    }
    // ignore: curly_braces_in_flow_control_structures
    else
      return '';
  }

  clearData() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    return super.close();
  }
}
