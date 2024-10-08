import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/keuangan/modal.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/produk.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/profile.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/tambah_produk.dart';
import 'package:ttrana_pos/pages/admin/sidebar.dart';

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
    const Produk(),
    const Modal(),
    const TambahProduk(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
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
