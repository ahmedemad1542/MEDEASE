import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputDecoration? decoration;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly = false;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.validator,
    this.keyboardType,
    this.decoration,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
