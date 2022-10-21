import 'dart:async';
import 'dart:convert';

import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FireBaseDatabaseService with HandleException {
  //* collection reference
  final CollectionReference noticesCollection =
      FirebaseFirestore.instance.collection('notices');
  // DatabaseReference ref = FirebaseDatabase.instance.ref("notices/");

//* get stream
  Stream<QuerySnapshot?> get notices {
    return noticesCollection.snapshots();
  }

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

  void setNotice(NoticeModel newNotice) async {
    print("here");
    DatabaseReference ref = FirebaseDatabase.instance.ref("notice");
    try {
      // Only update the name, leave the age and address!
      await ref.update(newNotice.toJson());
    } catch (e) {
      print(e);
      handleException(e);
    }
  }
}