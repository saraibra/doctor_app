import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../screens/filtered_screen.dart';

class SearchTextFormField extends StatelessWidget {
  SearchTextFormField({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    this.validate,
    this.onTab,

  });
  final TextEditingController controller;

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
        keyboardType: TextInputType.text,
        onFieldSubmitted: onSubmitted,
    onChanged:onChanged,
        validator: validate,
        onTap: onTab,
        cursorColor: ColorManager.primary,
        style: Theme.of(context).textTheme.headlineLarge,
        decoration: InputDecoration(
          filled: true,
          focusColor:ColorManager.white,
          fillColor:ColorManager.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.white),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.error),
          ),
          labelText: 'Search',
          prefixIcon: Icon(Icons.search_rounded),

          prefixIconColor: ColorManager.black,
          suffixStyle: TextStyle(color: ColorManager.black),
          labelStyle: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

    );
  }
}
