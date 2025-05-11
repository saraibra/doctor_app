import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/main_feature/presentation/widgets/doctor_info_item.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_appointment.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/appointment_item.dart';

class UpcommingAppointmentList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  Container(
        color: ColorManager.primary.withOpacity(0.1),
height:  MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is GetAllAppointmentsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetAllDoctorsErrorState) {
                return Center(child: Text(state.errorMessage));
              }
              if (BlocProvider.of<MainBloc>(context).upCommingBooking.isNotEmpty) {
                List<UserAppointment> appointments = BlocProvider.of<MainBloc>(context).upCommingBooking;
                return ListView.separated(
                 // scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return AppointmentItem(appointment:  appointments[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: appointments.length,

                );
              }
              else {
                return Center(child: Text('No appointments yet'));
              }
            } ),

    );
  }
}