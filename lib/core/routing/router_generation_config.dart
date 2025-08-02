import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/features/Ai%20Chatbot/ai_chatbot_screen.dart';
import 'package:medease1/features/Ai%20Chatbot/cubit/aichatbot_cubit.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/cubit/delete_advertisement_cubit.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/delete_advertisement_screen.dart';
import 'package:medease1/features/advertisements/getAdvertisement/advertisement_screen.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_cubit.dart';
import 'package:medease1/features/advices/advices_screen.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/appointment/create_appointment/create_appointment_screen.dart';
import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_cubit.dart';
import 'package:medease1/features/appointment/all_appointment/all_appointment.dart';
import 'package:medease1/features/calculators/calculators_page.dart';
import 'package:medease1/features/calculators/calorie_calculator_page.dart';
import 'package:medease1/features/doctors/cubit/doctor_cubit.dart';
import 'package:medease1/features/doctors/doctors_screen.dart';
import 'package:medease1/features/home_page.dart';
import 'package:medease1/features/lab_test_page.dart';
import 'package:medease1/features/login/cubit/login_cubit.dart';
import 'package:medease1/features/login/login_page.dart';
import 'package:medease1/features/patient/patient_home_screen.dart';
import 'package:medease1/features/patients/cubit/patient_cubit.dart';
import 'package:medease1/features/patients/patients_screen.dart';
import 'package:medease1/features/products/cubit/products_cubit.dart';
import 'package:medease1/features/products/products_view.dart';
import 'package:medease1/features/products/repo/products_repo.dart';
import 'package:medease1/features/profile/profile_screen.dart';
import 'package:medease1/features/profile/cubit/profile_cubit.dart';
import 'package:medease1/features/register/cubit/register_cubit.dart';
import 'package:medease1/features/register/register_page.dart';
import 'package:medease1/features/splash_screen/splash_screen.dart';
import 'package:medease1/features/welcome/welcome_page.dart';

import '../../features/Ai Chatbot/cubit/aichatbot_cubit.dart';
import '../../features/disease/diseases_page.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.welcomeScreen,
        name: AppRoutes.welcomeScreen,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<LoginCubit>(),
              child: const LoginPage(),
            ),
      ),


      
      
      GoRoute(
        path: AppRoutes.registerScreen,
        name: AppRoutes.registerScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<RegisterCubit>(),
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.chatBotScreen,
        name: AppRoutes.chatBotScreen,
        builder:
            (context, state) => BlocProvider(
              create: (_) => AiChatCubit(),
              child: ChatScreen.aiChatScreen(),
            ),
      ),

      GoRoute(
        path: AppRoutes.profileScreen,
        name: AppRoutes.profileScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<ProfileCubit>()..fetchProfile(),
              child: ProfileScreen(),
            ),
      ),
      /*GoRoute(
        path: AppRoutes.labTestsScreen,
        name: AppRoutes.labTestsScreen,
        builder: (context, state) => LabTestsPage(),
      ),*/
      GoRoute(
        path: AppRoutes.diseasesScreen,
        name: AppRoutes.diseasesScreen,
        builder: (context, state) => DiseasesPage(),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => const HomePage(),
      ),
      /*GoRoute(
        path: AppRoutes.bmiCalculatorScreen,
        name: AppRoutes.bmiCalculatorScreen,
        builder: (context, state) => const BMICalculatorPage(),
      ),
      GoRoute(
        path: AppRoutes.calorieCalculatorScreen,
        name: AppRoutes.calorieCalculatorScreen,
        builder: (context, state) => const CalorieCalculatorPage(),
      ),*/
      GoRoute(
        path: AppRoutes.calculatorScreen,
        name: AppRoutes.calculatorScreen,
        builder: (context, state) => const CalculatorsPage(),
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.advicesScreen,
        name: AppRoutes.advicesScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<AdviceCubit>()..getAdvices(),
              child: AdviceScreen(),
            ),
      ),

      GoRoute(
        path: AppRoutes.doctorsScreen,
        name: AppRoutes.doctorsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<DoctorCubit>()..fetchDoctors(),
              child: DoctorsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.advertisementScreen,
        name: AppRoutes.advertisementScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => sl<AdvertisementsCubit>()..getAdvertisements(),
              child: AdvertisementScreen(),
            ),
      ),

      GoRoute(
        path: AppRoutes.deleteAdvertisementScreen,
        name: AppRoutes.deleteAdvertisementScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) =>
                      sl<DeleteAdvertisementCubit>()
                        ..deleteAdvertisement(id: state.extra.toString()),
              child: DeleteAdvertisementScreen(
                advertisementsId: state.extra.toString(),
              ),
            ),
      ),
      GoRoute(
        path: AppRoutes.appointmentScreen,
        name: AppRoutes.appointmentScreen,
        builder: (context, state) {
          final String doctorId = state.extra as String;
          return AppointmentScreen(doctorId: doctorId);
        },
      ),
      GoRoute(
        path: AppRoutes.patientScreen,
        name: AppRoutes.patientScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<PatientsCubit>()..fetchPatients(),
              child: PatientsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myAppointmentsScreen,
        name: AppRoutes.myAppointmentsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<GetAppointmentCubit>()..getAppointment(),
              child: MyAppointment(),
            ),
      ),
    ],
  );
}
