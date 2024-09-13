import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/login.dart';
import 'package:ttrana_pos/pages/register.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool isChanged = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('assets/images/elementhijau.png'),
            ],
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/elementkuning.png'),
                  ],
                )
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.8,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    left: isChanged ? size.width * 0.45 : 0,
                    right: isChanged ? 0 : size.width * 0.45,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.6,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(10, 10),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/background.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Selamat Datang",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.josefinSans(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            isChanged
                                ? "Tap disini jika kamu belum\nmemiliki akun di OrnaTredec"
                                : "Tap disini jika kamu susdah\nmemiliki akun di OrnaTredec",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.015,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.036,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChanged = !isChanged;
                                });
                              },
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(size.width * 0.1),
                                    border: Border.all(
                                        width: size.width * 0.001,
                                        color: Colors.white)),
                                child: Center(
                                  child: Text(
                                    isChanged ? 'Buat' : 'Masuk',
                                    style: GoogleFonts.josefinSans(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    left: isChanged ? 0 : size.width * 0.35,
                    right: isChanged ? size.width * 0.35 : 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: size.width * 0.4,
                      height: size.height * 0.6,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(isChanged ? 0 : 10, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          if (isChanged) ...[
                            const Login(),
                          ] else ...[
                            const Register(),
                          ],
                        ],
                      ),
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
