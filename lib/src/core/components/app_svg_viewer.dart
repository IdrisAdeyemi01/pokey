import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgViewer extends StatelessWidget {
  const AppSvgViewer({
    super.key,
    required this.assetName,
    this.height = 24,
    this.width = 24,
  });
  
  final String assetName;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
    );
  }
}
