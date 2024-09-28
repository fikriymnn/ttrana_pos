// Halaman Tanaman
import 'package:flutter/material.dart';

class Burung extends StatefulWidget {
  @override
  State<Burung> createState() => _BurungState();
}

class _BurungState extends State<Burung> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        height: size.width,
        width: size.height * 1.15,
        color: const Color.fromARGB(175, 124, 216, 189),
        child: Center(child: Text("BURUNG"),),
      ),
    );
  }
}
