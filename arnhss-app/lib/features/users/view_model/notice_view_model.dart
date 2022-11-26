import 'package:arnhss/common/enums.dart';
import 'package:arnhss/extensions/enum_extension.dart';

import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/service/notice_service.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/notification/notification_service.dart';

class NoticeViewModel extends ChangeNotifier with HandleException {
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

  //* validate
  bool validate() {
    //* handling errors
    try {
      // _mobileNumberController.text = _mobileNumberController.text.trim();

      // * if mobile number is empty then throw a invalid exception
      if (noticeController.text.isEmpty) {
        throw InvalidException("Please enter your notice..!! ", false);
      } else {
        if (target == null) {
          throw InvalidException("Please choose notification target 🎯", false);
        } else {
          return true;
        }
      }
    } catch (e) {
      // handleException(e);
      return false;
    }
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
    if (validate()) {
      toggleLoading();
      await Future.delayed(const Duration(milliseconds: 300));
      await _noticeService.setNotice(notice);
      await _notificationService.sendTopicPushNotification(
        _target?.describe ?? "",
        "A notice from ARNHSS...❗️",
        notice.notice ?? "",
      );
      _target = null;
      noticeController.clear();
      toggleLoading();
      success();
    } else {
      fail();
      handleException(
        InvalidException(
          "Please fill notice and notification target 🎯",
          false,
        ),
        top: true,
      );
    }
  }
}
