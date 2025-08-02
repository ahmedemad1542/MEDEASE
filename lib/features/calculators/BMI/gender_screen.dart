import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medease1/features/calculators/BMI/input_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void goToInputScreen() {
    if (selectedGender != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InputScreen(gender: selectedGender!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 44.h),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  children: const [
                    TextSpan(
                      text: 'BMI ',
                      style: TextStyle(color: Color(0xFFFFB534)),
                    ),
                    TextSpan(
                      text: 'Calculator',
                      style: TextStyle(color: Color(0xFF65B741)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Please choose your gender',
              style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xff0A1207),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30.h),

            // Male Container
            GestureDetector(
              onTap: () => selectGender("Male"),
              child: Container(
                width: 360.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF0F8EC),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color:
                        selectedGender == "Male"
                            ? Colors.blue
                            : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: const Color(0xff519234),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 70.w),
                    SvgPicture.asset('assets/icons/male_gender.svg'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // Female Container
            GestureDetector(
              onTap: () => selectGender("Female"),
              child: Container(
                width: 360.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: const Color(0xffFBF6EE),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color:
                        selectedGender == "Female"
                            ? Colors.pink
                            : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Row(
                      children: [
                        Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: const Color(0xffCE922A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        SvgPicture.asset('assets/icons/female_gender.svg'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 55.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF65B741),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                minimumSize: Size(340.w, 70.h),
              ),
              onPressed: selectedGender == null ? null : goToInputScreen,
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
