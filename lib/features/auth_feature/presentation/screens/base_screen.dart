import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/features/auth_feature/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../widgets/default_button.dart';
import 'sign_in_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  width: 200.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                  'assets/images/logo.png'),

               Text(
                'Start your health journey Today',
                style: Theme.of(context).textTheme.displayLarge,
              ),
               SizedBox(
                height: 8.h,
              ),
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 30.w),
                 child: Text(
                  'Take control of your health with our app.''\n''Book appointments,'
                      ' manage prescriptions,''\n''and connect with doctors'
                        'all in one place.',
                  maxLines: 4,
                  style: Theme.of(context).textTheme.bodySmall,
                               ),
               ),
               SizedBox(
                height: 40.h,
              ),
              DefaultButton(
                text: 'Sign In',
                color: ColorManager.primary,
                onTap: () {
                  navigateTo(context: context, widget: SignInScreen());

                },
              ),
              SizedBox(
                height: 16.h,
              ),
              DefaultButton(
                text: 'Sign Up',
                color: ColorManager.primary,
                isSignUp: true,
                onTap: () {
                  navigateTo(context: context, widget: SignUpScreen());

                },
              ),
            ],
          ),
        ),
      )
    );
  }}