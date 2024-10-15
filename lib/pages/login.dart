import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/admin/main_page.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _change = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio _dio = Dio(); //menggunakan plugin Dio untuk menghubungkan server
  void _login() async {
    //fungsi
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await _dio.post(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/login', //menggunakan URL untuk menghubungkan API
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login berhasil')), //notif jika login berhasil
        );
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
                username:
                    username), //jika berhasil maka akan langsung pindah page
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal')), //notif jika login gagal
      );
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
                      SizedBox(
                        height: size.height * 0.013,
                      ),
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
                            SizedBox(
                              height: size.height * 0.06,
                            ),
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
                      SizedBox(
                        height: size.height * 0.065,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()));
                            },
                            icon: const Icon(
                              Icons.access_time_filled,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainPageKasir()));
                            },
                            icon: const Icon(
                              Icons.abc_outlined,
                            ),
                          ),
                        ],
                      ),
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
                            height: size.height * 0.1,
                            width: size.width * 0.1,
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
                      SizedBox(
                        height: size.height * 0.013,
                      ),
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
                            SizedBox(
                              height: size.height * 0.06,
                            ),
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
                      SizedBox(
                        height: size.height * 0.065,
                      ),
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
      ),
    );
  }
}
