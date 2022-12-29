import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCommonService {
  Future<String?> getStudentDP(
      DocumentReference? batchReference, String studentId) async {
    final storage = FirebaseStorage.instance;

    print(
        'students/${batchReference?.parent.parent?.id}/${batchReference?.id}/dp/$studentId.jpg');

    Reference ref = storage.ref(
        'students/${batchReference?.parent.parent?.id}/${batchReference?.id}/dp/$studentId.jpg');

    String dpURL = await ref.getDownloadURL().catchError((error) {
      return "";
    });

    return dpURL == "" ? null : dpURL;
  }

  Future<String?> getTeacherDP(String teacherID) async {
    final storage = FirebaseStorage.instance;

    Reference ref = storage.ref('teachers/DP/$teacherID.jpg');

    String dpURL = await ref.getDownloadURL().catchError((error) {
      return "";
    });

    return dpURL == "" ? null : dpURL;
  }

  Future<String?> getAdminDP(String adminID) async {
    final storage = FirebaseStorage.instance;

    Reference ref = storage.ref('admin/DP/$adminID.jpg');

    String dpURL = await ref.getDownloadURL().catchError((error) {
      return "";
    });

    return dpURL == "" ? null : dpURL;
  }
}
