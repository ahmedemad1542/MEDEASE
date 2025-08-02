import 'package:flutter/material.dart';

class CalorieOutputScreen extends StatelessWidget {
  final int age;
  final double height;
  final double weight;
  final String gender;
  final String goal;
  final String activityLevel;

  const CalorieOutputScreen({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.goal,
    required this.activityLevel,
  });

  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double getActivityFactor() {
    switch (activityLevel) {
      case 'Sedentary':
        return 1.2;
      case 'Lightly Active':
        return 1.375;
      case 'Moderately Active':
        return 1.55;
      case 'Very Active':
        return 1.725;
      case 'Super Active':
        return 1.9;
      default:
        return 1.2;
    }
  }

  double calculateTDEE() {
    final bmr = calculateBMR();
    final tdee = bmr * getActivityFactor();

    switch (goal) {
      case 'Lose Weight':
        return tdee - 500;
      case 'Gain Weight':
        return tdee + 500;
      case 'Maintain Weight':
      default:
        return tdee;
    }
  }

  @override
  Widget build(BuildContext context) {
    final calories = calculateTDEE().round();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: "You need approximately\n"),
                TextSpan(
                  text: "$calories calories\n",
                  style: const TextStyle(color: Colors.green),
                ),
                const TextSpan(text: "per day to "),
                TextSpan(text: goal, style: const TextStyle(color: Colors.red)),
                const TextSpan(text: "."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
