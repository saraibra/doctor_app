import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/presentation/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/methods.dart';
import '../screens/book_appointment.dart';
import 'customized_button.dart';

class TopDoctorItem extends StatelessWidget {
  final DoctorEntity doctor;

  const TopDoctorItem({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.18,

        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorManager.grey, width: 1),
                  image: DecorationImage(
                    image: NetworkImage(doctor.imageUrl!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        doctor.name ,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Icon(Icons.star,color: Colors.yellow,
                      size: 16,
                      ),
                      Text( doctor.rating.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,

                      )
                    ],
                  ),
                  Text(
                    doctor.specialty,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(children: [
                    Icon(Icons.calendar_today,
                      color: ColorManager.primary,
                      size: 16,
                    ),
                    Text('  ${doctor.workingDays[0].dateTime.day} / ${doctor.workingDays[0].dateTime.month} / ${doctor.workingDays[0].dateTime.year}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                        color: ColorManager.primary,
                        size: 16,
                      ),
                      Text(

                        '  ${doctor.workingDays[0].appointments!.where((e) => e.booked == false)
                            .map((e) => '${e.startTime} - ${e.endTime}')
                            .join('  ')}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 2,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CustomizedButton(
                    color: ColorManager.primary,
                    text: 'Appoint now',
                    onTap: () {
                      navigateTo(
                        context: context,
                        widget: BookAppointment(doctor: doctor),
                      );
                      //BlocProvider.of<MainBloc>(context).add(BookAppointmentEvent(doctor));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
