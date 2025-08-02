import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/features/calculators/BMI/gender_screen.dart';
import 'package:medease1/features/calculators/Calorie/calorie_input.dart';

import 'package:medease1/features/calculators/calorie_calculator_page.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculators")),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GenderScreen()));},
                child: Container(
                  width: 360.w,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      'BMI Calculator',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xff0A1207),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalorieInputScreen()));
              },
                child: Container(
                  width: 360.w,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      'Calorie Calculator',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xff0A1207),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
