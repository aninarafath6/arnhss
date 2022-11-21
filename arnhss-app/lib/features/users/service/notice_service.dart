import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/helpers/dailog_helper.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:firebase_database/firebase_database.dart';

class NoticeService with HandleException {
  Stream<NoticeModel>? get notice {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('notice');
      return ref.onValue.map(
        (event) => NoticeModel.fromRawJson(
          jsonEncode(event.snapshot.value),
        ),
      );
    } catch (e) {
      handleException(e);
    }
    return null;
  }

  Future<void> deleteNotice() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notice");
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      await ref.remove();
      DialogHelper.showErrorDialog(
        description: "The notice has been successfully deleted.",
        top: false,
        title: "Success ✅",
      );
    } catch (e) {
      log(e.toString(), name: "delete notice");
      handleException(e);
    }
  }

  void setNotice(NoticeModel newNotice) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notice");
    try {
      await ref.update(newNotice.toJson());
    } catch (e) {
      handleException(e);
    }
  }
}
