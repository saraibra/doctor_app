import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({super.key, required this.color, required this.text, this.onTap});
final Color color;
final String text;
final onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.032,
          width:  MediaQuery.of(context).size.width * 0.27,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSize.s20)),
          child: Center(child: Text(text, style: TextStyle(color: ColorManager.black, fontSize: AppSize.s14, fontWeight: FontWeight.w500),)),
        ));
  }
}