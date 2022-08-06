import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  // taking the screen width and height
  double getHeight(height) => (MediaQuery.of(this).size.height / 100) * height;
  double getWidth(width) => (MediaQuery.of(this).size.width / 100) * width;

// spacing widget
  SizedBox spacing({double? height = 0, double? width = 0}) => SizedBox(
        height: getHeight(height),
        width: getWidth(width),
      );
}
