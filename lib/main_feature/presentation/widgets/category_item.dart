import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart' ;

class CategoryItem extends StatelessWidget {
final String categoryName;
final String imageUrl;

  const CategoryItem({super.key, required this.categoryName, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(

      width:  MediaQuery.of(context).size.width*0.31,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset(imageUrl,
           height: MediaQuery.of(context).size.height*0.06,
             width:MediaQuery.of(context).size.width*0.18,
           ),
            //SizedBox(height: 10),
            Text(categoryName, style: TextStyle(fontSize: 12,
            color: ColorManager.primary
            )),
          ],
        ),
      ),
    );
  }}