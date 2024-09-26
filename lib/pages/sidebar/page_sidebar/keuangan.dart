import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Keuangan extends StatefulWidget {
  const Keuangan({super.key});

  @override
  State<Keuangan> createState() => _KeuanganState();
}

class _KeuanganState extends State<Keuangan> {
  bool isChecked = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Container(
          height: size.height,
          width: size.width,
          color: Color(0xffEBFFF8),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: Column(
                children: [
                  //Transaksi Text
                  Row(
                    children: [
                      Text(
                        "Transaksi",
                        style: GoogleFonts.josefinSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff308967),
                        ),
                      ),
                    ],
                  ),
                  //Pemasukan Pengeluaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Pemasukan
                      Container(
                        width: 290,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff308967),
                        ),
                        child: Center(
                          child: Text(
                            "Pemasukan",
                            style: GoogleFonts.josefinSans(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Pengeluaran
                      Container(
                        width: 290,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Text(
                            "Pengeluaran",
                            style: GoogleFonts.josefinSans(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff308967),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Nominal",
                        style: GoogleFonts.josefinSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff308967),
                        ),
                      ),
                    ],
                  ),
                  //Nominal
                  Text(
                    "Rp 10.000",
                    style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff308967),
                    ),
                  ),
                  //Container
                  Expanded(
                    child: Container(
                      width: 600,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Color(0xff51CB9F),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            //Kontak
                            Row(
                              children: [
                                Text("Kontak",
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            //TF Kontak
                            Container(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Kontak",
                                  hintStyle: GoogleFonts.josefinSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff308967),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            //Tanggal Buat
                            Row(
                              children: [
                                Text("Tanggal Buat",
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            //TF Tgl Buat
                            Container(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Color(0xff308967),
                                  ),
                                  hintText: "17 Sep 2024",
                                  hintStyle: GoogleFonts.josefinSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff308967),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            //Catatan
                            Row(
                              children: [
                                Text("Catatan",
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            //TF Catatan
                            Container(
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Catatan",
                                  hintStyle: GoogleFonts.josefinSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff308967),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            //Checkbox
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: _onCheckboxChanged,
                                ),
                                Text(
                                  "Masukan ke Cashdrawer",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  //Button Simpan
                  Row(
                    children: [
                      Container(
                        width: 180,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color(0xff308967),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Simpan",
                            style: GoogleFonts.josefinSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
