import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/burung.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/ikan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/tanaman.dart';
import 'package:ttrana_pos/responsive.dart';

class Produk extends StatefulWidget {
  const Produk({super.key});

  @override
  State<Produk> createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
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

  double changePositionT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.27;
      case 1:
        return size.width * 0.368;
      case 2:
        return size.width * 0.423;

      default:
        return 0;
    }
  }

  double changeContainerWidthT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.081;
      case 1:
        return size.width * 0.039;
      case 2:
        return size.width * 0.067;

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
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              SizedBox(
                height: size.height * 0.09,
                width: size.width * 0.32,
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.25,
                  left: size.width * 0.25,
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
                      SizedBox(
                        height: 50,
                      ),
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
                                padding:
                                    EdgeInsets.only(left: index == 0 ? 10 : 23),
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
                    left: changePositionT(size),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(left: 10),
                      width: changeContainerWidthT(size),
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
      ),
    );
  }
}
