import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/printer_struck_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/produk_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/profile_kasir.dart';
import 'package:ttrana_pos/pages/kasir/sidebar_kasir.dart';

class MainPageKasir extends StatefulWidget {
  final String? username;
  final bool? pageSize;
  const MainPageKasir({
    super.key,
    this.pageSize,
    this.username,
  });

  @override
  _MainPageKasirState createState() => _MainPageKasirState();
}

class _MainPageKasirState extends State<MainPageKasir> {
  int _selectedIndex = 0; // Indeks untuk menyimpan halaman yang dipilih

  // Fungsi untuk meng-handle perubahan item yang dipilih
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Daftar halaman berdasarkan item sidebar yang dipilih
  final List<Widget> _pages = [
    const ProdukKasir(),
    const PrinterStruckKasir(),
    const ProfileKasir(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Expanded(
            child:
                _pages[_selectedIndex], // Tampilkan halaman berdasarkan pilihan
          ),
          SidebarKasir(
            onItemSelected: _onItemSelected,
            username: widget.username ?? 'Guest',
          ),
        ],
      ),
    );
  }
}
