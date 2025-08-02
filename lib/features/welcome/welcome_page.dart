import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/generated/l10n.dart';
import 'package:medease1/core/routing/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 280.w,
                  height: 350.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    child: Image.asset('images/welcome.jpg', fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25.sp),
                  child: Text(
                    S.of(context).Welcome,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Text(
                    S.of(context).description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: double.infinity, // Full width of the parent
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2F4EFF),
                    ),
                    child: Text(
                      S.of(context).login,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.registerScreen);
                  },
                  child: Text(
                    S.of(context).createAccount,
                    style: TextStyle(color: Color(0xFF2F4EFF)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
