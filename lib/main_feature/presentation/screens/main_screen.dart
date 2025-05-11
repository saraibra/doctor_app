import 'package:doctor_app/core/resources/color_manager.dart';
import 'package:doctor_app/features/auth_feature/presentation/bloc/bloc/auth_bloc.dart';
import 'package:doctor_app/main_feature/presentation/screens/doctors_list.dart';
import 'package:doctor_app/main_feature/presentation/screens/home_screen.dart';
import 'package:doctor_app/main_feature/presentation/screens/my_appointsment.dart';
import 'package:doctor_app/main_feature/presentation/screens/user_appointments.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import '../../../core/utils/app_constants.dart';
import '../bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_screen.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(); // Local instance
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
         // appBar: AppBar(),
          body: SizedBox.expand(
            child: PageView(

              physics: NeverScrollableScrollPhysics(),
              controller:_controller,

              onPageChanged: (index) {
              //  BlocProvider.of<MainBloc>(context).add(ChangeScreenIndexEvent(index,context));
                //BlocProvider.of<MainBloc>(context).pageController.jumpToPage(index);
              },
              children: <Widget>[
                HomeScreen(),
                MyAppointsment(),
                ProfileScreen()

              ],
            ),
          ),

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: currentIndex,

            onItemSelected: (index) {
              currentIndex = index;
                 setState(() {
                   if (index == 1){
                     BlocProvider.of<MainBloc>(context). add(GetAllAppointmentsEvent(uid));
                   }

                   if (index == 2){
                     BlocProvider.of<AuthBloc>(context). add(GetUserDataEvent());
                   }

                   // BlocProvider.of<MainBloc>(context).add(
                   //     ChangeScreenIndexEvent(index, context));
                   _controller.jumpToPage(index);
                 });
            },
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: ColorManager.primary,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text('Appointments'),
                activeColor: ColorManager.primary,

              ),
              BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: ColorManager.primary,

              ),
            ],

          ),
        );
      },
    );
  }
}