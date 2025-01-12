import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/admin/main_page.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/permintaan.dart';
import 'package:ttrana_pos/pages/model_login/model_login.dart';
import 'package:ttrana_pos/widget/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio _dio = Dio();
  bool _isLoading = false;
  bool _change = true;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan Password wajib diisi')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _dio.post(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/login',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final role = response.data['user']['role'];
        final token = response.data['token'];
        final kasirName = response.data['user']['username'];

        // Simpan data ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('username', kasirName);

        // Navigasi berdasarkan role
        if (role == 'kasir') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPageKasir()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login sebagai Kasir berhasil')),
          );
        } else if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login sebagai Admin berhasil')),
          );
        } else {
          throw Exception('Role tidak dikenali');
        }
      } else {
        throw Exception('Login gagal, periksa kredensial Anda');
      }
    } on DioError catch (e) {
      print('Error Code: ${e.response?.statusCode}');
      print('Error Data: ${e.response?.data}');
      print('Headers: ${e.response?.headers}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Login gagal: ${e.response?.data['message'] ?? 'Kesalahan tidak diketahui'}'),
        ),
      );
    } catch (e) {
      print('Unexpected Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token: $token')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token tidak ditemukan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/images/elementhijau.png',
                  width: size.width * 0.22),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.68),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/elementkuning.png',
                        width: size.width * 0.2),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.15, left: size.width * 0.15),
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
                      Column(
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
                                    _change ? Ionicons.eye_off : Ionicons.eye,
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
                      SizedBox(height: size.height * 0.065),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF167960),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04),
                              ),
                              onPressed: _isLoading ? null : _login,
                              child: Text(
                                'LOGIN',
                                style: GoogleFonts.josefinSans(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        tablet: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/images/elementhijau.png'),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.63),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/elementkuning.png'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.15, left: size.width * 0.15),
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
                      Column(
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
                                    _change ? Ionicons.eye_off : Ionicons.eye,
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
                      SizedBox(height: size.height * 0.065),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF167960),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04),
                              ),
                              onPressed: _isLoading ? null : _login,
                              child: Text(
                                'LOGIN',
                                style: GoogleFonts.josefinSans(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
