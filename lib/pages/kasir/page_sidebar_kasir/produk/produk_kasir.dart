import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/burung.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/ikan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/tanaman.dart';
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
  double changePositionM() {
    switch (current) {
      case 0:
        return 346;
      case 1:
        return 470;
      case 2:
        return 543;

      default:
        return 0;
    }
  }

  double changeContainerWidthM() {
    switch (current) {
      case 0:
        return 105;
      case 1:
        return 54;
      case 2:
        return 83;

      default:
        return 0;
    }
  }

  double changePositionT() {
    switch (current) {
      case 0:
        return 490;
      case 1:
        return 620;
      case 2:
        return 690;

      default:
        return 0;
    }
  }

  double changeContainerWidthT() {
    switch (current) {
      case 0:
        return 108;
      case 1:
        return 50;
      case 2:
        return 85;

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
        mobile: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.4),
                child: const TextField(
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
                        width: size.width * 0.282,
                        height: size.height * 0.054,
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
                                padding:
                                    EdgeInsets.only(left: index == 0 ? 10 : 23),
                                child: Text(
                                  tabs[index],
                                  style: TextStyle(
                                    fontSize: 17,
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
                    left: changePositionM(),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(left: 10),
                      width: changeContainerWidthM(),
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
              // Halaman konten yang berbeda sesuai tab
              SizedBox(height: size.height * 0.03),
              IndexedStack(
                index: current,
                children: [
                  Tanaman(),
                  Ikan(),
                  Burung(),
                ],
              ),
            ],
          ),
        ),
        tablet: SingleChildScrollView(
          child: Stack(
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: size.width * 0.30,
                      left: size.width * 0.30,
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
                            width: size.width * 0.233,
                            height: size.height * 0.05,
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
                                        left: index == 0 ? 10 : 23),
                                    child: Text(
                                      tabs[index],
                                      style: TextStyle(
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
                  // Halaman konten yang berbeda sesuai tab
                  const SizedBox(height: 20),
                  Container(
                    height: size.height * 0.7,
                    width: size.height * 0.7,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
