import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCommonService {
  Future<String?> getStudentDP(
      DocumentReference? batchReference, String studentId) async {
    final storage = FirebaseStorage.instance;

    try {
      Reference ref = storage.ref(
          'students/${batchReference?.parent.parent?.id}/${batchReference?.id}/dp/$studentId.jpg');

      String dpURL = await ref.getDownloadURL().catchError((error) {
        return "";
      });
      return dpURL == "" ? null : dpURL;
    } catch (e) {}
  }

  Future<String?> getTeacherDP(String teacherID) async {
    try {
      final storage = FirebaseStorage.instance;

      Reference ref = storage.ref('teachers/DP/$teacherID.jpg');

      String dpURL = await ref.getDownloadURL().catchError((error) {
        return "";
      });

      return dpURL == "" ? null : dpURL;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getAdminDP(String adminID) async {
    try {
      final storage = FirebaseStorage.instance;

      Reference ref = storage.ref('admin/DP/$adminID.jpg');

      String dpURL = await ref.getDownloadURL().catchError((error) {
        return "";
      });

      return dpURL == "" ? null : dpURL;
    } catch (e) {
      log(e.toString());
    }
  }
}
