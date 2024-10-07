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

    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height * 0.9,
            // color: const Color.fromARGB(255, 161, 143, 143),
            child: Center(
              child: Text("Tanaman"),
            ),
          ),
        ),
      ],
    );
  }
}
