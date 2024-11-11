import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputNominal extends StatelessWidget {
  final Function(String) onNominalChanged; // Terima fungsi callback

  const InputNominal({super.key, required this.onNominalChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _controller = TextEditingController();

    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: size.height * 0.002,
          left: size.width * 0.005,
        ),
        hintText: "Masukan Nominal",
        hintStyle: GoogleFonts.josefinSans(
          color: const Color.fromARGB(255, 73, 142, 125),
          fontSize: size.width * 0.019,
        ),
        border: InputBorder.none,
      ),
      onChanged: onNominalChanged, // Gunakan callback di sini
    );
  }
}
