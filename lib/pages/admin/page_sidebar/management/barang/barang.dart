import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/management/barang/burung_management.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/management/barang/ikan_management.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/management/barang/tanaman_management.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/burung.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/ikan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/tanaman.dart';
import 'package:ttrana_pos/responsive.dart';

class Barang extends StatefulWidget {
  const Barang({super.key});

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  List<String> tabs = [
    "Tanaman",
    "Ikan",
    "Burung",
  ];

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
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.234,
                          height: size.height * 0.06,
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
                                        ? size.width * 0.006
                                        : size.width * 0.03,
                                  ),
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.25,
                  left: size.width * 0.25,
                  top: size.height * 0.05,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
              // Halaman konten yang berbeda sesuai tab
              const SizedBox(height: 20),
              IndexedStack(
                index: current,
                children: const [
                  TanamanManagement(),
                  IkanManagement(),
                  BurungManagement(),
                ],
              ),
            ],
          ),
        ),
        tablet: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.233,
                          height: size.height * 0.052,
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.25,
                  left: size.width * 0.25,
                  top: size.height * 0.04,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
              // Halaman konten yang berbeda sesuai tab
              SizedBox(height: size.width * 0.02),
              IndexedStack(
                index: current,
                children: const [
                  TanamanManagement(),
                  IkanManagement(),
                  BurungManagement(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
