import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/kasir/animasi_kasir/animasi_m_kasir.dart';
import 'package:ttrana_pos/pages/kasir/animasi_kasir/animasi_t_kasir.dart';
import 'package:ttrana_pos/responsive.dart';
import 'package:ttrana_pos/widget/abil_icon_icons.dart';
import 'package:ttrana_pos/pages/admin/animasi/animasi_T.dart';

class SidebarKasir extends StatefulWidget {
  final String? username;
  final Function(int) onItemSelected;
  final bool isManagementExpanded;
  final Function(bool) onManagementExpandToggle;

  const SidebarKasir({
    super.key,
    required this.username,
    required this.onItemSelected,
    required this.isManagementExpanded,
    required this.onManagementExpandToggle,
  });

  @override
  State<SidebarKasir> createState() => _SidebarKasirState();
}

class _SidebarKasirState extends State<SidebarKasir> {
  List<bool> _selected = [
    true,
    false,
    false,
  ]; // Status terpilih
  bool subMenu1 = false;
  bool subMenu2 = false;

  // Fungsi untuk menangani item yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selected = [
        false,
        false,
        false,
      ]; // Reset pilihan
      _selected[index] = true; // Set item yang dipilih
    });

    widget.onItemSelected(index); // Panggil fungsi parent untuk update halaman
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Responsive(
      //MOBILE
      mobile: Container(
        width: size.width * 0.23,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF167960),
              Color(0xFF28DFB1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), // Warna sidebar
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.08,
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Trana.png'),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const CircleAvatar(),
              title: Text(widget.username ?? 'Guest'),
              subtitle: const Text("Admin"),
            ),
            SizedBox(height: size.width * 0.005),
            Expanded(
              child: ListView(
                children: [
                  AnimasiMKasir(
                    icon: AbilIcon.produk,
                    text: "Produk",
                    selected: _selected[0],
                    onTap: () => _onItemTapped(0),
                  ),
                  AnimasiMKasir(
                    icon: Icons.print,
                    text: "print & struk",
                    selected: _selected[1],
                    onTap: () => _onItemTapped(1),
                  ),
                  AnimasiMKasir(
                    icon: Icons.person_2,
                    text: "profile",
                    selected: _selected[2],
                    onTap: () => _onItemTapped(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //INI TABLETTTTTTTTTTTTTTTTTTT
      tablet: Container(
        width: size.width * 0.23,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF167960),
              Color(0xFF28DFB1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), // Warna sidebar
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.08,
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Trana.png'),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const CircleAvatar(),
              title: Text(widget.username ?? 'Guest'),
              subtitle: const Text("Admin"),
            ),
            SizedBox(height: size.width * 0.005),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: size.width * 0.03),
                children: [
                  AnimasiTKasir(
                    icon: AbilIcon.produk,
                    text: "Produk",
                    selected: _selected[0],
                    onTap: () => _onItemTapped(0),
                  ),
                  AnimasiTKasir(
                    icon: Icons.print,
                    text: "print & struk",
                    selected: _selected[1],
                    onTap: () => _onItemTapped(1),
                  ),
                  AnimasiTKasir(
                    icon: Icons.person_2,
                    text: "Profile",
                    selected: _selected[2],
                    onTap: () => _onItemTapped(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
