import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/main_feature/domain/entities/user_appointment.dart';
import 'package:doctor_app/main_feature/presentation/widgets/customized_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../bloc/main_bloc.dart';
import '../screens/book_appointment.dart';
import 'decorated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentItem extends StatelessWidget {
  final UserAppointment appointment;
  const AppointmentItem({super.key, required this.appointment});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(appointment.doctorName),
              subtitle: Text(appointment.doctorSpecialty),
              trailing: Container(

                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    appointment.isBooked
                        ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                          child: Text(
                            'Upcoming',
                            style: TextStyle(color: ColorManager.primary),
                          ),
                        )
                        : Text(
                          'Canceled',
                          style: TextStyle(color: ColorManager.primary),
                        ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.calendar_today, color: ColorManager.primary),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(DateFormat.yMMMMEEEEd().format(appointment.date),
                     // "${appointment.date.day} ${DateFormat('MMM').format(DateTime(0, currentMonthIndex))appointment.date..month} ${appointment.date.year}",
                      style: TextStyle(color: ColorManager.primary),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: ColorManager.primary,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Icon(Icons.access_time, color: ColorManager.primary),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      "${appointment.date.hour} : ${appointment.date.minute}",
                      style: TextStyle(color: ColorManager.primary),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment:  appointment.isCanceled?MainAxisAlignment.center: MainAxisAlignment.spaceEvenly,
              children: [
                DecoratedButton(
                 width:    appointment.isCanceled?MediaQuery.of(context).size.width*0.6 :  MediaQuery.of(context).size.width * 0.3,
                  color: ColorManager.primary,
                  text: 'Reschedule ',
                  onTap: () {
                   navigateTo(context: context, widget: BookAppointment(doctor: BlocProvider.of<MainBloc>(context).getSelectedDoctor(appointment.doctorId),isReschedule: true,));
                    // Handle cancel appointment action
                  },
                ),
              appointment.isCanceled?SizedBox():  DecoratedButton(
                  width:  MediaQuery.of(context).size.width * 0.3,
                  isWhite: true,
                  color: ColorManager.white,
                  text: 'Cancel ',
                  onTap: () {
                    BlocProvider.of<MainBloc>(context).add(
                      CancelAppointmentEvent(appointment,context),
                    );
                    // Handle cancel appointment action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
