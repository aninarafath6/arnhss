import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCommonService {
  Future<String?> getStudentDP(
      String courseName, String batchName, String studentId) async {
    final storage = FirebaseStorage.instance;

    Reference ref = storage.ref('$courseName/$batchName/DP/$studentId.jpg');

    String dpURL = await ref.getDownloadURL().catchError((error) {
      return "";
    });

    return dpURL == "" ? null : dpURL;
  }
}
