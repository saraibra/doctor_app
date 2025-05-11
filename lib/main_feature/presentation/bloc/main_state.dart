part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}
final class ChangeScreenIndexState extends MainState {}

final class GetAllDoctorsLoadingState extends MainState {}

final class GetAllDoctorsErrorState extends MainState {
  final String errorMessage;

  GetAllDoctorsErrorState(this.errorMessage);
}

final class GetAllDoctorsSuccessState extends MainState {
  final List<DoctorEntity> doctors;

  GetAllDoctorsSuccessState(this.doctors);
}

final class BookAppointmentLoadingState extends MainState {}

final class BookAppointmentErrorState extends MainState {
  final String errorMessage;

  BookAppointmentErrorState(this.errorMessage);
}

final class BookAppointmentSuccessState extends MainState {
  BookAppointmentSuccessState();
}

final class CancelAppointmentLoadingState extends MainState {}

final class CancelAppointmentErrorState extends MainState {
  final String errorMessage;

  CancelAppointmentErrorState(this.errorMessage);
}

final class CancelAppointmentSuccessState extends MainState {
  final String message;

  CancelAppointmentSuccessState(this.message);
}

final class GetAllAppointmentsLoadingState extends MainState {}

final class GetAllAppointmentsErrorState extends MainState {
  final String errorMessage;

  GetAllAppointmentsErrorState(this.errorMessage);
}

final class GetAllAppointmentsSuccessState extends MainState {
  final List<UserAppointment> appointments;

  GetAllAppointmentsSuccessState(this.appointments);
}
final class StateWithSelectedDate extends MainState {
  final DateTime selectedDate;

  StateWithSelectedDate({required this.selectedDate});
}

final class StateWithSelectedTime extends MainState {
  final String selectedTime;

  StateWithSelectedTime({required this.selectedTime});
}
final class FilterResultLoadingState extends MainState {}
final class SuccessSearchDoctorsState extends MainState {
  final List<DoctorEntity> filteredDoctors;

  SuccessSearchDoctorsState({required this.filteredDoctors});
}