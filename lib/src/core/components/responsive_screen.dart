import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget laptop;
  final Widget desktop;

  const ResponsiveScreen({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.laptop,
    required this.desktop,
  }) : super(key: key);

  static double mobileMaxWidth = 480;
  static double tabletMaxWidth = 768;
  static double laptopMaxWidth = 1023;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletMaxWidth &&
      MediaQuery.of(context).size.width >= mobileMaxWidth;

  static bool isLaptop(BuildContext context) =>
      MediaQuery.of(context).size.width < laptopMaxWidth &&
      MediaQuery.of(context).size.width >= tabletMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= laptopMaxWidth;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= laptopMaxWidth) {
      return desktop;
    } else if (size.width >= tabletMaxWidth && size.width < laptopMaxWidth) {
      return laptop;
    } else if (size.width >= mobileMaxWidth && size.width < tabletMaxWidth) {
      return tablet;
    } else {
      return mobile;
    }
  }
}