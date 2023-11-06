import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextFiled extends StatelessWidget {
  CustomFormTextFiled(
      {super.key,
      this.onChanged,
      required this.hintText,
      required this.obscureText});
  String? hintText;
  Function(String)? onChanged;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
