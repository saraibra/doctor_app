part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}
class ChangeScreenIndexEvent extends MainEvent{
 final int index;
 final BuildContext context;
  ChangeScreenIndexEvent(this.index, this.context);
}
class GetAllDoctorsEvent extends MainEvent{

  GetAllDoctorsEvent();
}
class SelectAppointmentData extends MainEvent{
  final DateTime dateTime;
  final DoctorEntity doctor;
  SelectAppointmentData({ required this.dateTime,required this.doctor});
}
class SelectTimeSlotEvent extends MainEvent{
  final String time;
  SelectTimeSlotEvent({required this.time});
}
class BookAppointmentEvent extends MainEvent{
final DoctorEntity doctor;
final BuildContext context;
  BookAppointmentEvent(this.doctor, this.context);
}
class CancelAppointmentEvent extends MainEvent{
  final UserAppointment appointment;
  final BuildContext context;
  CancelAppointmentEvent(this.appointment, this.context);
}
class GetAllAppointmentsEvent extends MainEvent{
  final String userId;
  GetAllAppointmentsEvent(this.userId);
}
class FilterCategoryResultEvent extends MainEvent {
  final String category;
  final BuildContext context;

  FilterCategoryResultEvent(this.category, this.context);
}

class SearchDoctorsEvent extends MainEvent{
  final BuildContext context;
   final String searchText;
  SearchDoctorsEvent(this.context, this.searchText);
}