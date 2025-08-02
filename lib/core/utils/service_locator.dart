import 'package:get_it/get_it.dart';

import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/cubit/delete_advertisement_cubit.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/repo/delete_advertisement_repo.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_cubit.dart';
import 'package:medease1/features/advertisements/getAdvertisement/repo/advertisements_repo.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/advices/repo/advices_repo.dart';
import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_cubit.dart';
import 'package:medease1/features/appointment/all_appointment/repo/all_appointment_reop.dart';
import 'package:medease1/features/doctors/cubit/doctor_cubit.dart';
import 'package:medease1/features/doctors/repo/doctors_repo.dart';
import 'package:medease1/features/login/cubit/login_cubit.dart';
import 'package:medease1/features/login/repo/login_repo.dart';
import 'package:medease1/features/patients/cubit/patient_cubit.dart';
import 'package:medease1/features/patients/repo/patients_repo.dart';
import 'package:medease1/features/profile/cubit/profile_cubit.dart';
import 'package:medease1/features/profile/repo/profile_repo.dart';
import 'package:medease1/features/register/cubit/register_cubit.dart';
import 'package:medease1/features/register/repo/register_repo.dart';

import '../../features/disease/disease_repo.dart';
import '../../features/realChat/conversation/repo/chat_repo.dart';
import '../../features/treatment/treatment_repo.dart';
import 'role_service.dart';

GetIt sl = GetIt.instance;
void setupServiceLocator() {
  DioHelper dioHelper = DioHelper();
  // Dio Helper
  sl.registerSingleton(dioHelper);
  // repo
  sl.registerLazySingleton(() => LoginRepo(sl<DioHelper>()));
  // Login Cubit

  sl.registerFactory(() => LoginCubit(sl<LoginRepo>()));
  // repo

  sl.registerLazySingleton(() => RegisterRepo(sl<DioHelper>()));

  // Register Cubit
  sl.registerFactory(() => RegisterCubit(sl<RegisterRepo>()));

  // Profile Cubit
  sl.registerFactory(() => ProfileCubit(sl<ProfileRepo>()));
  // Profile Repo
  sl.registerLazySingleton(() => ProfileRepo(sl<DioHelper>()));
  // appointment Cubit

  sl.registerFactory(() => GetAppointmentCubit(sl<GetAppointmentRepo>()));
  // appointment Repo
  sl.registerLazySingleton(() => GetAppointmentRepo(sl<DioHelper>()));
  // advices Cubit

  sl.registerFactory(() => AdviceCubit(sl<AdviceRepo>()));
  // advices Repo
  sl.registerLazySingleton(() => AdviceRepo(sl<DioHelper>()));
  // Doctor Cubit
  sl.registerFactory(() => DoctorCubit(sl<DoctorsRepo>()));
  // Doctor Repo
  sl.registerLazySingleton(() => DoctorsRepo(sl<DioHelper>()));
  // Advertisements Cubit
  sl.registerFactory(() => AdvertisementsCubit(sl<AdvertisementsRepo>()));
  // Advertisements Repo
  sl.registerLazySingleton(() => AdvertisementsRepo(sl<DioHelper>()));
  // deleteAdvertisement Cubit
  sl.registerFactory(
    () => DeleteAdvertisementCubit(sl<DeleteAdvertisementRepo>()),
  );
  // deleteAdvertisement Repo
  sl.registerLazySingleton(() => DeleteAdvertisementRepo(sl<DioHelper>()));

  sl.registerFactory(() => PatientsCubit(sl<PatientsRepo>()));
  // appointment Repo
  sl.registerLazySingleton(() => PatientsRepo(sl<DioHelper>()));

  // Storage Helper
  sl.registerLazySingleton(() => StorageHelper());

  sl.registerLazySingleton(
    () => DiseaseRepo(DioHelper.dio!, sl<StorageHelper>()),
  );
  sl.registerLazySingleton(() => TreatmentRepo(DioHelper.dio!));

  // Register RoleService as a singleton
  sl.registerSingleton<RoleService>(RoleService());

  // Register Chat repo
  sl.registerLazySingleton(() => ChatRepo(dioHelper: sl<DioHelper>()));
}
