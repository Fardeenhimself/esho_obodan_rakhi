import 'package:flutter/material.dart';

class MyAuthTextField extends StatelessWidget {
  const MyAuthTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.maxLength,
    this.focusNode,
  });

  final String hintText;
  final bool obscureText;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: TextField(
        cursorColor: Colors.black,
        textCapitalization: TextCapitalization.sentences,
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.green.shade50,
          filled: true,
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: Colors.green.shade900,
        ),
      ),
    );
  }
}
