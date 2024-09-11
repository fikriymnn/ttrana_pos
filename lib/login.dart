import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/costum_widget/costum_button.dart';
import 'package:ttrana_pos/costum_widget/costum_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3FFF3),
      body: Stack(
        children: [
          // Gambar Polygon di atas, akan ditempatkan di bagian atas kiri
          Container(
            width: 400,
            child: Image.asset(
              "assets/images/Polygon 1.png",
              fit: BoxFit.cover,
            ),
          ),

          // Gambar Elipse, ditempatkan di bawah kanan
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 380,
              child: Image.asset(
                "assets/images/Ellipse 22.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 893,
              height: 538,
              color: Colors.white,
              child: Row(
                children: [
                  //menggunakan widget agar logo Trana di kiri atas Container
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 45,
                        child: Image.asset(
                          "assets/images/Trana.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  //bagian kiri dibungkus Container (textfield)
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
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
                              width: 170,
                              height: 47,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Masuk",
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.white),
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
                  //sampai sini

                  SizedBox(
                    width: 70,
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/background_gradasi.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Selamat Datang Teks
                          Text(
                            "Selamat Datang",
                            style: GoogleFonts.josefinSans(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 25),

                          Text(
                            "Tap disini jika kamu belum\n memiliki akun di T-trana",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 25),

                          //Button login
                          MyOutlineButton(
                            teks: "Buat",
                            onTap: () {},
                          ),
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
