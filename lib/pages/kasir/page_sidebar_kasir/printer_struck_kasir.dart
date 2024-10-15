import 'package:flutter/material.dart';

class PrinterStruckKasir extends StatefulWidget {
  const PrinterStruckKasir({
    super.key,
  });

  @override
  State<PrinterStruckKasir> createState() => _PrinterStruckKasirState();
}

class _PrinterStruckKasirState extends State<PrinterStruckKasir> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      // color: Colors.black,
      child: Center(
        child: Text("Struck & print"),
      ),
    );
  }
}
