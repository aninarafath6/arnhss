import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.desktop,
    this.tablet,
  }) : super(key: key);

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < AppSizes.kMobil) {
          return mobile;
        } else if (constraints.maxWidth < AppSizes.kTablet) {
          return tablet ?? mobile;
        } else {
          return desktop ?? tablet ?? mobile;
        }
      },
    );
  }
}
