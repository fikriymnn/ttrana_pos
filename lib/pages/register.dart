import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/costum_widget/costum_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController notelpController = TextEditingController();

  String _selectedValue = 'Option 1';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.09,
                    height: size.height * 0.055,
                    child: Image.asset(
                      "assets/images/Trana.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Buat Akun",
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
                      textEditingController: usernameController,
                      hintText: "Username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF3F9272),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldInpute(
                      textEditingController: emailController,
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.message,
                        color: Color(0xFF3F9272),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldInpute(
                      textEditingController: passController,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF3F9272),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldInpute(
                      textEditingController: notelpController,
                      hintText: "No Telepon",
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xFF3F9272),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Pilihan Role
                    Row(
                      children: [
                        Column(
                          children: [
                            //Teks
                            Text(
                              "Sebagai",
                              style: GoogleFonts.josefinSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff3F9272),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        //Radio
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Option 1',
                                  groupValue: _selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                ),
                                Text(
                                  "Kasir",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff3F9272),
                                  ),
                                ),
                                Radio<String>(
                                  value: 'Option 2',
                                  groupValue: _selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                ),
                                Text(
                                  "Admin",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff3F9272),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: size.width * 0.13,
                        height: size.height * 0.08,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Buat",
                            style: TextStyle(color: Colors.white),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
