import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOutlineButton extends StatelessWidget {
  final String teks;
  final void Function()? onTap;
  MyOutlineButton({super.key, required this.teks, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            teks,
            style: GoogleFonts.josefinSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
