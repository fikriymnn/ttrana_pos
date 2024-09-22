import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/barang.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/kategori.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/keuangan.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/pengaturan.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/produk.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/stok.dart';
import 'package:ttrana_pos/pages/sidebar/page_sidebar/tambah_produk.dart';
import 'package:ttrana_pos/pages/sidebar/sidebar_widget.dart';

class MainPage extends StatefulWidget {
  final String? username;
  const MainPage({super.key, this.username});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Indeks untuk menyimpan halaman yang dipilih
  bool _isManagementExpanded = false; // Status apakah dropdown terbuka

  // Fungsi untuk meng-handle perubahan item yang dipilih
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Daftar halaman berdasarkan item sidebar yang dipilih
  final List<Widget> _pages = [
    Produk(),
    Keuangan(), 
    Barang(), 
    Kategori(), 
    Stok(), 
    TambahProduk(),
    Pengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            onItemSelected: _onItemSelected,
            isManagementExpanded: _isManagementExpanded,
            onManagementExpandToggle: (value) {
              setState(() {
                _isManagementExpanded = value;
              });
            },
          ), // Sidebar
          Expanded(
            child:
                _pages[_selectedIndex], // Tampilkan halaman berdasarkan pilihan
          ),
        ],
      ),
    );
  }
}
