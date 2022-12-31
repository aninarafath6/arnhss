import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableService extends HandleException {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;

  Future<List<Schedule>>? getTimeTableOfDay(
      DocumentReference batchRef, String day) async {
    print(batchRef.path);
    print(day);

    QuerySnapshot _querySnapshot = await _firestoreInstance
        .doc(batchRef.path)
        .collection(FirebaseConstants.timeTableCollection)
        .where("day", isEqualTo: day.toUpperCase())
        .get();

    var raw = _querySnapshot.docs;

    if (raw.isNotEmpty) {
      Map<String, dynamic> data = raw[0].data() as Map<String, dynamic>;
      List<dynamic> schedule = data["schedule"];

      // DocumentReference teacherRef = data["teacher"] as DocumentReference;
      // DocumentReference subjectRef = data["subject"] as DocumentReference;
      var nMap = await Future.wait(schedule.map((e) async {
        var teacher = await AdmissionService().getATeacher(e["teacher"]);
        var subject = await AdmissionService().getASubject(e["subject"]);

        return {
          ...e,
          "teacher": teacher,
          "subject": subject,
        };
      }).toList());

      // print(nMap);

      Map<String, dynamic> newMap = {"day": data["day"], "schedule": nMap};

      var modelData = Schedule.fromMap(
        {
          ...newMap,
        },
      );
      print(modelData.schedule[0].subject.name);
    }

    return [];
  }
}
