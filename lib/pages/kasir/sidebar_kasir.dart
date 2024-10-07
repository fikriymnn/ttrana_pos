import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/kasir/animasi_kasir/animasi_m_kasir.dart';
import 'package:ttrana_pos/pages/kasir/animasi_kasir/animasi_t_kasir.dart';
import 'package:ttrana_pos/responsive.dart';
import 'package:ttrana_pos/widget/abil_icon_icons.dart';

class SidebarKasir extends StatefulWidget {
  final String? username;
  final Function(int) onItemSelected;

  const SidebarKasir({
    super.key,
    required this.username,
    required this.onItemSelected,
  });

  @override
  State<SidebarKasir> createState() => _SidebarKasirState();
}

class _SidebarKasirState extends State<SidebarKasir> {
  List<bool> _selected = [true, false, false];
  bool hideBar = true;

  void _onItemTapped(int index) {
    setState(() {
      _selected = [
        false,
        false,
        false,
      ];
      _selected[index] = true;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Responsive(
      mobile: Row(
        children: [
          Container(
            height: size.height,
            width: size.width * 0.037,
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
            child: IconButton(
              icon: Icon(
                hideBar ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: size.width * 0.02,
              ),
              onPressed: () {
                setState(() {
                  hideBar = !hideBar;
                });
              },
              color: Colors.white,
            ),
          ),
          // untuk hidebar
          Visibility(
            visible: hideBar,
            child: Container(
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
                          image: DecorationImage(
                            image: AssetImage('assets/images/Trana.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: size.width * 0.026,
                    ),
                    title: Text(
                      widget.username ?? 'Guest',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.017,
                      ),
                    ),
                    subtitle: Text(
                      "Kasir",
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontSize: size.width * 0.017,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.005),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: size.width * 0.03),
                      children: [
                        AnimasiMKasir(
                          icon: AbilIcon.produk,
                          text: "Produk",
                          selected: _selected[0],
                          onTap: () => _onItemTapped(0),
                        ),
                        AnimasiMKasir(
                          icon: Icons.print,
                          text: "Print & Struk",
                          selected: _selected[1],
                          onTap: () => _onItemTapped(1),
                        ),
                        AnimasiMKasir(
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
          ),
        ],
      ),
      tablet: Row(
        children: [
          Container(
            height: size.height,
            width: size.width * 0.03,
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
            child: IconButton(
              icon: Icon(
                  hideBar ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  hideBar = !hideBar;
                });
              },
              color: Colors.white,
            ),
          ),
          // Menggunakan Visibility untuk hide/show sidebar
          Visibility(
            visible: hideBar,
            child: Container(
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
                          image: DecorationImage(
                            image: AssetImage('assets/images/Trana.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const CircleAvatar(),
                    title: Text(
                      widget.username ?? 'Guest',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Kasir",
                      style: GoogleFonts.josefinSans(color: Colors.white),
                    ),
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
                          text: "Print & Struk",
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
          ),
        ],
      ),
    );
  }
}
