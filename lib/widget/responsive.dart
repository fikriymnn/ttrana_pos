import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.height < 500;

  static bool isTablet(BuildContext context) =>
      // MediaQuery.of(context).size.height < 1000 &&
      MediaQuery.of(context).size.height >= 500;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight >= 500) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
