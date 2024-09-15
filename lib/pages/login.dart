import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/widget/custom_button.dart';
import 'package:ttrana_pos/widget/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
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
              padding: EdgeInsets.only(top: size.height * 0.18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Masuk",
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
                          textEditingController: emailController,
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: const Color(0xFF3F9272),
                            size: size.width * 0.027,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.02,
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
                          height: size.width * 0.02,
                        ),
                        CustomButton(
                          text: "Masuk",
                          onTap: () {},
                        ),
                      ],
                    ),
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
