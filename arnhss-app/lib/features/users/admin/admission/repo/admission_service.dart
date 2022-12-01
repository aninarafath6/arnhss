import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdmissionService with HandleException {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Course>?> getCourse() async {
    try {
      //*
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("course").get();

      return querySnapshot.docs
          .map(
            (e) => Course.fromMap({...e.data(), "id": e.id}),
          )
          .toList();
    } catch (e) {
      handleException(
          InvalidException("Something wrong with course 🤯", false));
      return null;
    }
  }
}
