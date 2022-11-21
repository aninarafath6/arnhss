import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/service/notice_service.dart';

class NoticeViewModel with ChangeNotifier {
  final NoticeService _noticeService = NoticeService();
  late TextEditingController noticeController;
  bool _loading = false;

  void _toggleLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  //* getters
  bool get loading => _loading;

  //* delete notice from firestore
  Future<void> deleteNotice() async {
    _toggleLoading();
    await _noticeService.deleteNotice();
    _toggleLoading();
  }

  Future<void> addNotice(NoticeModel notice) async {
    if (noticeController.text != "") {
      // print(noticeController.text);
      _toggleLoading();
      await _noticeService.setNotice(notice);
      _toggleLoading();
    }
  }
}
