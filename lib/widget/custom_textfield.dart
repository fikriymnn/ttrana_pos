import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconButton? prefixIcon;
  final TextInputType typeKeyword;

  const CustomTextfield({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    this.prefixIcon, required this.typeKeyword,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextField(
      obscureText: isPass,
      controller: textEditingController,
      keyboardType: typeKeyword,
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
