import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
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
  DateTime _selectedDate = DateTime.now();
  final DatePickerController _timelineController = DatePickerController();

  final List<NoticeModel> notices = [];

  Role? _target;

  bool loading = false;
  bool getLoading = false;

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  void getToggleLoading() {
    getLoading = !getLoading;
    notifyListeners();
  }

  //* getters
  Role? get target => _target;
  DateTime get selectedDate => _selectedDate;
  DatePickerController get dateController => _timelineController;

  //* setters
  set setTarget(Role? trg) {
    _target = trg;
    notifyListeners();
  }

  set setSelectedDate(DateTime date) {
    _selectedDate = date;
  }

  // * navigate to today
  void toToday() {
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
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
      getNotices();
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

  Future<void> getNotices() async {
    getToggleLoading();
    List<NoticeModel>? result = await _noticeService.getNotice();
    notices.clear();
    notices.addAll(result ?? []);
    notices.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    getToggleLoading();
  }
}
