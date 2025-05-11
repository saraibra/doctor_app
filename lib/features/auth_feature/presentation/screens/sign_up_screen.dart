import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/icon_broken.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/default_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios),
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
            key: signUpFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                    suffixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Name',
                    controller:
                        BlocProvider.of<AuthBloc>(context).nameController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value.isEmpty) {
                        return AppStrings.kFNamelNullError;
                      }
                    }
                    ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormField(
                    suffixIcon: Icon(Icons.phone),
                    labelText: 'Phone',
                    controller:
                    BlocProvider.of<AuthBloc>(context).phoneController,
                    type: TextInputType.number,
                    validate: (value) {
                      if (value.isEmpty) {
                        return AppStrings.kphoneNullError;
                      }
                    }
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormField(
                  suffixIcon: const Icon(Icons.email_outlined),
                  labelText: 'Email',
                  validate: (value) {
                    if (value.isEmpty) {
                      return AppStrings.kEmailNullError;
                    } else if (!AppStrings.emailValidatorRegExp
                        .hasMatch(value)) {
                      return AppStrings.kInvalidEmailError;
                    }
                  },
                  controller: BlocProvider.of<AuthBloc>(context).emailController,
                  type: TextInputType.name,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormField(
                //  prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.visibility)),

                  suffixIcon: const Icon(Icons.lock_outline),
                  labelText: 'Password',
                  controller:
                      BlocProvider.of<AuthBloc>(context).passwordController,
                          validate: (value) {
                      if (value.isEmpty) {
                        return AppStrings.kPassNullError;
                      }
                      else if(value.toString().length<6){
                        return AppStrings.kShortPassError;

                      }
                    },
                  type: TextInputType.text,
                  isPassword: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                
                state is SignUpLoadingState ?Center(child: CircularProgressIndicator()): DefaultButton(
                  color: ColorManager.primary,

                  text: 'Sign Up',
                  onTap: () {
                  if (signUpFormKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignUpWithEmailEvent(context));}
                  },
                ),
              ],
            ),
          ),
        );
  },
));
  }
}
