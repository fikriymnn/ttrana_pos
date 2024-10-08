import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/produk_kasir.dart';
import 'package:ttrana_pos/responsive.dart';

class BayarKasir extends StatefulWidget {
  const BayarKasir({super.key});

  @override
  State<BayarKasir> createState() => _BayarKasirState();
}

class _BayarKasirState extends State<BayarKasir> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: Expanded(
          child: Row(
            children: [
              Container(
                height: size.height,
                width: size.width * 0.25,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      color: Color.fromARGB(255, 73, 142, 125),
                      child: Center(
                        child: Text(
                          "Produk",
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.65,
                      width: size.width,
                      // color: Colors.black,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.073,
                              ),
                              Text(
                                "Rp 1.150.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "PPN",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.077,
                              ),
                              Text(
                                "Rp 50.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Service",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.055,
                              ),
                              Text(
                                "Rp 50.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      child: Row(
                        children: [
                          Text(
                            "Sub Total",
                            style: GoogleFonts.josefinSans(
                                fontSize: size.width * 0.018),
                          ),
                          SizedBox(
                            width: size.width * 0.035,
                          ),
                          Text(
                            "Rp 20.000",
                            style: GoogleFonts.josefinSans(
                                fontSize: size.width * 0.018),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height,
                width: size.width * 0.75,
                color: const Color.fromARGB(255, 202, 231, 239),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.02, left: size.width * 0.01),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: size.width * 0.036,
                              height: size.width * 0.036,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.06),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: size.width * 0.023,
                                  color: Color.fromARGB(255, 73, 142, 125),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        tablet: Expanded(
          child: Row(
            children: [
              Container(
                height: size.height,
                width: size.width * 0.27,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      color: Color.fromARGB(255, 73, 142, 125),
                      child: Center(
                        child: Text(
                          "Produk",
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.65,
                      width: size.width,
                      // color: Colors.black,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.073,
                              ),
                              Text(
                                "Rp 1.150.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "PPN",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.077,
                              ),
                              Text(
                                "Rp 50.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Service",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                              SizedBox(
                                width: size.width * 0.055,
                              ),
                              Text(
                                "Rp 50.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.018),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      child: Row(
                        children: [
                          Text(
                            "Sub Total",
                            style: GoogleFonts.josefinSans(
                                fontSize: size.width * 0.018),
                          ),
                          SizedBox(
                            width: size.width * 0.035,
                          ),
                          Text(
                            "Rp 20.000",
                            style: GoogleFonts.josefinSans(
                                fontSize: size.width * 0.018),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height,
                width: size.width * 0.73,
                color: const Color.fromARGB(255, 202, 231, 239),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.026,
                              left: size.width * 0.026),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: size.width * 0.036,
                              height: size.width * 0.036,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.06),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: size.width * 0.023,
                                  color: Color.fromARGB(255, 73, 142, 125),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rp 114.500",
                      style:
                          GoogleFonts.josefinSans(fontSize: size.width * 0.037),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.035,
                          right: size.width * 0.035,
                          bottom: size.height * 0.01),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Text(
                          "Tunai",
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.17,
                        ),
                        Container(
                          width: size.width * 0.1,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 73, 142, 125),
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.005),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Uang Pas",
                              style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontSize: size.width * 0.015,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.003),
                            ),
                            border: Border.all(
                              width: size.width * 0.001,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Custom",
                              style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontSize: size.width * 0.015,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
