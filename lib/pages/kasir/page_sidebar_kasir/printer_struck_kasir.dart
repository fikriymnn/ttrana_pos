import 'package:flutter/material.dart';

class PrinterStruckKasir extends StatelessWidget {
  const PrinterStruckKasir({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Center(
        child: Text("Struck & print"),
      ),
    );
  }
}
