import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttrana_pos/pages/login_register.dart';
import 'package:ttrana_pos/pages/sidebar/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi POS',
      home: MainPage(),
    );
  }
}
