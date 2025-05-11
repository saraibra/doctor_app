import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/presentation/widgets/customized_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_bloc.dart';
import '../screens/book_appointment.dart';

class DoctorInfoItem extends StatelessWidget {
  const DoctorInfoItem({Key? key, required this.doctor}) : super(key: key);
  final DoctorEntity doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.03,
        //top: MediaQuery.of(context).size.height * 0.001,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.022,
                ),
                Text(
                  doctor.name,
                  style: TextStyle(color: ColorManager.white, fontSize: 20),
                ),
                Text(
                  doctor.specialty,
                  style: TextStyle(color: ColorManager.white, fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.009,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.084,
                  width:  MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    doctor.bio,
                    maxLines: 4,

                    style: TextStyle(color: ColorManager.white, fontSize: 12,
                    overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.009,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {

                      },
                      label: Text('contact', style: TextStyle(color: ColorManager.white)),
                      icon: Icon(Icons.phone, color: ColorManager.white),
                    ),
                    CustomizedButton(color: ColorManager.white,text: 'Appoint now',onTap: (){
                      navigateTo(context: context, widget: BookAppointment(doctor: doctor,));
                      //BlocProvider.of<MainBloc>(context).add(BookAppointmentEvent(doctor));
                    },)
                  ],
                ),
              ],
            ),
            Positioned(
             // top: MediaQuery.of(context).size.height*0.0001,
              right:  MediaQuery.of(context).size.width *0.001,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.29,
                height: MediaQuery.of(context).size.height * 0.265,


                child: Image.network(doctor.imageUrl??'https://firebasestorage.googleapis.com/v0/b/todolistexample-ef1bb.appspot.com/o/doctor2.png?alt=media&token=e826885a-50d7-4af9-a163-676e38144263'
                  ,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
