import 'dart:developer';

import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/extensions/dt_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/student/attendance/model/attendance_model.dart';
import 'package:arnhss/features/users/view_model/attendance_view_model.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/firebase_common_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService extends ChangeNotifier {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;

  FirebaseCommonService _firebaseCommonService = FirebaseCommonService();

  Future<void> takeAttendance(
      DocumentReference batchRef, AttendanceModel attendanceModel) async {
    try {
      QuerySnapshot data = await _firestoreInstance
          .doc(batchRef.path)
          .collection(FirebaseConstants.attendanceCollection)
          .get();

      var b = data.docs.where(
        (e) {
          Map<String, dynamic> _data = e.data() as Map<String, dynamic>;
          DateTime _date = (_data["date"] as Timestamp).toDate();
          return _date.dtFrm() == attendanceModel.date.dtFrm();
        },
      ).toList();

      if (b.isEmpty) {
        _firestoreInstance
            .doc(batchRef.path)
            .collection(FirebaseConstants.attendanceCollection)
            .add(attendanceModel.toMap());
      } else {
        print("already exist");
      }
    } catch (e) {
      HandleException().handleException(e);
    }
  }

  Future<List<StudentModel>> alreadyTakenStudentsBN(
      DocumentReference batchRef, DateTime date) async {
    try {
      QuerySnapshot data = await _firestoreInstance
          .doc(batchRef.path)
          .collection(FirebaseConstants.attendanceCollection)
          .where("isBNTaken", isEqualTo: true)
          .get();

      var b = data.docs.where(
        (e) {
          Map<String, dynamic> _data = e.data() as Map<String, dynamic>;
          DateTime _date = (_data["date"] as Timestamp).toDate();
          return _date.dtFrm() == date.dtFrm();
        },
      ).toList();

      if (b.isNotEmpty) {
        print("its not empty");

        Map<String, dynamic> _data = b[0].data() as Map<String, dynamic>;
        List<dynamic> _refs = _data["BN"];

        var a = await Future.wait(
          _refs.map(
            (e) async {
              var studentData = await _firestoreInstance
                  .doc((e as DocumentReference).path)
                  .get();

              var batchDetails = await e.parent.parent?.get();

              //* fetching batch details
              var courseDetails =
                  await batchDetails?.reference.parent.parent?.get();
              String? dpURL = await _firebaseCommonService.getStudentDP(
                batchDetails?.reference,
                e.id,
              );
              return StudentModel.fromJSON(
                {
                  ...studentData.data() as Map<String, dynamic>,
                  "id": e.id,
                  "reference": e,
                  "batch": batchDetails?.data()?["name"],
                  "department": courseDetails?.data()?["name"],
                  "dpURL": dpURL,
                },
              );
            },
          ).toList(),
        );

        // List<List<DocumentReference>> _absentees =  b.map(
        //   (e) {

        //   },
        // ).toList();
        // var a = await Future.wait(
        //   _absentees.map(
        //     (e) async {
        //       _firestoreInstance.doc(e.)
        //       return e;
        //     },
        //   ).toList(),
        // );
        return a;
      } else {
        print("ya its empty");
        return [];
      }
    } catch (e) {
      log(e.toString());
      HandleException().handleException(e);
      return [];
    }
  }
}
