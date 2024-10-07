import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/keuangan/pemasukan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/keuangan/pengeluaran.dart';
import 'package:ttrana_pos/responsive.dart';

class Keuangan extends StatefulWidget {
  const Keuangan({super.key});

  @override
  State<Keuangan> createState() => _KeuanganState();
}

class _KeuanganState extends State<Keuangan> {
  List<String> tabs = [
    "Pemasukan",
    "Pengeluaran",
  ];

  double changePositionM() {
    switch (current) {
      case 0:
        return 117;
      case 1:
        return 301;

      default:
        return 0;
    }
  }

  double changeContainerWidthM() {
    switch (current) {
      case 0:
        return 186;
      case 1:
        return 202;

      default:
        return 0;
    }
  }

  double changePositionT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.153;
      case 1:
        return size.width * 0.377;

      default:
        return 0;
    }
  }

  double changeContainerWidthT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.225;
      case 1:
        return size.width * 0.225;

      default:
        return 0;
    }
  }

  int current = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.16,
                ),
                child: Row(
                  children: [
                    Text(
                      "Transaksi",
                      style: GoogleFonts.josefinSans(
                        color: const Color(0xFF167960),
                        fontSize: size.width * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    // bottom: 0,
                    left: changePositionM(),
                    curve: Curves.easeInOutBack,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: changeContainerWidthM(),
                      height: size.height * 0.054,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 34, 160, 129),
                      ),
                    ),
                    duration: const Duration(milliseconds: 500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.48,
                        height: size.height * 0.054,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 34, 160, 129),
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0
                                      ? size.width * 0.05
                                      : size.width * 0.11,
                                ),
                                child: Text(
                                  tabs[index],
                                  style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.024,
                                    fontWeight: FontWeight.normal,
                                    color: current == index
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 34, 160, 129),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.16,
              ),
              IndexedStack(
                index: current,
                children: const [
                  Pemasukan(),
                  Pengeluaran(),
                ],
              ),
            ],
          ),
        ),
        tablet: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.16,
                ),
                child: Row(
                  children: [
                    Text(
                      "Transaksi",
                      style: GoogleFonts.josefinSans(
                        color: Color(0xFF167960),
                        fontSize: size.width * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    // bottom: 0,
                    left: changePositionT(size),
                    curve: Curves.easeInOutBack,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(left: 10),
                      width: changeContainerWidthT(size),
                      height: size.height * 0.054,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 34, 160, 129),
                      ),
                    ),
                    duration: const Duration(milliseconds: 500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.45,
                        height: size.height * 0.054,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 34, 160, 129),
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0
                                      ? size.width * 0.05
                                      : size.width * 0.09,
                                ),
                                child: Text(
                                  tabs[index],
                                  style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.024,
                                    fontWeight: FontWeight.normal,
                                    color: current == index
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 34, 160, 129),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.16,
              ),
              IndexedStack(
                index: current,
                children: const [
                  Pemasukan(),
                  Pengeluaran(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
