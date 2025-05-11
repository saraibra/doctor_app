import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/icon_broken.dart';
import '../../../../core/resources/string_manager.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/default_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          title: const Text("Forgot Password"),
          centerTitle: true,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).clearData();

              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Form(
           key: forgotPasswordFormKey,
            child: Column(children: [
              SizedBox(height: ScreenUtil().setHeight(32)),
              CustomTextFormField(
                suffixIcon: const Icon(Icons.email_outlined),
                labelText: 'Email',
                validate: (value) {
                  if (value.isEmpty) {
                    return AppStrings.kEmailNullError;
                  } else if (!AppStrings.emailValidatorRegExp.hasMatch(value)) {
                    return AppStrings.kInvalidEmailError;
                  }
                },
                controller: BlocProvider.of<AuthBloc>(context).emailController,
                type: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              DefaultButton(
                text: 'Send',
                color: ColorManager.primary,
                onTap: () {
    if (forgotPasswordFormKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(ForgotPasswordEvent(context));}
                },
              ),
              SizedBox(height: 24.h),
            ]),
          ),
        ),
      ),
    );
  }
}
