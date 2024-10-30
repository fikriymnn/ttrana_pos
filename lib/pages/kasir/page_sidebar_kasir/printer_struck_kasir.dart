import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/pages/kasir/models/produk.dart';

class PrinterStruckKasir extends StatefulWidget {
  const PrinterStruckKasir({super.key});

  @override
  State<PrinterStruckKasir> createState() => _PrinterStruckKasirState();
}

class _PrinterStruckKasirState extends State<PrinterStruckKasir> {
  final TextEditingController _nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Printer Struck Kasir')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal Uang yang Diberikan',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAndPrintPdf,
              child: const Text('Cetak Struk'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateAndPrintPdf() async {
    final pdf = pw.Document();
    final produk = context.read<Cart>();

    int total = produk.cart.fold(0, (previousValue, productEntry) {
      if (productEntry is Map<Product, int>) {
        final tanaman = productEntry.keys.first;
        final quantity = productEntry[tanaman]!;
        return previousValue + (tanaman.harga * quantity);
      }
      return previousValue;
    });

    double ppn = total * 0.02;
    double serviceFee = 2500;
    double subtotal = total + ppn + serviceFee;

    // Convert nominal input ke double
    double nominalDiberikan = double.tryParse(_nominalController.text) ?? 0;
    double kembalian = nominalDiberikan - subtotal;

    final ByteData imageData = await rootBundle.load('assets/images/Trana.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    String currentTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    List<pw.Widget> items = [];
    final currencyFormatter =
        NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0);

    for (var productEntry in produk.cart) {
      if (productEntry is Map<Product, int>) {
        final tanaman = productEntry.keys.first;
        final quantity = productEntry[tanaman]!;
        items.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(tanaman.judulProduk, style: pw.TextStyle(fontSize: 16)),
              pw.Text('$quantity', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
        );
      }
    }

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
                      child: pw.Image(image, fit: pw.BoxFit.cover)),
                  pw.SizedBox(height: 20),
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'Jl. Melong Tengah No.138, Melong,\nKec. Cimahi Sel.\nKota Cimahi, Jawa Barat,\nIndonesia\n+624789494988',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold),
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
                      pw.Text("Nama Kasir", style: pw.TextStyle(fontSize: 18)),
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
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Item", style: pw.TextStyle(fontSize: 18)),
                      pw.Text("Jumlah", style: pw.TextStyle(fontSize: 18)),
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
                  if (items.isEmpty)
                    pw.Text("Tidak ada item untuk dicetak",
                        style: pw.TextStyle(color: PdfColors.red)),
                  pw.SizedBox(height: 10),
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
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("PPN (2%)", style: pw.TextStyle(fontSize: 18)),
                      pw.Text(currencyFormatter.format(ppn),
                          style: pw.TextStyle(fontSize: 18)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Services", style: pw.TextStyle(fontSize: 18)),
                      pw.Text(currencyFormatter.format(serviceFee),
                          style: pw.TextStyle(fontSize: 18)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Subtotal", style: pw.TextStyle(fontSize: 18)),
                      pw.Text(currencyFormatter.format(subtotal),
                          style: pw.TextStyle(fontSize: 18)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Nominal Bayar",
                          style: pw.TextStyle(fontSize: 18)),
                      pw.Text(currencyFormatter.format(nominalDiberikan),
                          style: pw.TextStyle(fontSize: 18)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
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
                        fontSize: 24,
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
                          fontSize: 24, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
