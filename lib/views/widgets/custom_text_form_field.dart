import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hText,
    this.pIcon,
    this.sIcon,
    this.isEmail = false,
    this.isPass = false,
    this.controller,
  });

  final String hText;
  final Widget? pIcon;
  final Widget? sIcon;
  final bool isEmail;
  final bool isPass;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPass,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        } else if (isEmail && !value.contains('@')) {
          return 'enter a vaild email';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIcon: pIcon,
        suffixIcon: sIcon,
        fillColor: const Color.fromARGB(255, 222, 221, 221),
        filled: true,
        hintText: hText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}