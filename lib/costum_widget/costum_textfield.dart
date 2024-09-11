import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInpute extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final Icon? prefixIcon; // Tambahkan parameter untuk ikon di kiri

  const TextFieldInpute({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.prefixIcon, // Terima parameter ikon
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3, // Atur lebar
      height: size.height * 0.06, // Atur tinggi
      child: TextField(
        obscureText: isPass,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Color(0xFFE3FFF3),
          filled: true, // Agar fillColor terlihat
          hintText: hintText,
          hintStyle: GoogleFonts.josefinSans(
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Color(0xff3F9272),
          ),
          prefixIcon: prefixIcon, // Tambahkan ikon di kiri

          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
