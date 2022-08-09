import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController _mobileNumberController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final dataKey = new GlobalKey();

  TextEditingController get mobileNumberController => _mobileNumberController;
  ScrollController get scrollController => _scrollController;

  scrollToBottom() {
    final contentSize = _scrollController.position.viewportDimension +
        _scrollController.position.maxScrollExtent;

// Scroll to that position.
    _scrollController.position.animateTo(
      contentSize / 6,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
