import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/burung.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/ikan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/tanaman.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/Tanaman_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/burung_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/ikan_kasir.dart';
import 'package:ttrana_pos/responsive.dart';

class ProdukKasir extends StatefulWidget {
  const ProdukKasir({super.key});

  @override
  State<ProdukKasir> createState() => _ProdukKasirState();
}

class _ProdukKasirState extends State<ProdukKasir> {
  List<String> tabs = [
    "Tanaman",
    "Ikan",
    "Burung",
  ];
  double changePositionM(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.225;
      case 1:
        return size.width * 0.358;
      case 2:
        return size.width * 0.448;

      default:
        return 0;
    }
  }

  double changeContainerWidthM(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.091;
      case 1:
        return size.width * 0.046;
      case 2:
        return size.width * 0.072;

      default:
        return 0;
    }
  }

  double changePositionT() {
    switch (current) {
      case 0:
        return 296;
      case 1:
        return 443;
      case 2:
        return 538;

      default:
        return 0;
    }
  }

  double changeContainerWidthT() {
    switch (current) {
      case 0:
        return 108;
      case 1:
        return 53;
      case 2:
        return 86;

      default:
        return 0;
    }
  }

  int current = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 202, 231, 239),
      body: Responsive(
        mobile: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                  ),
                  child: Container(
                    height: size.height,
                    width: size.width * 0.23,
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
                                fontSize: size.width * 0.016,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.65,
                          width: size.width,
                          // color: Colors.black,
                        ),
                        const Divider(
                          thickness: 1,
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
                                        fontSize: size.width * 0.016),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.073,
                                  ),
                                  Text(
                                    "Rp 1.150.000",
                                    style: GoogleFonts.josefinSans(
                                        fontSize: size.width * 0.016),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "PPN",
                                    style: GoogleFonts.josefinSans(
                                        fontSize: size.width * 0.016),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.077,
                                  ),
                                  Text(
                                    "Rp 50.000",
                                    style: GoogleFonts.josefinSans(
                                        fontSize: size.width * 0.016),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Service",
                                    style: GoogleFonts.josefinSans(
                                        fontSize: size.width * 0.016),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.055,
                                  ),
                                  Text(
                                    "Rp 50.000",
                                    style: GoogleFonts.josefinSans(
                                        fontSize: size.width * 0.016),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.01),
                          child: Row(
                            children: [
                              Text(
                                "Sub Total",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.016),
                              ),
                              SizedBox(
                                width: size.width * 0.035,
                              ),
                              Text(
                                "Rp 20.000",
                                style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.016),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.35,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.32,
                              height: size.height * 0.05,
                              // color: Colors.black,
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
                                            ? size.width * 0.014
                                            : 40,
                                      ),
                                      child: Text(
                                        tabs[index],
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.02,
                                          fontWeight: current == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: current == index
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        AnimatedPositioned(
                          bottom: 0,
                          left: changePositionM(size),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: changeContainerWidthM(size),
                            height: size.height * 0.004,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        IndexedStack(
                          index: current,
                          children: [
                            TanamanKasir(),
                            IkanKasir(),
                            BurungKasir(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.26,
                ),
                child: Container(
                  width: size.width * 0.739,
                  height: size.height * 0.1,
                  // color: Colors.black,
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
                        width: size.width * 0.12,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 73, 142, 125),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.006),
                        ),
                        child: Center(
                          child: Text(
                            "Bayar",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.016,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        tablet: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                  ),
                  child: Container(
                    height: size.height,
                    width: size.width * 0.23,
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.20,
                        left: size.width * 0.20,
                        top: size.height * 0.05,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: size.height * 0.009,
                            horizontal: size.width * 0.02,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              // color: Colors.black,
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
                                        left: index == 0 ? 20 : 45,
                                      ),
                                      child: Text(
                                        tabs[index],
                                        style: GoogleFonts.josefinSans(
                                          fontSize: 25,
                                          fontWeight: current == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: current == index
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        AnimatedPositioned(
                          bottom: 0,
                          left: changePositionT(),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: const EdgeInsets.only(left: 10),
                            width: changeContainerWidthT(),
                            height: size.height * 0.006,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        IndexedStack(
                          index: current,
                          children: [
                            TanamanKasir(),
                            IkanKasir(),
                            BurungKasir(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.26,
                ),
                child: Container(
                  width: size.width * 0.739,
                  height: size.height * 0.1,
                  // color: Colors.black,
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
                        width: size.width * 0.12,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 73, 142, 125),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.006),
                        ),
                        child: Center(
                          child: Text(
                            "Bayar",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.016,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
