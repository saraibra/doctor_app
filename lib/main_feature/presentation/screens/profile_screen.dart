import 'package:doctor_app/core/utils/methods.dart';
import 'package:doctor_app/main_feature/presentation/bloc/main_bloc.dart';
import 'package:doctor_app/main_feature/presentation/widgets/customized_button.dart';
import 'package:doctor_app/main_feature/presentation/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/color_manager.dart';
import '../../../features/auth_feature/domain/entities/user_entity.dart';
import '../../../features/auth_feature/presentation/bloc/bloc/auth_bloc.dart';
import '../../../features/auth_feature/presentation/widgets/default_button.dart';
import '../widgets/decorated_button.dart';
import 'my_appointsment.dart';

class ProfileScreen extends StatelessWidget {
  User? user;
  @override
  Widget build(BuildContext context) {

    //BlocProvider.of<AuthBloc>(context).add(GetUserDataEvent(context));
    //print(BlocProvider.of<AuthBloc>(context).userData.name);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print(state);
            if (state is GetUserDataLoadingState || state is AuthInitial) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GetUserDataErrorState) {
              return Center(child: Text('Error'));
            }
            if (state is GetUserDataSuccessState ||
                BlocProvider.of<AuthBloc>(context).userData != null) {
              user = BlocProvider.of<AuthBloc>(context).userData;
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://avatar.iran.liara.run/username?username=${user!.name}&background=35A97A&color=FFFFFF',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: Text(
                            user!.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                   Padding(
                     padding: EdgeInsets.all(8.w),
                     child: Column(
                       children: [
                         ListTile(
                           leading: Icon(Icons.email),
                           title: Text(user!.email),
                         ),
                         Divider(),
                         ListTile(
                           leading: Icon(Icons.phone),
                           title: Text(user!.phoneNumber),
                         ),
                         Divider(),
                         ListTile(
                           leading: Icon(Icons.calendar_today),
                           title: Text('My Appointments'),
                           onTap: () {
                             navigateTo(
                               context: context,
                               widget: MyAppointsment(),
                             );
                           },
                         ),
                         SizedBox(
                           height:
                               MediaQuery.of(context).size.height * 0.02,
                         ),
                         state is LogoutLoadingState
                             ? Center(child: CircularProgressIndicator())
                             : DecoratedButton(
                               width:
                                   MediaQuery.of(context).size.width * 0.7,
                               text: 'Logout',
                               onTap: () {
                                 BlocProvider.of<AuthBloc>(
                                   context,
                                 ).add(LogoutEvent(context));
                               },
                               color: ColorManager.primary,
                             ),

                         // Add more ListTiles or other widgets here as needed
                       ],
                     ),
                   ),

                  ],
                ),
              );
            }
            return Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }
}
