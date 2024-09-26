// Halaman Tanaman
import 'package:flutter/material.dart';

class Ikan extends StatefulWidget {
  @override
  State<Ikan> createState() => _IkanState();
}

class _IkanState extends State<Ikan> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        height: size.width,
        width: size.height * 1.15,
        color: const Color.fromARGB(175, 124, 216, 189),
        child: Center(child: Text("IKAN"),),
      ),
    );
  }
}
