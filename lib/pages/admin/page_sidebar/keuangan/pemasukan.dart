import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/responsive.dart';

class Pemasukan extends StatefulWidget {
  const Pemasukan({super.key});

  @override
  State<Pemasukan> createState() => _PemasukanState();
}

class _PemasukanState extends State<Pemasukan> {
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Responsive(
      mobile: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.44,
                  color: Color(0xFF28DFB1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.017,
                      ),
                      Text(
                        "Nominal",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.023,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.019,
                      ),
                      Text(
                        "Rp 10.000",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: size.width * 0.001,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.02,
                          right: size.width * 0.02,
                          top: size.height * 0.06,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Riwayat Perbulan",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.016,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.1,
                              child: TextField(
                                controller: _dateController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.date_range,
                                    color: Color.fromARGB(255, 34, 160, 129),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Riwayat Perbulan",
                                  hintStyle: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.015,
                                    color:
                                        const Color.fromARGB(255, 34, 160, 129),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    // top: size.height * 0.01,
                                    bottom: size.height * 0.03,
                                    left: size.width * 0.01,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.width * 0.14,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 34, 160, 129),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Simpan",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      tablet: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.44,
                  color: Color(0xFF28DFB1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.017,
                      ),
                      Text(
                        "Nominal",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.023,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.019,
                      ),
                      Text(
                        "Rp 10.000",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: size.width * 0.001,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.02,
                          right: size.width * 0.02,
                          top: size.height * 0.06,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Riwayat Perbulan",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.016,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.1,
                              child: TextField(
                                controller: _dateController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.date_range,
                                    color: Color.fromARGB(255, 34, 160, 129),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Riwayat Perbulan",
                                  hintStyle: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.015,
                                    color:
                                        const Color.fromARGB(255, 34, 160, 129),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    // top: size.height * 0.01,
                                    bottom: size.height * 0.03,
                                    left: size.width * 0.01,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.width * 0.14,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 34, 160, 129),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Cari",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
