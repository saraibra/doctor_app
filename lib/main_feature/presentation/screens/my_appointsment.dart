import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/core/utils/app_constants.dart';
import 'package:doctor_app/main_feature/presentation/screens/past_appointsment.dart';
import 'package:doctor_app/main_feature/presentation/screens/profile_screen.dart';
import 'package:doctor_app/main_feature/presentation/screens/user_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/main_bloc.dart';
import 'canceled_appointments.dart';

class MyAppointsment extends StatelessWidget {
  const MyAppointsment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "My Appointments",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                //color: AppBloc.get(context).isDark ? darkGrey : whiteScafoldColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    isScrollable: false,
                    dividerColor: Colors.transparent,
                    labelColor: ColorManager.primary,
                    indicatorColor: ColorManager.primary,
                    labelStyle: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    splashBorderRadius: BorderRadius.circular(20),
                    enableFeedback: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    unselectedLabelColor: Colors.grey,
                    labelPadding: const EdgeInsets.all(0),
                    onTap: (i) {
                      if (i == 2) {
                        // BlocProvider.of<MainBloc>(context)
                        //     .getAllCanceledBooking();
                      } else if (i == 1) {
                        // BlocProvider.of<MainBloc>(context)
                        //     .getAllCompletedBooking();
                        //print('state '+state.toString());
                      } else {
                        // BlocProvider.of<MainBloc>(context)
                        //     .getAllUpcommingBooking();
                      }
                    },
                    tabs: [
                      Tab(text: "Upcoming"),
                      Tab(text: 'Past'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  UpcommingAppointmentList(),
                  PastAppointmentList(),
                  CanceledAppointmentList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
