import 'package:doctor_app/main_feature/domain/usecases/book_appointment_usecase.dart';
import 'package:doctor_app/main_feature/domain/usecases/get_all_doctors_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../features/auth_feature/data/datasource/remote_data_source.dart';
import '../features/auth_feature/data/repositories/auth_repository_imp.dart';
import '../features/auth_feature/domain/repositories/auth_repository.dart';
import '../features/auth_feature/domain/usecases/email_sign_in.dart';
import '../features/auth_feature/domain/usecases/forgot_password.dart';
import '../features/auth_feature/domain/usecases/get_user_data.dart';
import '../features/auth_feature/domain/usecases/google_sign_in.dart';
import '../features/auth_feature/domain/usecases/logout_usecase.dart';
import '../features/auth_feature/domain/usecases/register_user.dart';
import '../features/auth_feature/domain/usecases/update_user_data.dart';
import '../features/auth_feature/presentation/bloc/bloc/auth_bloc.dart';

import '../main_feature/data/datasource/remote_datasource.dart';
import '../main_feature/data/repositories/main_repository_imp.dart';
import '../main_feature/domain/repositories/main_repository.dart';
import '../main_feature/domain/usecases/cancel_appointment_usecase.dart';
import '../main_feature/domain/usecases/get_user_appointment_usecase.dart';
import '../main_feature/presentation/bloc/main_bloc.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //*  features auth
  // bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(),sl()));
  // usecases
  sl.registerLazySingleton<EmailLoginUseCase>(() => EmailLoginUseCase(sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<GoogleSigninUseCase>(
    () => GoogleSigninUseCase(sl()),
  );
  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateUserDataUseCase>(
    () => UpdateUserDataUseCase(sl()),
  );
  sl.registerLazySingleton<GetUserDataUseCase>(() => GetUserDataUseCase(sl()));

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl(), sl()));
  // datasources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp());
  //* main feature
  // bloc
  sl.registerFactory(
    () => MainBloc(
      getAllDoctorsUsecase: sl(),
      bookAppointmentUsecase: sl(),
      cancelAppointmentUsecase: sl(),
      getAllAppointmentsUsecase: sl(),
    ),
  );
  // usecases

  sl.registerLazySingleton<GetAllDoctorsUsecase>(
    () => GetAllDoctorsUsecase(sl()),
  );
  sl.registerLazySingleton<BookAppointmentUsecase>(
    () => BookAppointmentUsecase(sl()),
  );
  sl.registerLazySingleton<CancelAppointmentUsecase>(
    () => CancelAppointmentUsecase(sl()),
  );
  sl.registerLazySingleton<GetAllAppointmentsUsecase>(
    () => GetAllAppointmentsUsecase(sl()),
  );

  // repositories

  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImp(remoteDataSource: sl(), networkInfo: sl()),
  );
  // datasources
  sl.registerLazySingleton<MainRemoteDataSource>(
    () => MainRemoteDataSourceImpl(),
  );

  //* core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));
  //* external
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
