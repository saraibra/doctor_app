
import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/top_doctor_item.dart';

class FilterScreen extends StatelessWidget {
final String category;

  const FilterScreen({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(category+' Doctors',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:  Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: ColorManager.primary.withOpacity(0.1),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                print('state is ' + state.toString());
                if (state is FilterResultLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetAllDoctorsErrorState) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is SuccessSearchDoctorsState ||BlocProvider.of<MainBloc>(context).filteredDoctors.isNotEmpty) {
                  List<DoctorEntity> filteredDoctors = BlocProvider.of<MainBloc>(context).filteredDoctors;

                  return  ListView.separated(
                    itemBuilder: (context, index) {
                      return TopDoctorItem(doctor:  filteredDoctors[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: filteredDoctors.length,

                  );
                }
                else {
                  return Center(child: Text('No doctors available'));
                }
              } ),
        ),
      ),
    );
  }}