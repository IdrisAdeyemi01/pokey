import 'package:pokey/src/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusbarType { light, dark }

class Statusbar extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Color systemNavigationBarColor;
  final Brightness statusBarIconBrightness;
  final Brightness systemNavigationBarIconBrightness;

  const Statusbar({
    Key? key,
    required this.child,
    this.statusBarColor = AppColors.dark,
    this.statusBarIconBrightness = Brightness.light,
    this.systemNavigationBarColor = AppColors.dark,
    this.systemNavigationBarIconBrightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      child: child,
    );
  }
}
