import 'package:doctor_app/core/resources/string_manager.dart';
import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/main_feature/presentation/screens/top_doctors_list.dart';
import 'package:doctor_app/main_feature/presentation/widgets/category_item.dart';
import 'package:doctor_app/main_feature/presentation/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/resources/color_manager.dart';
import '../widgets/search_edit_text.dart';
import 'doctors_list.dart';
import 'filter_screen.dart';
import 'filtered_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary.withOpacity(0.1),

    body: Padding(
        padding:  EdgeInsets.all(12.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h,),
              ProfileWidget(name: BlocProvider.of<MainBloc>(context).userName),
              SizedBox(height: 12.h,),
              SearchTextFormField(controller: BlocProvider.of<MainBloc>(context).searchController,
                onTab: ()=>navigateTo(context: context, widget: FilteredScreen()),
              ),
              SizedBox(height: 12.h,),
              Text('Categories',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 12.h,),
              SizedBox(width: double.infinity,
              height:  MediaQuery.of(context).size.height*0.14,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>InkWell(
                      onTap: () {
                        BlocProvider.of<MainBloc>(context).add(FilterCategoryResultEvent(AppStrings.specialties[index], context));
                      },
                      child: CategoryItem(categoryName: AppStrings.specialties[index],
                          imageUrl: AppStrings.imageUrls[index]),
                    ),
                    separatorBuilder:(context,index)=> SizedBox(width: 8,), itemCount: AppStrings.imageUrls.length),
                
                ),
              SizedBox(height: 12.h,),
              Text('Popular Doctors',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 12.h,),
          
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.26,
                child: DoctorsList(),
              ),
          
              SizedBox(height: 12.h,),
              Text('Top Doctors',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              SizedBox(
                width: double.infinity,
             height: MediaQuery.of(context).size.height * 0.4,
                child: TopDoctorsList(),
              ),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      ),
    );
  }
}
