import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/pages/login_register.dart';
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
  bool _changed = true;

  final Dio _dio =
      Dio(); //menggunakan plugin Dio untuk menghubungkan server ke flutter

  void _register() async {
    //fungsi
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final nohp = notelpController.hashCode;

    try {
      final response = await _dio.post(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/register', //menggunakan URL untuk menghubungkan API
        data: {
          // menginisialisasi value value yang ada di database
          'username': username,
          'email': email,
          'password': password,
          'no_hp': nohp,
          'role': _terpilih,
        },
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Pendaftaran berhasil')), //notif untuk registrasi berhasil
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoginRegister(), //jika berhasil maka akan langsung pindah page ke page Login
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Pendaftaran login gagal')), //notif untuk registrasi gagal
      );
    }
  }

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
                          //menggunakan textfield untuk pengisian format
                          textEditingController: usernameController,
                          hintText: "Username",
                          typeKeyword: TextInputType.name,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
                              color: const Color(0xFF3F9272),
                              size: size.width * 0.027,
                            ),
                          ),
                          isPass: false,
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          //menggunakan textfield untuk pengisian format
                          textEditingController: emailController,
                          hintText: "Email",
                          typeKeyword: TextInputType.emailAddress,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.email,
                              color: const Color(0xFF3F9272),
                              size: size.width * 0.027,
                            ),
                          ),

                          isPass: false,
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          //menggunakan textfield untuk pengisian format
                          textEditingController: passwordController,
                          hintText: "Password",
                          typeKeyword: TextInputType.visiblePassword,
                          prefixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  _changed = !_changed;
                                },
                              );
                            },
                            icon: Icon(
                              _changed ? Icons.lock : Icons.lock_open_rounded,
                              color: const Color(0xFF3F9272),
                              size: size.width * 0.027,
                            ),
                          ),
                          isPass: _changed,
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        CustomTextfield(
                          //menggunakan textfield untuk pengisian format
                          textEditingController: notelpController,
                          hintText: "No Telephone",
                          typeKeyword: TextInputType.number,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.phone,
                              color: const Color(0xFF3F9272),
                              size: size.width * 0.027,
                            ),
                          ),
                          isPass: false,
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
                        //menggunakan wdiget radio untuk memiloih role
                        value: 'kasir',
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
                        value: 'admin',
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
                    text: "Buat",
                    onTap: _register, //memanggil fungsi registrasi
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
