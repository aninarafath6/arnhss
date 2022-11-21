import 'package:arnhss/features/users/service/notice_service.dart';
import 'package:flutter/material.dart';

class NoticeViewModel with ChangeNotifier {
  final NoticeService _noticeService = NoticeService();
  bool _deleteLoading = false;

  void _toggleLoading() {
    _deleteLoading = !_deleteLoading;
    notifyListeners();
  }

  //* getters
  bool get dltLoading => _deleteLoading;

  //* delete notice from firestore
  Future<void> deleteNotice() async {
    _toggleLoading();
    await _noticeService.deleteNotice();
    _toggleLoading();
  }
}
