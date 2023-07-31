import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Icon icon;
  final TextEditingController controller;
  // optional
  final String? hintText;
  final TextInputType? textInputType;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      required this.obscureText,
      this.hintText,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: icon,
        label: Text(label),
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
