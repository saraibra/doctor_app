import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../bloc/bloc/auth_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.type,
    this.onSubmitted,
    this.onChanged,
    this.validate,
    this.onTab,
    this.isPassword = false,
    required this.suffixIcon,
    required this.labelText,
  });
  final TextEditingController controller;
  final TextInputType type;
  final bool isPassword;
  final Widget suffixIcon;
  final String labelText;
  final onSubmitted;
  final onChanged;
  final validate;
  final onTab;

  @override
  Widget build(BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            controller: controller,
            keyboardType: type,
            onFieldSubmitted: onSubmitted,
            onChanged: onChanged,
            validator: validate,
            onTap: onTab,
            cursorColor: ColorManager.primary,

            obscureText:isPassword,
            style: Theme.of(context).textTheme.headlineLarge,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.darkGrey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.darkGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.darkGrey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.error),
              ),
              labelText: labelText,
              prefixIcon: suffixIcon,
              suffixIcon:SizedBox(),

              prefixIconColor: ColorManager.black,
              suffixStyle: TextStyle(color: ColorManager.black),
              labelStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

    );
  }
}
