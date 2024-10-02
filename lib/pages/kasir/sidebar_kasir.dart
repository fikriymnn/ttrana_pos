import 'package:flutter/material.dart';
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
  bool _hideBar = true;

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
                  _hideBar ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  _hideBar = !_hideBar;
                });
              },
              color: Colors.white,
            ),
          ),
          // Menggunakan Visibility untuk hide/show sidebar
          Visibility(
            visible: _hideBar,
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
                    title: Text(widget.username ?? 'Guest'),
                    subtitle: const Text("Kasir"),
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
                  _hideBar ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  _hideBar = !_hideBar;
                });
              },
              color: Colors.white,
            ),
          ),
          // Menggunakan Visibility untuk hide/show sidebar
          Visibility(
            visible: _hideBar,
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
                    title: Text(widget.username ?? 'Guest'),
                    subtitle: const Text("Kasir"),
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
