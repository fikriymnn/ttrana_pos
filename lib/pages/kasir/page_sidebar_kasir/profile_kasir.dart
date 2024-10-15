import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttrana_pos/widget/custom_button.dart';

class ProfileKasir extends StatelessWidget {
  const ProfileKasir({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.02),
        child: Column(
          children: [
            //Avatar Profile
            Container(
              width: size.width,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xffF3FFFB),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.05),
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
              ),
            ),
            //Information
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xffE2FFF5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Nama Pengguna
                        Row(
                          children: [
                            Text(
                              "Nama Pengguna",
                              style: GoogleFonts.josefinSans(
                                color: Color(0xffA9A7A7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005,
                                horizontal: size.width * 0.005),
                            child: Text(
                              "AA",
                              style: GoogleFonts.josefinSans(
                                fontSize: 23,
                                color: Color(0xff3F9272),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        //Notelpon
                        Row(
                          children: [
                            Text(
                              "Nomor Telepon",
                              style: GoogleFonts.josefinSans(
                                color: Color(0xffA9A7A7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005,
                                horizontal: size.width * 0.005),
                            child: Text(
                              "0812971836173",
                              style: GoogleFonts.josefinSans(
                                fontSize: 23,
                                color: Color(0xff3F9272),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        //Email
                        Row(
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.josefinSans(
                                color: Color(0xffA9A7A7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005,
                                horizontal: size.width * 0.005),
                            child: Text(
                              "AA",
                              style: GoogleFonts.josefinSans(
                                fontSize: 23,
                                color: Color(0xff3F9272),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        //Alamat Pengguna
                        Row(
                          children: [
                            Text(
                              "Alamat Pengguna",
                              style: GoogleFonts.josefinSans(
                                color: Color(0xffA9A7A7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005,
                                horizontal: size.width * 0.005),
                            child: Text(
                              "vakjvcfaskdjsskajdjasbclsablkvcbsajhdsaghdvgufgkjdsfjdsfdsgfkjdsgfdshvcdsvhfsevfhsgdfhgdhsghgshfgdshgfhdsghfgshfghsghfsghfsghfgshdghfdgshgfhdsfh",
                              style: GoogleFonts.josefinSans(
                                fontSize: 23,
                                color: Color(0xff3F9272),
                              ),
                            ),
                          ),
                        ),
                        //Divider
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.03),
                          child: Divider(
                            color: Color(0xffABAEAD),
                            thickness: 1,
                          ),
                        ),
                        //Button Logout
                        CustomButton(text: 'Logout'),
                      ],
                    ),
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
