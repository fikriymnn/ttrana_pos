import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/responsive.dart';

class BayarBerhasilKasir extends StatelessWidget {
  const BayarBerhasilKasir({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Product = context.read<Cart>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 231, 239),
      body: Responsive(
        mobile: Center(
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(size.width * 0.001, size.width * 0.001),
                  blurRadius: size.width * 0.001,
                  spreadRadius: size.width * 0.001,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 73, 142, 125),
                  radius: size.width * 0.04,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.013,
                ),
                Text(
                  "Good Job !",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.02,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.009,
                ),
                Text(
                  "Transaksi Sukses",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.013,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                GestureDetector(
                  onTap: () {
                    Product.clearCart();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageKasir()));
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 142, 125),
                      borderRadius: BorderRadius.circular(size.width * 0.004),
                    ),
                    child: Center(
                      child: Text(
                        "New Transaction",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.02,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.004),
                    border: Border.all(
                      color: Color.fromARGB(255, 73, 142, 125),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Icon(
                          Icons.print,
                          color: Color.fromARGB(255, 73, 142, 125),
                          size: size.width * 0.023,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "Print Struck",
                          style: GoogleFonts.josefinSans(
                            color: Color.fromARGB(255, 73, 142, 125),
                            fontSize: size.width * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        tablet: Center(
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(size.width * 0.001, size.width * 0.001),
                  blurRadius: size.width * 0.001,
                  spreadRadius: size.width * 0.001,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 73, 142, 125),
                  radius: size.width * 0.04,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.013,
                ),
                Text(
                  "Good Job !",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.02,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.009,
                ),
                Text(
                  "Transaksi Sukses",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.013,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                GestureDetector(
                  onTap: () {
                    Product.clearCart();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageKasir()));
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 142, 125),
                      borderRadius: BorderRadius.circular(size.width * 0.004),
                    ),
                    child: Center(
                      child: Text(
                        "New Transaction",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.02,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.004),
                    border: Border.all(
                      color: Color.fromARGB(255, 73, 142, 125),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Icon(
                          Icons.print,
                          color: Color.fromARGB(255, 73, 142, 125),
                          size: size.width * 0.023,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "Print Struck",
                          style: GoogleFonts.josefinSans(
                            color: Color.fromARGB(255, 73, 142, 125),
                            fontSize: size.width * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
