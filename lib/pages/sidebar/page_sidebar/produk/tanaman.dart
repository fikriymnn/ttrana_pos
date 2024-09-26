// Halaman Tanaman
import 'package:flutter/material.dart';

class Tanaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        height: size.width,
        width: size.height * 1.15,
        color: const Color.fromARGB(175, 124, 216, 189),
        child: Center(child: Text("TANAMAN"),),
      ),
    );
  }
}
