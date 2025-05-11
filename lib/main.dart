import 'package:doctor_app/core/utils/app_constants.dart';
import 'package:doctor_app/features/auth_feature/presentation/screens/base_screen.dart';
import 'package:doctor_app/main_feature/presentation/bloc/main_bloc.dart';
import 'package:doctor_app/main_feature/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/resources/theme_manager.dart';
import 'core/service_locator.dart' as di;
import 'core/utils/cashe_helper.dart';
import 'features/auth_feature/presentation/bloc/bloc/auth_bloc.dart';
import 'features/auth_feature/presentation/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    await Firebase.initializeApp(
        options: FirebaseOptions(apiKey: 'AIzaSyC4mejrvQA_9H54nadgyFGuUVI7JrvPCO8',
            appId: '1:128765296878:android:f344b87e23a0df7f8a33ff',
            messagingSenderId: '476412242702',
            projectId: 'doctor-1f132'

        )
    );
    // await AndroidAlarmManager.initialize();
await CasheHelper.init();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((val) {
      runApp(
        //DevicePreview(enabled: true, builder: (context) =>
          MyApp());
      //  ),
    });
    if (CasheHelper.getData(key: 'uid') == null) {
      uid = '';
    } else {
      uid = CasheHelper.getData(key: 'uid')!;
    }
  }



class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => di.sl<AuthBloc>()..add(GetUserDataEvent())

          ),
          BlocProvider(
                //+-..add(GetAllAppointmentsEvent('1'))
              create: (context) => di.sl<MainBloc>()..add(GetAllDoctorsEvent())
                //+-..add(GetAllAppointmentsEvent('1'))


          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) =>  MaterialApp(
            title: 'Doctors App',
            theme: getApplicationTheme(),
            debugShowCheckedModeBanner: false,
            home:uid==''?BaseScreen():MainScreen(),
          ),
        ));
  }
}
