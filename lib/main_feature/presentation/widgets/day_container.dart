import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';

class DayContainer extends StatelessWidget {
  const DayContainer({super.key, required this.date, required this.text, required this.isToday, required this.isSelected});
  final String text;
  final String date;
  final bool isToday;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.085,
      width: MediaQuery.of(context).size.width * 0.11,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s20),
        border: Border.all(color:isSelected||isToday?ColorManager.primary: ColorManager.darkGrey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: TextStyle(
              color:isSelected||isToday?ColorManager.black: ColorManager.darkGrey,
              fontSize: AppSize.s14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width:MediaQuery.of(context).size.width * 0.08 ,
            height: MediaQuery.of(context).size.width * 0.08 ,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:isSelected|| isToday?ColorManager.primary: ColorManager.grey,

            ),
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  color:isToday?ColorManager.white: ColorManager.darkGrey,
                  fontSize: AppSize.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
