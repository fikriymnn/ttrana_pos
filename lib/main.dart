import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/admin/main_page.dart';
import 'package:ttrana_pos/pages/kasir/main_page_kasir.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/pages/login.dart';
import 'package:ttrana_pos/pages/kasir/models/payment_model.dart'; // Impor PaymentModel

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(
              create: (context) => PaymentModel()), // Add PaymentModel
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi POS',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role =
        prefs.getString('role'); // Get role saved in SharedPreferences

    if (role != null) {
      // Navigate based on the role
      if (role == 'kasir') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPageKasir(), // Kasir's home page
          ),
        );
      } else if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(), // Admin's home page
          ),
        );
      }
    } else {
      // If no role is found, navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(), // Login page
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
