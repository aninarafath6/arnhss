import 'package:flutter/material.dart';

class ScrollUtil {
  scroll({required ScrollController controller, pos = 7}) {
    final contentSize = controller.position.viewportDimension +
        controller.position.maxScrollExtent;
    controller.position.animateTo(
      contentSize / pos,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
