import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/main_feature/presentation/widgets/doctor_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/user_appointment.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/appointment_item.dart';
import '../widgets/search_edit_text.dart';
import '../widgets/top_doctor_item.dart';

class FilteredScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Search Doctors",
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
          child: Column(

              children: [
              SearchTextFormField(controller: BlocProvider.of<MainBloc>(context).searchController,
              onChanged:
              (v) {
              BlocProvider.of<MainBloc>(context).add(SearchDoctorsEvent(context,  v));
              // navigateTo(context: context, widget: FilteredScreen());
              }),

          BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state is GetAllDoctorsLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetAllDoctorsErrorState) {
                  return Center(child: Text(state.errorMessage));
                }
                if (BlocProvider.of<MainBloc>(context).filteredDoctors.isNotEmpty) {
                  List<DoctorEntity> filteredDoctors = BlocProvider.of<MainBloc>(context).filteredDoctors;

                    return  Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return TopDoctorItem(doctor:  filteredDoctors[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          itemCount: filteredDoctors.length,

                        ),

                  );
                }
                else {
                  return Center(child: Text('No doctors available'));
                }
              } ),
          ]
          ),
        ),
      ),
    );
  }}