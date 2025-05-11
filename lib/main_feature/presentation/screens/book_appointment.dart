import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/presentation/screens/user_appointments.dart';
import 'package:doctor_app/main_feature/presentation/widgets/day_container.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/color_manager.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/decorated_button.dart';
import '../widgets/select_time_widget.dart';
import 'main_screen.dart';

class BookAppointment extends StatelessWidget {
  final DoctorEntity doctor;
  final isReschedule;

  const BookAppointment({
    super.key,
    required this.doctor,
    this.isReschedule = false,
  });

  @override
  Widget build(BuildContext context) {
    final weekDates = BlocProvider.of<MainBloc>(context).getCurrentWeekDates();

    BlocProvider.of<MainBloc>(context).getTimeSlots(doctor, DateTime.now());
    //
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.grey,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        (MediaQuery.of(context).size.width *
                                            0.09),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.arrow_back_ios),
                                            ),

                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.1,
                                            ),
                                            isReschedule
                                                ? Text(
                                                  'Reschedule Appointment',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                )
                                                : Text(
                                                  'Appointment',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                          ],
                                        ),

                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.02,
                                        ),

                                        Text(
                                          doctor.name,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        Text(
                                          doctor.specialty,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.01,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.5,
                                          child: Text(
                                            doctor.bio,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ColorManager.darkGrey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 5,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.01,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on, size: 18),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.4,
                                              child: Text(
                                                " " + doctor.location.address!,
                                                maxLines: 4,

                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ColorManager.darkGrey,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top:
                                MediaQuery.of(context).size.height *
                                0.13, // adjust this value to move it lower
                            right: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Image.network(
                                doctor.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.44,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        //height: 1500.h,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(50),
                            topStart: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    isReschedule
                                        ? Text(
                                          'Select New date ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.black,
                                          ),
                                        )
                                        : Text(
                                          'Select date ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                    Spacer(),
                                    Icon(Icons.arrow_back_ios, size: 18),
                                    Text(
                                      DateFormat(
                                        'MMMM yyyy',
                                      ).format(DateTime.now()),
                                      style: TextStyle(color: Colors.grey),
                                    ),

                                    Icon(Icons.arrow_forward_ios, size: 18),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),

                              BlocBuilder<MainBloc, MainState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:
                                        weekDates.map((date) {
                                          // DateTime selectedDate =   BlocProvider.of<MainBloc>( context).selected!;
                                          bool isToday =
                                              date.day ==
                                                  BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).today.day &&
                                              date.month ==
                                                  BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).today.month &&
                                              date.year ==
                                                  BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).today.year;
                                          bool isSelected =
                                              BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).selected.day ==
                                                  date.day &&
                                              BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).selected.month ==
                                                  date.month &&
                                              BlocProvider.of<MainBloc>(
                                                    context,
                                                  ).selected.year ==
                                                  date.year;
                                          return InkWell(
                                            onTap: () {
                                              BlocProvider.of<MainBloc>(
                                                context,
                                              ).add(
                                                SelectAppointmentData(
                                                  dateTime: date,
                                                  doctor: doctor,
                                                ),
                                              );
                                              BlocProvider.of<MainBloc>(
                                                context,
                                              ).getTimeSlots(doctor, date);
                                            },
                                            child: DayContainer(
                                              isSelected: isSelected,
                                              date: '${date.day}',
                                              text: DateFormat(
                                                'E',
                                              ).format(date),
                                              isToday:
                                                  isSelected
                                                      ? isToday == true
                                                      : false,
                                            ),
                                          );
                                        }).toList(),
                                  );
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                child: SelectTimeWidget(
                                  timeSlots:
                                      BlocProvider.of<MainBloc>(
                                        context,
                                      ).timeSlots,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              state is BookAppointmentLoadingState
                                  ? Center(child: CircularProgressIndicator())
                                  : isReschedule
                                  ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DecoratedButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.4,
                                        isWhite: true,
                                        color: ColorManager.white,
                                        text: 'Cancel',
                                        onTap: () {
                                          navigateAndFinish(
                                            context: context,
                                            widget: MainScreen(),
                                          );
                                          // Handle cancel appointment action
                                        },
                                      ),
                                      DecoratedButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.4,

                                        color: ColorManager.primary,
                                        text: 'Confirm Reschedule',
                                        onTap: () {
                                          BlocProvider.of<MainBloc>(
                                            context,
                                          ).add(
                                            BookAppointmentEvent(
                                              doctor,
                                              context,
                                            ),
                                          );
                                          // Handle cancel appointment action
                                        },
                                      ),
                                    ],
                                  )
                                  : DecoratedButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,

                                    color: ColorManager.primary,
                                    text: 'Book Appointment',
                                    onTap: () {
                                      BlocProvider.of<MainBloc>(context).add(
                                        BookAppointmentEvent(doctor, context),
                                      );
                                      // Handle cancel appointment action
                                    },
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      //
    );
  }
}
