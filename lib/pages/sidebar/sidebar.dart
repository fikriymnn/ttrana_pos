import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ttrana_pos/widget/abil_icon_icons.dart';
import 'package:ttrana_pos/pages/sidebar/animation.dart';

class Sidebar extends StatefulWidget {
  final String? username;
  final Function(int) onItemSelected;
  final bool isManagementExpanded;
  final Function(bool) onManagementExpandToggle;

  const Sidebar({
    super.key,
    required this.username,
    required this.onItemSelected,
    required this.isManagementExpanded,
    required this.onManagementExpandToggle,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<bool> _selected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ]; // Status terpilih
  bool isManagementMenuExpanded = false; // For submenu visibility control

  // Fungsi untuk menangani item yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selected = [
        false,
        false,
        false,
        false,
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
    return Container(
      width: size.width * 0.23,
      decoration: BoxDecoration(
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
                Animasi(
                  icon: AbilIcon.produk,
                  text: "Produk",
                  selected: _selected[0],
                  onTap: () => _onItemTapped(0),
                ),
                Animasi(
                  icon: AbilIcon.keuangan,
                  text: "Keuangan",
                  selected: _selected[1],
                  onTap: () => _onItemTapped(1),
                ),
                // Custom Management Submenu with Animasi
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    top: size.width * 0.005,
                    bottom: size.width * 0.005,
                  ),
                  child: SizedBox(
                    height: size.width * 0.046,
                    // color: Colors.black,
                    child: ListTile(
                      leading: const Icon(
                        AbilIcon.menejemen,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.015,
                        ),
                      ),
                      trailing: Icon(
                        isManagementMenuExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          isManagementMenuExpanded = !isManagementMenuExpanded;
                        });
                      },
                    ),
                  ),
                ),
                if (isManagementMenuExpanded)
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.05),
                    child: Column(
                      children: [
                        Animasi(
                          icon: MdiIcons.bookmarkBox,
                          text: 'Barang',
                          selected: _selected[4],
                          onTap: () {
                            _onItemTapped(4);
                          },
                        ),
                        Animasi(
                          icon: AbilIcon.kategori,
                          text: 'Kategori',
                          selected: _selected[5],
                          onTap: () {
                            _onItemTapped(5);
                          },
                        ),
                        Animasi(
                          icon: MdiIcons.basketCheckOutline,
                          text: 'Stok',
                          selected: _selected[6],
                          onTap: () {
                            _onItemTapped(6);
                          },
                        ),
                      ],
                    ),
                  ),
                Animasi(
                  icon: AbilIcon.add_to_queue,
                  text: "Tambah Produk",
                  selected: _selected[2],
                  onTap: () => _onItemTapped(2),
                ),
                Animasi(
                  icon: Icons.settings,
                  text: "Pengaturan",
                  selected: _selected[3],
                  onTap: () => _onItemTapped(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
