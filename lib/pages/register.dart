import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/widget/custom_button.dart';
import 'package:ttrana_pos/widget/custom_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  String _terpilih = 'opsi 1';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: size.height * 0.07,
                width: size.width * 0.07,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Trana.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Buat Akun",
                    style: GoogleFonts.josefinSans(
                      color: const Color(0xFF3F9272),
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextfield(
                          textEditingController: usernameController,
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: const Color(0xFF3F9272),
                            size: size.width * 0.027,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          textEditingController: emailController,
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.person,
                            color: const Color(0xFF3F9272),
                            size: size.width * 0.027,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          textEditingController: passwordController,
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            size: size.width * 0.027,
                            color: const Color(0xFF3F9272),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          textEditingController: notelpController,
                          hintText: "No Telepon",
                          prefixIcon: Icon(
                            Icons.phone,
                            size: size.width * 0.027,
                            color: const Color(0xFF3F9272),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sebagai",
                        style: GoogleFonts.josefinSans(
                          fontSize: size.width * 0.016,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff3F9272),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Radio(
                        value: 'opsi 1',
                        groupValue: _terpilih,
                        onChanged: (String? value) {
                          setState(() {
                            _terpilih = value!;
                          });
                        },
                      ),
                      Text(
                        "Kasir",
                        style: GoogleFonts.josefinSans(
                          fontSize: size.width * 0.015,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff3F9272),
                        ),
                      ),
                      Radio(
                        value: 'opsi 2',
                        groupValue: _terpilih,
                        onChanged: (String? value) {
                          setState(() {
                            _terpilih = value!;
                          });
                        },
                      ),
                      Text(
                        "Admin",
                        style: GoogleFonts.josefinSans(
                          fontSize: size.width * 0.015,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff3F9272),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  CustomButton(
                    teks: "Buat",
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
