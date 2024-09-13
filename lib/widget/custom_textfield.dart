import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final Icon? prefixIcon;

  const CustomTextfield({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextField(
      obscureText: isPass,
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: const Color(0xFFE3FFF3),
        filled: true, // Agar fillColor terlihat
        hintText: hintText,
        hintStyle: GoogleFonts.josefinSans(
          fontWeight: FontWeight.w300,
          fontSize: size.width * 0.015,
          color: const Color(0xff3F9272),
        ),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
