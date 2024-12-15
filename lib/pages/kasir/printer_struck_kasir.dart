import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/pages/kasir/models/produk.dart';
import 'package:ttrana_pos/widget/responsive.dart';

class PrinterStruckKasir extends StatefulWidget {
  final double nominalDiberikan;

  const PrinterStruckKasir(
      {super.key,
      required this.nominalDiberikan,
      required double subTotal,
      String? metodePembayaran});

  @override
  State<PrinterStruckKasir> createState() => _PrinterStruckKasirState();
}

class _PrinterStruckKasirState extends State<PrinterStruckKasir> {
  Future<String> getKasirUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Kasir';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final product = context.read<Cart>();

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
                SizedBox(height: size.height * 0.1),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 73, 142, 125),
                  radius: size.width * 0.04,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.height * 0.013),
                Text(
                  "Good Job !",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.02,
                  ),
                ),
                SizedBox(height: size.height * 0.013),
                Text(
                  "Transaksi Sukses",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.013,
                  ),
                ),
                SizedBox(height: size.height * 0.2),
                GestureDetector(
                  onTap: () {
                    product.clearCart();
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
                SizedBox(height: size.height * 0.01),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: Color.fromARGB(255, 73, 142, 125),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.004),
                    ),
                  ),
                  onPressed: () {
                    print("Button Print Struck Clicked");
                    _generateAndPrintPdf();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.print,
                        color: Color.fromARGB(255, 73, 142, 125),
                        size: size.width * 0.023,
                      ),
                      SizedBox(width: size.width * 0.02),
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
                SizedBox(height: size.height * 0.1),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 73, 142, 125),
                  radius: size.width * 0.04,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.height * 0.013),
                Text(
                  "Good Job !",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.02,
                  ),
                ),
                SizedBox(height: size.height * 0.013),
                Text(
                  "Transaksi Sukses",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromARGB(255, 73, 142, 125),
                    fontSize: size.width * 0.013,
                  ),
                ),
                SizedBox(height: size.height * 0.2),
                GestureDetector(
                  onTap: () {
                    product.clearCart();
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
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.37,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        color: Color.fromARGB(255, 73, 142, 125),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.004),
                      ),
                    ),
                    onPressed: () {
                      print("Button Print Struck Clicked");
                      _generateAndPrintPdf();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.print,
                          color: Color.fromARGB(255, 73, 142, 125),
                          size: size.width * 0.023,
                        ),
                        SizedBox(width: size.width * 0.02),
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

  Future<void> _generateAndPrintPdf() async {
    try {
      print("Generating PDF...");
      final pdf = pw.Document();
      final produk = context.read<Cart>();

      int total = produk.cart.fold(0, (previousValue, item) {
        // Pastikan item adalah Map<String, dynamic>
        final product = item['product'] as Product;
        final quantity = item['quantity'] as int;

        // Hitung total harga untuk item ini
        return previousValue + (product.harga!.toInt() * quantity);
              return previousValue;
      });

      double ppn = total * 0.02;
      double serviceFee = 2500;
      double subtotal = total + ppn + serviceFee;
      double kembalian = widget.nominalDiberikan - subtotal;

      final ByteData imageData =
          await rootBundle.load('assets/images/Trana.png');
      final Uint8List imageBytes = imageData.buffer.asUint8List();
      final image = pw.MemoryImage(imageBytes);

      String currentTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      List<pw.Widget> items = [];
      final currencyFormatter = NumberFormat.currency(
          locale: "id_ID", symbol: "Rp ", decimalDigits: 0);

      for (var productEntry in produk.cart) {
        // productEntry adalah Map<String, dynamic>
        final tanaman = productEntry['product'] as Product;
        final quantity = productEntry['quantity'] as int;

        items.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                tanaman.judulProduk!,
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                '$quantity',
                style: pw.TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
            }

      // Mengambil username kasir dari SharedPreferences
      String kasirUsername = await getKasirUsername();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                width: 400,
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 200,
                      height: 100,
                      child: pw.Image(image, fit: pw.BoxFit.cover),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Jl. Melong Tengah No.138, Melong,\nKec. Cimahi Sel.\nKota Cimahi, Jawa Barat,\nIndonesia\n+624789494988',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Waktu Penjualan",
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text("Kasir", style: pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(currentTime, style: pw.TextStyle(fontSize: 18)),
                        pw.Text(kasirUsername,
                            style: pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 7),
                    pw.Container(
                      height: 1,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                              color: PdfColors.black,
                              width: 1,
                              style: pw.BorderStyle.solid),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Item",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                        pw.Text("Jumlah",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                    pw.Container(
                      height: 1,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                              color: PdfColors.black,
                              width: 1,
                              style: pw.BorderStyle.solid),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 7),
                    if (items.isNotEmpty) ...items,
                    pw.SizedBox(height: 7),
                    pw.Container(
                      height: 1,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                              color: PdfColors.black,
                              width: 1,
                              style: pw.BorderStyle.solid),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 7),
                    // Menambahkan PPN dan biaya layanan
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("PPN (2%)",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                        pw.Text(" ${(ppn)}",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Services",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                        pw.Text("Rp 2.500",
                            style: pw.TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Subtotal", style: pw.TextStyle(fontSize: 18)),
                        pw.Text(currencyFormatter.format(subtotal),
                            style: pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Nominal Bayar",
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text(
                            currencyFormatter.format(widget.nominalDiberikan),
                            style: pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Kembalian", style: pw.TextStyle(fontSize: 18)),
                        pw.Text(currencyFormatter.format(kembalian),
                            style: pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Barang yang sudah dibeli tidak\ndapat ditukar\ngaransi toko berlaku 1x24 jam.',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Terimakasih',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      print("Printing PDF...");
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
      print("PDF printed successfully.");
    } catch (e) {
      print("Error printing PDF: $e");
    }
  }
}
