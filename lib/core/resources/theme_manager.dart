import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.accentColor,
    // ripple effect color
    // cardview theme
iconTheme: IconThemeData(
  color: ColorManager.darkGreen
),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.darkGrey,
    ),
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),

    // app bar theme
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManager.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: ColorManager.white,
        ),
        color: ColorManager.white,
        elevation: AppSize.s0,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s20, color: ColorManager.black)),
    // button theme

        timePickerTheme: TimePickerThemeData(
         dayPeriodColor:  ColorManager.darkGreen,
         dialHandColor: ColorManager.darkGreen,
            confirmButtonStyle: ButtonStyle(foregroundColor:WidgetStateProperty.all<Color>( ColorManager.darkGreen)),

            cancelButtonStyle: ButtonStyle(foregroundColor:WidgetStateProperty.all<Color>( ColorManager.darkGreen))
         // backgroundColor: Colors.black,
        ),
    buttonTheme: ButtonThemeData(

        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.accentColor),
    scaffoldBackgroundColor: ColorManager.white,

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s17),
          //  primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: ColorManager.black, fontSize: FontSize.s14),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.black, fontSize: FontSize.s18),
        headlineMedium: getRegularStyle(
            color: ColorManager.black, fontSize: FontSize.s12),
        titleMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s18),
            titleLarge:  getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s12),
        bodyLarge: getRegularStyle(color: ColorManager.grey),
        bodySmall: getRegularStyle(color: ColorManager.black),
        bodyMedium:
            getBoldStyle(color: ColorManager.darkGreen, fontSize: FontSize.s16),
        labelSmall:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s12)),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
            
        errorStyle: getRegularStyle(color: ColorManager.error),
        border:  OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
              disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
