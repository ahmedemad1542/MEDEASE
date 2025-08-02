/*import 'package:flutter/material.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String weightUnit = 'Kg';
  String heightUnit = 'Cm';
  String gender = 'Male';
  String activityLevel = 'Select Activity Level';
  String goal = 'Select your goal';

  bool showResult = false;
  double bmr = 0.0;
  double tdee = 0.0;

  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Super Active'
  ];

  final List<String> goals = ['Maintain', 'Lose', 'Gain'];

  void calculateCalories() {
    final age = int.tryParse(ageController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0.0;
    final height = double.tryParse(heightController.text) ?? 0.0;

    double weightKg = (weightUnit == 'Kg') ? weight : weight * 0.4536;
    double heightCm = (heightUnit == 'Cm') ? height : height * 30.48;

    if (gender == 'Male') {
      bmr = 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      bmr = 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }

    double activityMultiplier = 1.2;
    switch (activityLevel) {
      case 'Lightly Active':
        activityMultiplier = 1.375;
        break;
      case 'Moderately Active':
        activityMultiplier = 1.55;
        break;
      case 'Very Active':
        activityMultiplier = 1.725;
        break;
      case 'Super Active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.2;
    }

    tdee = bmr * activityMultiplier;

    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calorie Intake Calculator')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your details to calculate daily calorie needs.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Age
            Row(
              children: [
                Text('Age:'),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your age',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('years'),
              ],
            ),
            SizedBox(height: 16),

            // Weight
            Row(
              children: [
                Text('Weight:'),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your weight',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ToggleButtons(
                  isSelected: [weightUnit == 'Kg', weightUnit == 'Lbs'],
                  onPressed: (index) {
                    setState(() {
                      weightUnit = index == 0 ? 'Kg' : 'Lbs';
                    });
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Kg'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Lbs'),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),

            // Height
            Row(
              children: [
                Text('Height:'),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your height',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ToggleButtons(
                  isSelected: [heightUnit == 'Cm', heightUnit == 'Ft'],
                  onPressed: (index) {
                    setState(() {
                      heightUnit = index == 0 ? 'Cm' : 'Ft';
                    });
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Cm'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Ft'),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),

            // Gender
            Row(
              children: [
                Text('Gender:'),
                SizedBox(width: 10),
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),

            // Activity Level
            DropdownButtonFormField<String>(
              value: activityLevel == 'Select Activity Level'
                  ? null
                  : activityLevel,
              decoration: InputDecoration(
                labelText: 'Activity Level',
              ),
              items: activityLevels
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  activityLevel = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // Goal
            DropdownButtonFormField<String>(
              value: goal == 'Select your goal' ? null : goal,
              decoration: InputDecoration(
                labelText: 'Goal',
              ),
              items: goals
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  goal = value!;
                });
              },
            ),
            SizedBox(height: 24),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateCalories,
                child: Text('Calculate'),
              ),
            ),

            if (showResult) ...[
              SizedBox(height: 32),
              Image.asset('assets/images/calorie.png'), // حط صورة هنا زي التصميم
              SizedBox(height: 16),
              Text(
                'Result',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('BMR: ${bmr.toStringAsFixed(1)} calories/day'),
              Text('TDEE: ${tdee.toStringAsFixed(1)} calories/day'),
              SizedBox(height: 12),
              Text(
                'These calculations show that with the given weight, height, age, and activity level, a $gender would need approximately ${tdee.toStringAsFixed(0)} calories per day to maintain weight. Adjustments can be made depending on your goal.',
              )
            ]
          ],
        ),
      ),
    );
  }
}
*/
