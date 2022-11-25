import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/extensions/enum_extension.dart';

import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/service/notice_service.dart';
import 'package:arnhss/services/notification/notification_service.dart';

class NoticeViewModel extends ChangeNotifier {
  final NoticeService _noticeService = NoticeService();
  late TextEditingController noticeController;
  final NotificationService _notificationService = NotificationService();
  Role? _target;

  bool loading = false;
  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  //* getters
  Role? get target => _target;

  //* setters
  set setTarget(Role? trg) {
    _target = trg;
    notifyListeners();
  }

  // bool get loading => _loading;

  //* delete notice from firestore
  Future<bool> deleteNotice(success) async {
    toggleLoading();
    await Future.delayed(const Duration(milliseconds: 300));
    await _noticeService.deleteNotice();
    success();
    toggleLoading();
    return true;
  }

  Future<void> addNotice(NoticeModel notice,
      {required Function() success, required fail}) async {
    if (noticeController.text != "") {
      print(target?.describe);
      toggleLoading();
      await Future.delayed(const Duration(milliseconds: 300));
      await _noticeService.setNotice(notice);
      await _notificationService.sendTopicPushNotification(
        target?.describe ?? FirebaseConstants.authenticatedUSERS,
        "A notice from ARNHSS...❗️",
        notice.notice ?? "",
      );
      noticeController.clear();
      toggleLoading();
      success();
    } else {
      fail();
    }
  }
}
