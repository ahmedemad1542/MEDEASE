import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:medease1/core/utils/bmi_utils.dart';

class InputScreen extends StatefulWidget {
  final String gender;
  const InputScreen({super.key, required this.gender});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  int age = 20;
  int weight = 65;
  int height = 170;
  late RulerPickerController _rulerPickerController;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/arrow_back.svg"),
                    ),
                    Expanded(
                      child: Center(
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Please Modify the values',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Weight container
                  _buildInputBox(
                    label: 'Weight',
                    value: weight,
                    onIncrement: () {
                      setState(() {
                        weight++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (weight > 0) weight--;
                      });
                    },
                  ),
                  SizedBox(width: 30.w),
                  // Age container
                  _buildInputBox(
                    label: 'Age',
                    value: age,
                    onIncrement: () {
                      setState(() {
                        age++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (age > 0) age--;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 360.w,
                  height: 205.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xffFBF6EE),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        'Height (cm)',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xffACACAC),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        '$height',
                        style: TextStyle(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffCE922A),
                        ),
                      ),
                      SizedBox(
                        width: 320.w,
                        height: 61.h,
                        child: RulerPicker(
                          controller: _rulerPickerController,
                          onValueChanged: (value) {
                            setState(() {
                              height = value.toInt();
                            });
                          },
                          onBuildRulerScaleText: (index, value) {
                            return value.toInt().toString();
                          },
                          ranges: const [
                            RulerRange(begin: 100, end: 250, scale: 1),
                          ],
                          scaleLineStyleList: const [
                            ScaleLineStyle(
                              color: Color(0xffC4C4C4),
                              width: 1.5,
                              height: 50,
                              scale: 0,
                            ),
                            ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 20,
                              scale: 5,
                            ),
                            ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 10,
                              scale: -1,
                            ),
                          ],
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          rulerMarginTop: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65B741),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(340, 70),
                ),
                onPressed: () {
                  double bmi = calculateBMI(weight.toDouble(), height.toDouble());
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Your BMI:", style: TextStyle(fontSize: 18)),
                            SizedBox(height: 10),
                            Text(
                              bmi.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Height: $height cm"),
                            Text("Weight: $weight kg"),
                            Text("Age: $age"),
                            Text("Gender: ${widget.gender}"),
                            SizedBox(height: 10),
                            Text(
                              "Healthy weight for the height:\n${getHealthyRange(height.toDouble())}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF65B741),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text("Close", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('Calculate', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xffFBF6EE),
      ),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xffACACAC),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 13.h),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xffCE922A),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Color(0xff9D6F1F),
                      size: 25.sp,
                    ),
                    onPressed: onIncrement,
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Color(0xff9D6F1F),
                    size: 25.sp,
                  ),
                  onPressed: onDecrement,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
