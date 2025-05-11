import 'package:flutter/material.dart';

import 'color_manager.dart';

class AppStrings {
  static const noRouteFound = "No Route Found";
  static const unexpectedError = "Unexpected error , please try again later";
  static const offlineErrpr = "Please Check your Internet Connecton";
  static const cashError = "No data";
  static const serverError = "Please try again later";
  static const login = "Login";
  static const signUp = "Sign up";
  static const email = "Email";
  static const imageUrls = ['assets/images/heart.png','assets/images/tooth.png','assets/images/visible.png','assets/images/skin.png','assets/images/stethoscope.png','assets/images/brain.png'];
  static const specialties =['Cardiologist','Dentist','Ophthalmologist','Dermatologist','Pediatrician','Neurologist'];
  static const password = "Password";
  static const fName = "First Name";
  static const lName = "Last Name";

// Form Error
  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please enter your email";
  static const String kInvalidEmailError = "Invalid email";
  static const String kPassNullError = "  Please enter password";
  static const String kShortPassError = " Password is too short";
  static const String kFNamelNullError = "Please enter your first name";
  static const String kLNamelNullError = "Please enter your last name";

  static const String kphoneNullError= "Please enter your last name";


}
