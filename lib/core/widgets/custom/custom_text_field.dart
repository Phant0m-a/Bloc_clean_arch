// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  bool obscureText = false;

  CustomTextFields(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
