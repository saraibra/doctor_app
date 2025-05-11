import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';

class DecoratedButton extends StatelessWidget {
   DecoratedButton({super.key, required this.color, required this.text, this.onTap, required this.width, this.isWhite = false});
  final Color color;
  final String text;
  final double width;
  bool isWhite;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: width,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: ColorManager.primary),
              borderRadius: BorderRadius.circular(AppSize.s20)),
          child: Center(child: Text(text, style: TextStyle(color:isWhite?ColorManager.primary: ColorManager.white, fontSize: AppSize.s14, fontWeight: FontWeight.w500),)),
        ));
  }
}