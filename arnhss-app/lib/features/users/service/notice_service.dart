import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class NoticeService with HandleException {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;
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

  Future<void> setNotice(NoticeModel newNotice) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notice");
    CollectionReference _collectionRef =
        _firestoreInstance.collection(FirebaseConstants.noticeCollection);
    try {
      await Future.delayed(const Duration(milliseconds: 800))
          .then((value) async {
        ref.update(newNotice.toJson());
        _collectionRef.add({
          ...newNotice.toJson(),
          "created_at": Timestamp.fromDate(newNotice.createdAt!)
        });
      });
    } catch (e) {
      print(e);
      handleException(e);
    }
  }
}
