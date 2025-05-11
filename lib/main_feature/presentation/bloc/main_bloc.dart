import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/utils/app_constants.dart';
import 'package:doctor_app/main_feature/domain/usecases/book_appointment_usecase.dart';
import 'package:doctor_app/main_feature/domain/usecases/get_all_doctors_usecase.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/methods.dart' show navigateTo;
import '../../../features/auth_feature/presentation/bloc/bloc/auth_bloc.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/user_appointment.dart';
import '../../domain/usecases/cancel_appointment_usecase.dart';
import '../../domain/usecases/get_user_appointment_usecase.dart';
import '../screens/filter_screen.dart';
import '../screens/filtered_screen.dart';
import '../screens/main_screen.dart';
import '../screens/user_appointments.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetAllDoctorsUsecase getAllDoctorsUsecase;
  final BookAppointmentUsecase bookAppointmentUsecase;
  final CancelAppointmentUsecase cancelAppointmentUsecase;
  final GetAllAppointmentsUsecase getAllAppointmentsUsecase;
  List<String> timeSlots = [];
  List<DoctorEntity> doctors = [];
  List<DoctorEntity> topDoctors = [];

  List <DoctorEntity> filteredDoctors = [];
  List<UserAppointment> appointments = [];
  DateTime selected = DateTime.now();
  String selectedTime = '';
  int workingDayId = 0;
  int currentIndex = 0;
  String appointmentId = '';
  TextEditingController searchController = TextEditingController();
  List<UserAppointment> upCommingBooking = [];
  List<UserAppointment> completedBooking = [];
  List<UserAppointment> canceledBooking = [];
 // TabController tabController =TabController(length: 3, vsync: TickerProviderStateMixin());
String userName = '';
  MainBloc({
    required this.cancelAppointmentUsecase,
    required this.getAllAppointmentsUsecase,
    required this.bookAppointmentUsecase,
    required this.getAllDoctorsUsecase,
  }) : super(MainInitial()) {
    on<MainEvent>((event, emit) async {
userName = await CasheHelper.getData(key: 'name')??'';
      if (event is GetAllDoctorsEvent) {
        doctors = [];
        emit(GetAllDoctorsLoadingState());
        await getAllDoctorsUsecase.call().then((value) {
          value.fold((failure) => emit(GetAllDoctorsErrorState('error')), (
            doctor,
          ) {
            doctors.addAll(doctor);

            topDoctors = doctors.where((item) => item.rating!.toDouble() >= 4.0

            ).toList();
            emit(GetAllDoctorsSuccessState(doctors));
          });
        });
      }
      if (event is BookAppointmentEvent) {
        // print('get all doctors');
        emit(BookAppointmentLoadingState());
        await bookAppointmentUsecase
            .call(
              doctor: event.doctor,
              date: DateTime(
                selected.year,
                selected.month,
                selected.day,
                int.parse(selectedTime.substring(0, 2)),
                int.parse(selectedTime.substring(3, 5)),
              ),
              userId:uid,
              time: selectedTime,
              workingDayId: workingDayId,
              appointmentId:appointmentId,
            )
            .then((value) {
              value.fold(
                (failure) => emit(BookAppointmentErrorState('error')),
                (value) {
                  print('success');
                  currentIndex = 0;

                  navigateTo(context: event.context, widget: MainScreen());
                  //navigateTo(context: event.context, widget: AppointmentList());
                  emit(BookAppointmentSuccessState());
                },
              );
            });
      }
      if (event is CancelAppointmentEvent) {
        emit(CancelAppointmentLoadingState());
        await cancelAppointmentUsecase
            .call(appointmentId: event.appointment.appointmentId,
              doctor: event.appointment.doctorId,
              date: event.appointment.date,
              time: event.appointment.time,
               workingDayId: workingDayId,
              appointmentIndex: event.appointment.appointmentId,
              doctorName: event.appointment.doctorName,
              doctorSpecialty: event.appointment.doctorSpecialty,
              doctorImageUrl: event.appointment.doctorImageUrl,

        )
            .then((value) {
              value.fold(
                (failure) => emit(CancelAppointmentErrorState('error')),
                (value) {
                  currentIndex = 0;
                  navigateTo(context: event.context, widget: MainScreen());
                  emit(CancelAppointmentSuccessState('success'));
                },
              );
            });
      }
      if (event is GetAllAppointmentsEvent) {
        appointments = [];
        upCommingBooking = [];
        completedBooking = [];
        canceledBooking = [];
        emit(GetAllAppointmentsLoadingState());
        await getAllAppointmentsUsecase.call(userId: event.userId).then((
          value,
        ) {
          value.fold((failure) => emit(GetAllAppointmentsErrorState('error')), (
            appointment,
          ) {
            appointment.forEach((appointment){
              if(appointment.isCanceled){
                canceledBooking.add(appointment);
              }
              else
              if (appointment.date.isAfter(DateTime.now())){
                upCommingBooking.add(appointment);
              }else{
                completedBooking.add(appointment);
              }
            });
            appointments.addAll(appointment);
            emit(GetAllAppointmentsSuccessState(appointments));
          });
        });
      }
      if (event is SelectTimeSlotEvent) {
        selectedTime = event.time;
        //timeSlots.add(event.time);
        emit(StateWithSelectedTime(selectedTime: selectedTime));
      }
      if (event is SelectAppointmentData) {
        selected = event.dateTime;
        getTimeSlots(event.doctor, selected);
        emit(StateWithSelectedDate(selectedDate: selected));
      }
      if (event is FilterCategoryResultEvent) {
        emit(FilterResultLoadingState());
        filteredDoctors =[];

        filteredDoctors = doctors.where((item) {
          print('filtered doctors length ${item.specialty}');

          return item.specialty.toLowerCase().contains(event.category.toLowerCase());
        }
        ).toList();
        navigateTo(context: event.context, widget: FilterScreen( category: event.category,));
        emit(SuccessSearchDoctorsState(filteredDoctors: filteredDoctors));
      }


      if (event is SearchDoctorsEvent) {
      filteredDoctors =[];

   filteredDoctors = doctors.where((item) => item.name.toLowerCase().contains(event.searchText.toLowerCase())

        ).toList();
        emit(SuccessSearchDoctorsState(filteredDoctors: filteredDoctors));
        searchController.clear();
      }
    });
  }
  final DateTime today = DateTime.now();

  List<DateTime> getCurrentWeekDates() {
    DateTime sunday = today.subtract(Duration(days: today.weekday % 7));
    return List.generate(7, (index) => sunday.add(Duration(days: index)));
  }

  getTimeSlots(DoctorEntity doctor, DateTime selectedDate) {
    timeSlots = [];
    doctor.workingDays.forEach((element) {
      if (DateFormat('yyyy-MM-dd ')
              .format(element.dateTime)
              .compareTo(DateFormat('yyyy-MM-dd ').format(selectedDate)) ==
          0) {
        workingDayId = element.dayId;
        print(workingDayId);
        element.appointments!.forEach((element) {
          if (!element.booked) {
            appointmentId = element.appointmentId;
            timeSlots.add(element.startTime);
          }
        });
      }
    });
    return timeSlots;
  }
  getSelectedDoctor(String doctorId) {
    return doctors.firstWhere((element) => element.id == doctorId);
  }

}
