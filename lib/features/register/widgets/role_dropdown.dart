import 'package:flutter/material.dart';

Widget buildDropdownEnum<T>(
  String label,
  T value,
  List<T> options,
  void Function(T?) onChanged,
  Map<T, String> displayTexts,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items:
          options
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(displayTexts[option]!),
                ),
              )
              .toList(),
      onChanged: onChanged,
    ),
  );
}
