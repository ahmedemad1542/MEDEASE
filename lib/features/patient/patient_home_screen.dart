// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medease1/core/routing/app_routes.dart';
// import 'package:medease1/core/utils/service_locator.dart';
// import 'package:medease1/features/profile/cubit/profile_cubit.dart';
// import 'package:medease1/features/profile/repo/profile_repo.dart';

// class PatientHomeScreen extends StatelessWidget {
//   const PatientHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileCubit(sl<ProfileRepo>()),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 100.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 20.w),
//                 child: Text(
//                   " Welcome to MedEase",
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: InkWell(
//                   onTap: () {
//                     context.pushNamed(AppRoutes.profileScreen);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 100.h,
//                     decoration: BoxDecoration(color: Colors.indigoAccent),
//                     child: Center(
//                       child: Text(
//                         "Profile",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: InkWell(
//                   onTap: () {
//                     context.pushNamed(AppRoutes.doctorsScreen);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 100.h,
//                     decoration: BoxDecoration(color: Colors.indigoAccent),
//                     child: Center(
//                       child: Text(
//                         "Make an Appointment",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: InkWell(
//                   onTap: () {
//                     context.pushNamed(AppRoutes.myAppointmentsScreen);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 100.h,
//                     decoration: BoxDecoration(color: Colors.indigoAccent),
//                     child: Center(
//                       child: Text(
//                         "Show My Appointment",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: InkWell(
//                   onTap: () {
//                     context.pushNamed(AppRoutes.advicesScreen);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 100.h,
//                     decoration: BoxDecoration(color: Colors.indigoAccent),
//                     child: Center(
//                       child: Text(
//                         "Advices",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: InkWell(
//                   onTap: () {
//                     context.pushNamed(AppRoutes.advertisementScreen);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 100.h,
//                     decoration: BoxDecoration(color: Colors.indigoAccent),
//                     child: Center(
//                       child: Text(
//                         "Advertisement",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
//                 child: Container(
//                   width: double.infinity,
//                   height: 100.h,
//                   decoration: BoxDecoration(color: Colors.indigoAccent),
//                   child: Center(
//                     child: Text(
//                       "BMI Calculator",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
