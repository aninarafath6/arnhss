import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableService extends HandleException {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;

  Future<List<Schedule>>? getTimeTableOfDay(DocumentReference batchRef) async {
    QuerySnapshot _querySnapshot = await _firestoreInstance
        .doc(batchRef.path)
        .collection(FirebaseConstants.timeTableCollection)
        .get();

    var raw = _querySnapshot.docs;

    var data = await Future.wait(
      raw.map(
        (e) async {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          List<dynamic> schedule = data["schedule"];

          // DocumentReference teacherRef = data["teacher"] as DocumentReference;
          // DocumentReference subjectRef = data["subject"] as DocumentReference;
          var nMap = await Future.wait(
            schedule.map(
              (e) async {
                var teacher =
                    await AdmissionService().getATeacher(e["teacher"]);
                var subject =
                    await AdmissionService().getASubject(e["subject"]);

                return {
                  ...e,
                  "teacher": teacher,
                  "subject": subject,
                };
              },
            ).toList(),
          );

          // print(nMap);

          Map<String, dynamic> newMap = {
            "id": e.id,
            "reference": e.reference,
            "day": data["day"],
            "schedule": nMap,
          };

          return Schedule.fromMap(
            {
              ...newMap,
            },
          );
        },
      ).toList(),
    );

    return data;
  }

  Future<void> updateSchedule(
    Schedule schedule, {
    required DocumentReference reference,
  }) async {
    try {
      await _firestoreInstance.doc(reference.path).update(schedule.toMap());
    } catch (e) {
      handleException(InvalidException("Period Schedule failed", false));
    }
  }

  Future<DocumentReference?> createSchedule(
    Schedule schedule, {
    required DocumentReference reference,
  }) async {
    try {
      DocumentReference _reference = await _firestoreInstance
          .collection(
              "${reference.path}/${FirebaseConstants.timeTableCollection}")
          .add(schedule.toMap());

      return _reference;
    } catch (e) {
      handleException(InvalidException("Period Schedule failed", false));
      return null;
    }
  }
}
