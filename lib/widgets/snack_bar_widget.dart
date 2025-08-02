import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

showAnimatedSnackBar(
  context, {
  required message,
  AnimatedSnackBarType? type,
  String? title,
}) {
  AnimatedSnackBar.rectangle(
    '$title',
    message,
    type: type ?? AnimatedSnackBarType.success,
    brightness: Brightness.light,
    duration: const Duration(seconds: 2),
  ).show(context);
}
