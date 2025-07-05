import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final String text;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscured;
  const CustomTextField({
    required this.text,
    required this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.isObscured = false,
    required this.controller,
    required this.validator,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            maxLength: maxLength,
            keyboardType: keyboardType,
            obscureText: isObscured,
            controller: controller,
            validator: validator,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: text,
              hintStyle: const TextStyle(color: Colors.black),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
