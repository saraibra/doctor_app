import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';
import '../bloc/main_bloc.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key, required this.timeSlots});
  final List <String> timeSlots ;

  @override
  Widget build(BuildContext context) {

   // String? selectedTime;
    return BlocBuilder<MainBloc, MainState>(
  builder: (context, state) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.arrow_back_ios, size: 18),
                Text(
                  "${ BlocProvider.of<MainBloc>(context).timeSlots.length} Slots",
                  style: TextStyle(color: Colors.grey),
                ),

                Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
            const SizedBox(height: 10),
            BlocProvider.of<MainBloc>(context). timeSlots.isEmpty?Column(
           children: [
             SizedBox(height:  MediaQuery.of(context).size.height*0.1,),
             Center(
               child: Text("No Slots Available"),
             ),
           ],
         ):   Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
              BlocProvider.of<MainBloc>(context).timeSlots.map((times) {

                    final isSelected = BlocProvider.of<MainBloc>(context).selectedTime ==times;
                    return InkWell(
                      onTap: (){
                        BlocProvider.of<MainBloc>(context).add(
                          SelectTimeSlotEvent(time: times),
                        );
                      },
                     
                      child: Container(
                        width:  MediaQuery.of(context).size.width*0.25,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:isSelected? ColorManager.primary
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            times,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? ColorManager.primary
                                      : ColorManager.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
