import 'package:doctor_app/main_feature/presentation/widgets/doctor_info_item.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is GetAllDoctorsLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetAllDoctorsErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        if (BlocProvider.of<MainBloc>(context).doctors.isNotEmpty) {
          List<DoctorEntity> doctors = BlocProvider.of<MainBloc>(context).doctors;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DoctorInfoItem(doctor:  doctors[index]);
            },
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemCount: doctors.length,

          );
        }
        else {
          return Center(child: Text('No doctors available'));
        }
      } );
  }
}