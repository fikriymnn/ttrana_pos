import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TanamanKasir extends StatefulWidget {
  const TanamanKasir({super.key});

  @override
  State<TanamanKasir> createState() => _TanamanKasirState();
}

class _TanamanKasirState extends State<TanamanKasir> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.black,
      child: Center(
        child: Text(
          "Nabil",
          style: GoogleFonts.josefinSans(color: Colors.white),
        ),
      ),
    );
  }
}
