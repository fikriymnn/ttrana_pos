import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/admin/main_page.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/permintaan.dart';
import 'package:ttrana_pos/pages/model_login/model_login.dart';
import 'package:ttrana_pos/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio _dio = Dio();
  bool isLoading = false;
  bool _change = true; // Flag untuk menyembunyikan password

  // Fungsi untuk melakukan login
  Future<void> _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password harus diisi')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await _dio.post(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      // Log untuk memverifikasi respons
      print("Response data: ${response.data}");

      // Pastikan message dari server mengindikasikan login berhasil
      if (response.statusCode == 200 &&
          response.data['message'] == 'Login successful') {
        final user = response.data['user'];
        final token =
            response.data['token']; // Cek apakah token ada dalam respons

        if (token != null && token is String) {
          // Simpan data user dan token ke SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', user['username']);
          await prefs.setString('role', user['role']);
          await prefs.setString('token', token); // Simpan token

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login berhasil')),
          );

          // Navigasi ke halaman MainPageKasir setelah login berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPageKasir()),
          );
        } else {
          // Jika token tidak ditemukan atau tidak valid
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Token tidak ditemukan!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login gagal: Username atau password salah')),
        );
      }
    } catch (e) {
      print("Error during login: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Coba lagi nanti')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: Stack(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/elementhijau.png',
                  width: size.width * 0.24,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/elementkuning.png',
                      width: size.width * 0.2,
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(size.width * 0.01, size.width * 0.01),
                        blurRadius: size.width * 0.01,
                        spreadRadius: size.width * 0.001,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.08,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/Trana.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Login",
                        style: GoogleFonts.josefinSans(
                          color: const Color(0xFF3F9272),
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.3,
                              child: TextField(
                                controller: usernameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: size.width * 0.017,
                                    bottom: size.width * 0.01,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_2,
                                    color: const Color(0xFF3F9272),
                                    size: size.width * 0.025,
                                  ),
                                  hintText: "username",
                                  hintStyle: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272),
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.018,
                                  ),
                                  fillColor: const Color(0xFFE3FFF3),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.009,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.06),
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.3,
                              child: TextField(
                                controller: passwordController,
                                obscureText: _change,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: size.width * 0.017,
                                    bottom: size.width * 0.01,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: const Color(0xFF3F9272),
                                    size: size.width * 0.025,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _change = !_change;
                                      });
                                    },
                                    icon: Icon(
                                      _change ? Ionicons.eye : Ionicons.eye_off,
                                      color: const Color(0xFF3F9272),
                                      size: size.width * 0.025,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272),
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.018,
                                  ),
                                  fillColor: const Color(0xFFE3FFF3),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.009,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.065),
                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          width: size.width * 0.14,
                          height: size.height * 0.069,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(size.width * 0.06),
                              right: Radius.circular(size.width * 0.06),
                            ),
                            color: const Color(0xFF3F9272),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: GoogleFonts.josefinSans(
                                fontSize: size.width * 0.016,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        tablet: Stack(
          children: [
            Row(
              children: [
                Image.asset('assets/images/elementhijau.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/elementkuning.png'),
                  ],
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(size.width * 0.01, size.width * 0.01),
                        blurRadius: size.width * 0.01,
                        spreadRadius: size.width * 0.001,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.08,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/Trana.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Login",
                        style: GoogleFonts.josefinSans(
                          color: const Color(0xFF3F9272),
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.3,
                              child: TextField(
                                controller: usernameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: size.width * 0.017,
                                    bottom: size.width * 0.01,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_2,
                                    color: const Color(0xFF3F9272),
                                    size: size.width * 0.025,
                                  ),
                                  hintText: "username",
                                  hintStyle: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272),
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.018,
                                  ),
                                  fillColor: const Color(0xFFE3FFF3),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.009,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.06),
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.3,
                              child: TextField(
                                controller: passwordController,
                                obscureText: _change,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: size.width * 0.017,
                                    bottom: size.width * 0.01,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: const Color(0xFF3F9272),
                                    size: size.width * 0.025,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _change = !_change;
                                      });
                                    },
                                    icon: Icon(
                                      _change ? Ionicons.eye : Ionicons.eye_off,
                                      color: const Color(0xFF3F9272),
                                      size: size.width * 0.025,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272),
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.018,
                                  ),
                                  fillColor: const Color(0xFFE3FFF3),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.009,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.065),
                      isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _login,
                              child: Text('Login'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
