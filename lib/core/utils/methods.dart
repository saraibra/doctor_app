import 'package:flutter/material.dart';

import '../errors/failure.dart';
import '../resources/string_manager.dart';

navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
navigateAndFinish({required BuildContext context, required Widget widget}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
         String getFailureErrorMessage(Failure failure) {
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
