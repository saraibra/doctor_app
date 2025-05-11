import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width:  MediaQuery.of(context).size.height * 0.055,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(AppSize.s8)),
          child: Center(child: CircularProgressIndicator()),
        ));
  }
}