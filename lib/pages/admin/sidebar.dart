import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ttrana_pos/pages/admin/animasi/animasi_m.dart';
import 'package:ttrana_pos/responsive.dart';
import 'package:ttrana_pos/widget/abil_icon_icons.dart';
import 'package:ttrana_pos/pages/admin/animasi/animasi_T.dart';

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
    false,
    false,
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
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ];
      _selected[index] = true; // Set item yang dipilih
    });

    widget.onItemSelected(index); // buat update halaman
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
                  AnimasiM(
                    icon: AbilIcon.produk,
                    text: "Produk",
                    selected: _selected[0],
                    onTap: () => _onItemTapped(0),
                  ),
                  AnimasiM(
                    icon: AbilIcon.keuangan,
                    text: "Keuangan",
                    selected: _selected[1],
                    onTap: () => _onItemTapped(1),
                  ),
                  // Custom Management Submenu with AnimasiM
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.032,
                      top: size.width * 0.002,
                      bottom: size.width * 0.01,
                    ),
                    child: SizedBox(
                      height: size.width * 0.046,
                      // color: Colors.black,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            subMenu1 = !subMenu1;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              AbilIcon.menejemen,
                              size: size.width * 0.023,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.016,
                            ),
                            Text(
                              "Management",
                              style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.015,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            Icon(
                              subMenu1
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: size.width * 0.027,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (subMenu1)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                      ),
                      child: Column(
                        children: [
                          AnimasiM(
                            icon: MdiIcons.bookmarkBox,
                            text: 'Barang',
                            selected: _selected[2],
                            onTap: () {
                              _onItemTapped(2);
                            },
                          ),
                          AnimasiM(
                            icon: AbilIcon.kategori,
                            text: 'Kategori',
                            selected: _selected[3],
                            onTap: () {
                              _onItemTapped(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  AnimasiM(
                    icon: AbilIcon.add_to_queue,
                    text: "Tambah Produk",
                    selected: _selected[4],
                    onTap: () => _onItemTapped(4),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.034,
                      top: size.width * 0.002,
                      bottom: size.width * 0.01,
                    ),
                    child: SizedBox(
                      height: size.width * 0.046,
                      // color: Colors.black,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            subMenu2 = !subMenu2;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: size.width * 0.023,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.016,
                            ),
                            Text(
                              "Pengaturan",
                              style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.015,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.023,
                            ),
                            Icon(
                              subMenu2
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: size.width * 0.027,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (subMenu2)
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        children: [
                          AnimasiM(
                            icon: Icons.person_2_outlined,
                            text: 'Profile',
                            selected: _selected[5],
                            onTap: () {
                              _onItemTapped(5);
                            },
                          ),
                          AnimasiM(
                            icon: Icons.document_scanner,
                            text: 'Database',
                            selected: _selected[6],
                            onTap: () {
                              _onItemTapped(6);
                            },
                          ),
                          AnimasiM(
                            icon: Icons.local_print_shop_outlined,
                            text: 'Print & Struck',
                            selected: _selected[7],
                            onTap: () {
                              _onItemTapped(7);
                            },
                          ),
                          AnimasiM(
                            icon: Icons.person,
                            text: 'Tambah Staff',
                            selected: _selected[8],
                            onTap: () {
                              _onItemTapped(8);
                            },
                          ),
                          AnimasiM(
                            icon: Icons.money_sharp,
                            text: 'Metode Bayar',
                            selected: _selected[9],
                            onTap: () {
                              _onItemTapped(9);
                            },
                          ),
                          AnimasiM(
                            icon: Icons.star_outline_sharp,
                            text: 'Rating Aplikasi',
                            selected: _selected[10],
                            onTap: () {
                              _onItemTapped(10);
                            },
                          ),
                        ],
                      ),
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
        ),
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
                  AnimasiT(
                    icon: AbilIcon.produk,
                    text: "Produk",
                    selected: _selected[0],
                    onTap: () => _onItemTapped(0),
                  ),
                  AnimasiT(
                    icon: AbilIcon.keuangan,
                    text: "Keuangan",
                    selected: _selected[1],
                    onTap: () => _onItemTapped(1),
                  ),
                  // Custom Management Submenu with AnimasiT
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.02,
                      top: size.width * 0.005,
                      bottom: size.width * 0.005,
                    ),
                    child: SizedBox(
                      height: size.width * 0.046,
                      // color: Colors.black,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            subMenu1 = !subMenu1;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.012),
                          child: Row(
                            children: [
                              Icon(
                                AbilIcon.menejemen,
                                size: size.width * 0.02,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.014,
                              ),
                              Text(
                                "Management",
                                style: GoogleFonts.josefinSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.015,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.025,
                              ),
                              Icon(
                                subMenu1
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (subMenu1)
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        children: [
                          AnimasiT(
                            icon: MdiIcons.bookmarkBox,
                            text: 'Barang',
                            selected: _selected[2],
                            onTap: () {
                              _onItemTapped(2);
                            },
                          ),
                          AnimasiT(
                            icon: AbilIcon.kategori,
                            text: 'Kategori',
                            selected: _selected[3],
                            onTap: () {
                              _onItemTapped(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  AnimasiT(
                    icon: AbilIcon.add_to_queue,
                    text: "Tambah Produk",
                    selected: _selected[4],
                    onTap: () => _onItemTapped(4),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.02,
                      top: size.width * 0.005,
                      bottom: size.width * 0.005,
                    ),
                    child: SizedBox(
                      height: size.width * 0.046,
                      // color: Colors.black,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            subMenu2 = !subMenu2;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.012),
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: size.width * 0.02,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.016,
                              ),
                              Text(
                                "Pengaturan",
                                style: GoogleFonts.josefinSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.015,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.033,
                              ),
                              Icon(
                                subMenu2
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (subMenu2)
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        children: [
                          AnimasiT(
                            icon: Icons.person_2_outlined,
                            text: 'Profile',
                            selected: _selected[5],
                            onTap: () {
                              _onItemTapped(5);
                            },
                          ),
                          AnimasiT(
                            icon: Icons.document_scanner,
                            text: 'Database',
                            selected: _selected[6],
                            onTap: () {
                              _onItemTapped(6);
                            },
                          ),
                          AnimasiT(
                            icon: Icons.local_print_shop_outlined,
                            text: 'Print & Struck',
                            selected: _selected[7],
                            onTap: () {
                              _onItemTapped(7);
                            },
                          ),
                          AnimasiT(
                            icon: Icons.person,
                            text: 'Tambah Staff',
                            selected: _selected[8],
                            onTap: () {
                              _onItemTapped(8);
                            },
                          ),
                          AnimasiT(
                            icon: Icons.money_sharp,
                            text: 'Metode Bayar',
                            selected: _selected[9],
                            onTap: () {
                              _onItemTapped(9);
                            },
                          ),
                          AnimasiT(
                            icon: Icons.star_outline_sharp,
                            text: 'Rating Aplikasi',
                            selected: _selected[10],
                            onTap: () {
                              _onItemTapped(10);
                            },
                          ),
                        ],
                      ),
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
