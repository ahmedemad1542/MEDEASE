import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medease1/core/utils/custom_textfield.dart';
import 'package:medease1/features/calculators/Calorie/calorie_output.dart';

class CalorieInputScreen extends StatefulWidget {
  const CalorieInputScreen({super.key});

  @override
  State<CalorieInputScreen> createState() => _CalorieInputScreenState();
}

class _CalorieInputScreenState extends State<CalorieInputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = 'Male';
  String goal = 'Maintain Weight';
  String activityLevel = 'Sedentary';

  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Super Active',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF65B741),
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/arrow_back.svg"),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Calorie Calculator",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: ageController,
              hintText: "Enter your Age",
              inputType: TextInputType.number,
              label: 'Age',
            ),
            SizedBox(height: 25.h),
            CustomTextField(
              controller: heightController,
              hintText: "Enter your Height (cm)",
              label: 'Height (cm)',
              inputType: TextInputType.number,
            ),
            SizedBox(height: 25.h),
            CustomTextField(
              controller: weightController,
              hintText: "Enter your Weight (kg)",
              inputType: TextInputType.number,
              label: 'Weight (kg)',
            ),
            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => gender = value!),
            ),
            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: goal,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Goal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  ['Lose Weight', 'Maintain Weight', 'Gain Weight'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => goal = value!),
            ),
            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: activityLevel,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Activity Level',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  activityLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => activityLevel = value!),
            ),

            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CalorieOutputScreen(
                          age: int.tryParse(ageController.text) ?? 0,
                          height: double.tryParse(heightController.text) ?? 0.0,
                          weight: double.tryParse(weightController.text) ?? 0.0,
                          gender: gender,
                          goal: goal,
                          activityLevel: activityLevel,
                        ),
                  ),
                );
              },
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF65B741),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
