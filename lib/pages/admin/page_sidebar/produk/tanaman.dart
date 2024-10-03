// Halaman Tanaman
import 'package:flutter/material.dart';
import 'package:ttrana_pos/responsive.dart';

class Tanaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Responsive(
      mobile: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            height: size.width,
            width: size.height * 1.15,
            color: const Color.fromARGB(175, 124, 216, 189),
            child: Center(
              child: Text("TANAMAN"),
            ),
          ),
        ),
      ),
      tablet: Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            color: const Color.fromARGB(175, 124, 216, 189),
            child: Center(
              child: Text("TANAMAN"),
            ),
          ),
        ),
      ),
    );
  }
}
