import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/printer_struck.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/produk.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/profile.dart';
import 'package:ttrana_pos/pages/admin/sidebar.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/printer_struck_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/profile_kasir.dart';
import 'package:ttrana_pos/pages/kasir/sidebar_kasir.dart';

class MainPageKasir extends StatefulWidget {
  final String? username;
  const MainPageKasir({super.key, this.username});

  @override
  _MainPageKasirState createState() => _MainPageKasirState();
}

class _MainPageKasirState extends State<MainPageKasir> {
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
    const ProdukKasir(),
    const PrinterStruckKasir(),
    const ProfileKasir(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarKasir(
            onItemSelected: _onItemSelected,
            isManagementExpanded: _isManagementExpanded,
            onManagementExpandToggle: (value) {
              setState(() {
                _isManagementExpanded = value;
              });
            },
            username: widget.username ?? 'Guest',
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
