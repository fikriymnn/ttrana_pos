import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimasiT extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  final bool selected;
  final GoogleFonts? googleFonts;

  const AnimasiT({
    super.key,
    required this.text,
    required this.onTap,
    required this.selected,
    required this.icon,
    this.googleFonts,
  });

  @override
  State<AnimasiT> createState() => _AnimasiTState();
}

class _AnimasiTState extends State<AnimasiT> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _anim1;
  late Animation<double> _anim2;
  late Animation<double> _anim3;
  late Animation<Color?> _color;

  bool hovered = false; // Status hover

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 275),
    );

    if (widget.selected) {
      _controller1.forward();
      _controller2.forward();
    }

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(AnimasiT oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.selected) {
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Animasi sekarang responsif terhadap ukuran layar
    _anim1 = Tween(begin: size.width * 0.1, end: size.width * 0.05)
        .animate(_controller1);
    _anim2 = Tween(begin: size.width * 0.1, end: size.width * 0.02)
        .animate(_controller2);
    _anim3 = Tween(begin: size.width * 0.1, end: size.width * 0.05)
        .animate(_controller2);

    _color = ColorTween(end: Color(0xFF167960), begin: Colors.white)
        .animate(_controller2);

    return GestureDetector(
      onTap: () {
        widget.onTap(); // Memanggil fungsi onTap dari parent
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true; // Status hover true ketika mouse masuk
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false; // Status hover false ketika mouse keluar
          });
        },
        child: Stack(
          children: [
            if (widget.selected) // Hanya menampilkan CustomPaint jika selected
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.016,
                  ),
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: size.width * 0.214,
                    height: size.height * 0.1,
                    duration: Duration(milliseconds: 10000),
                  ),
                ],
              ),
            Container(
              height: size.height * 0.1,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.033,
                  ),
                  Icon(
                    widget.icon,
                    color: _color.value,
                  ),
                  SizedBox(width: size.width * 0.014),
                  Text(widget.text,
                      style: GoogleFonts.josefinSans(
                        color: _color.value,
                        fontSize: size.width * 0.015,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
