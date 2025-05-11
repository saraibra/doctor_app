import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/icon_broken.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/utils/methods.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/default_button.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).clearData();
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Form(
              key: signInFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    suffixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    validate: (value) {
                      if (value.isEmpty) {
                        return AppStrings.kEmailNullError;
                      } else if (!AppStrings.emailValidatorRegExp.hasMatch(
                        value,
                      )) {
                        return AppStrings.kInvalidEmailError;
                      }
                    },
                    controller:
                        BlocProvider.of<AuthBloc>(context).emailController,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
              CustomTextFormField(

              suffixIcon: const Icon(Icons.lock_outline),
              labelText: 'Password',
              validate: (value) {
                if (value.isEmpty) {
                  return AppStrings.kPassNullError;
                } else if (value.toString().length < 6) {
                  return AppStrings.kShortPassError;
                }
              },
              controller:
              BlocProvider.of<AuthBloc>(context).passwordController,
              type: TextInputType.text,
              isPassword: true,
          ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        navigateTo(
                          context: context,
                          widget: ForgotPasswordScreen(),
                        );
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  state is SignInWithEmailLoadingState
                      ? Center(child: CircularProgressIndicator(),)
                      : DefaultButton(
                        text: 'Sign In',
                        color: ColorManager.primary,
                        onTap: () {
                          if (signInFormKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(
                              context,
                            ).add(SignInWithEmailEvent(context));
                          }
                        },
                      ),
                  TextButton(
                    onPressed: () {
                      navigateTo(context: context, widget: SignUpScreen());
                      BlocProvider.of<AuthBloc>(context).clearData();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have  an account? ',
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' Sign Up',
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
