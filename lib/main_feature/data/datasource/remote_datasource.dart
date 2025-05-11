import 'package:doctor_app/core/utils/app_constants.dart';
import 'package:doctor_app/main_feature/data/models/doctor_model.dart';
import 'package:doctor_app/main_feature/data/models/user_appointment_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class MainRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors();
  Future<Unit> bookAppointment({
    required DoctorModel doctor,
    required String userId,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentIndex,
  });
  Future<Unit> cancelAppointment({required String appointmentId,
      required String doctorId,
      required DateTime date,
      required String time,
      required int workingDayId,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorImageUrl,
      required String appointmentIndex,});
  Future<List<UserAppointmentModel>> getAllAppointments({
    required String userId,
  });
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final url = Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/doctors.json',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<DoctorModel> doctors =
          data.map((doctorJson) {
            return DoctorModel.fromJson(Map<String, dynamic>.from(doctorJson));
          }).toList();

      return doctors;
    } else {
      throw Exception('Failed to load doctors');
    }
  }


  @override
  Future<Unit> bookAppointment({
    required DoctorModel doctor,
    required String userId,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentIndex,
  }) async {

    final url = Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/doctors/${doctor.id}/workingDays/$workingDayId/appointments/$appointmentIndex.json',
    );
    final appointmentId = date.toIso8601String().replaceAll(
      RegExp(r'[:.#$[\]]'),
      '-',
    );

    final response = await http.patch(
      url,
      body: json.encode({
        'booked': true,
        //'patient_name': patientName,
      }),
    );

    if (response.statusCode == 200) {
      final url1 = Uri.parse(
        'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/usersAppointments/$uid/$appointmentId.json',
      );
      final response2 = await http.put(
        url1,
        body: json.encode({
          'doctor_id': doctor.id,
          'doctor_name': doctor.name,
          'user_id': userId,
          'doctor_specialty': doctor.specialty,
          'doctor_image': doctor.imageUrl,
          'isCanceled': false,
          'time': date.toIso8601String(),
          'booked': true,
        }),
      );
      if (response2.statusCode == 200) {
        print('Appointment booked!');
      } else {
        print('Failed to book appointment: ${response2.body}');
      }
    } else {
      print('Failed: ${response.body}');
    }
    return Future.value(unit);
  }

  Future<Unit> cancelAppointment({
    required String appointmentId,
  required String doctorId,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentIndex,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorImageUrl,

  }) async {
    //String dateString = "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
    final appointmentId = date.toIso8601String().replaceAll(
      RegExp(r'[:.#$[\]]'),
      '-',
    );
    final url1 = Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/doctors/${doctorId}/workingDays/$workingDayId/appointments/$appointmentId.json',
    );
    print(url1);
    final response1 = await http.patch(
      url1,
      body: json.encode({
        'booked': false,
        //'patient_name': patientName,
      }),
    );

    final url = Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/usersAppointments/$uid/$appointmentId.json',

    );
  final response = await http.put(
      url,
      body: json.encode({
        'doctor_id': doctorId,
        'doctor_name': doctorName,
        'user_id': uid,
        'doctor_specialty': doctorSpecialty,
        'doctor_image': doctorImageUrl,
        'isCanceled': true,
        'time': date.toIso8601String(),
        'booked': false,
      }),
    );
    //final response = await http.delete(url);
    if (response.statusCode == 200) {
      print('Appointment cancelled!');
    } else {
      print('Failed to cancel appointment: ${response.body}');
    }
    return Future.value(unit);
  }

  @override
  Future<List<UserAppointmentModel>> getAllAppointments({
    required String userId,
  }) {
    final url = Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/usersAppointments/$uid.json',
    );
    print(url);
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        if (response.body == 'null') {
          return [];
        }
        else{
        final Map<String, dynamic> data = json.decode(response.body);

        final List<Map<dynamic, dynamic>> appointmentsList =
            data.entries.map((entry) {
              return {'id': entry.key, ...entry.value};
            }).toList();
        final now = DateTime.now();
        // final upcomingAppointments =
        //     appointmentsList.where((appointment) {
        //       final time = DateTime.parse(appointment['time']);
        //       return time.isAfter(now);
        //     }).toList();
        final List<UserAppointmentModel> userAppointments =
        appointmentsList.map((appointment) {
              return UserAppointmentModel(
                appointmentId: appointment['id'],
                doctorId: appointment['doctor_id'],
                doctorName: appointment['doctor_name'],
                userId: appointment['user_id'],
                doctorSpecialty: appointment['doctor_specialty'],
                doctorImageUrl: appointment['doctor_image'],
                time: appointment['time'],
                isCanceled:appointment['isCanceled'] ,
                isBooked: bool.parse(
                  appointment['booked'].toString() ?? true.toString(),
                ),
                date: DateTime.parse(
                  appointment['time'] ?? DateTime.now().toString(),
                ),
              );
            }).toList();
        return userAppointments;}
      } else {
        throw Exception('Failed to load appointments');
      }
    });

    // } else {
    //   throw Exception('Failed to load appointments');
    // }
    //  });
  }
}
