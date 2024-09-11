import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/costum_widget/costum_textfield.dart';

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
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: size.width * 0.09,
            height: size.height * 0.055,
            child: Image.asset(
              "assets/images/Trana.png",
              fit: BoxFit.cover,
            ),
          ),
        ),

        //bagian kiri dibungkus Container (textfield)
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Masuk",
                  style: GoogleFonts.josefinSans(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F9272),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFieldInpute(
                  textEditingController: emailController,
                  hintText: "Username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF3F9272),
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFieldInpute(
                  textEditingController: passwordController,
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF3F9272),
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: size.width * 0.13,
                    height: size.height * 0.08,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Masuk",
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50)),
                      color: Color(0xFF3F9272),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
