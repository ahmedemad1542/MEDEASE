import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/generated/l10n.dart';
import 'package:medease1/core/routing/app_routes.dart';

class BuildLoginText extends StatelessWidget {
  const BuildLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).alreadyHaveAccount,
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
          InkWell(
            onTap: () => context.pushReplacement(AppRoutes.loginScreen),
            child: Text(
              "login",
              style: TextStyle(
                color: Color(0xFF2F4EFF),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
