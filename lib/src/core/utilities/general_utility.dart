import 'package:flutter/material.dart';

import '../components/responsive_screen.dart';

class GeneralUtility {
  static int getCrossAxisCountByPlatform(BuildContext context) {
    if (ResponsiveScreen.isTablet(context)) {
      return 4;
    } else if (ResponsiveScreen.isMobile(context)) {
      return 3;
    } else if (ResponsiveScreen.isLaptop(context)) {
      return 5;
    } else {
      return 6;
    }
  }
}
