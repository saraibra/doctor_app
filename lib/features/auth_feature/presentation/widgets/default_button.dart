import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';


class DefaultButton extends StatelessWidget {
   DefaultButton({super.key, required this.text,this.isSignUp=false, this.onTap, required this.color});
  final String text;
  final Color color;
  bool isSignUp;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s16),
        child: Container(

          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              color:isSignUp?ColorManager.white: color,
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(AppSize.s16)),

          child: Center(child: Text(text,
          style:isSignUp? Theme.of(context).textTheme.titleMedium: Theme.of(context).textTheme.titleLarge,
          )),
        ));
  }
}
