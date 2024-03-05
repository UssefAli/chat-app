import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.keyType,
      required this.onChanged,
      this.validator,
      this.obscureText,
      this.suffixIcon,
      this.controller});
  final String hintText;
  final TextInputType keyType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      obscureText: obscureText ?? false,
      cursorColor: Colors.white60,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.white60,
        hintText: hintText,
        hoverColor: Colors.white60,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.white60),
        ),
        errorStyle: const TextStyle(
            color: Colors.red, fontSize: 10, fontWeight: FontWeight.w600),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.white60),
        ),
        hintStyle: const TextStyle(color: Colors.white60),
      ),
      keyboardType: keyType,
    );
  }
}
