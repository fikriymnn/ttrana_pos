import 'package:flutter/material.dart';

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
    return Container(
      width: 300, // Atur lebar
      height: 60, // Atur tinggi
      child: TextField(
        obscureText: isPass,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Color(0xFFE3FFF3),
          filled: true, // Agar fillColor terlihat
          hintText: hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          prefixIcon: prefixIcon, // Tambahkan ikon di kiri

          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
