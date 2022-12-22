import 'dart:developer';

import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdmissionService with HandleException {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Course>?> getCourse() async {
    try {
      //* fetching sorted course data by course code
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("course").orderBy("code").get();

      return querySnapshot.docs
          .map((e) => Course.fromMap({...e.data(), "id": e.id}))
          .toList();
    } catch (e) {
      handleException(
          InvalidException("Something wrong with course 🤯", false));
      return null;
    }
  }

  Future<Course?> addCourse(Course newCourse) async {
    try {
      CollectionReference collectionRef = _firestore.collection("course");

      DocumentReference docRef = await collectionRef.add(newCourse.toMap());
      var data = await docRef.get();

      return Course.fromMap(
        {
          ...(data.data() as Map<String, dynamic>),
          "id": docRef.id,
        },
      );
    } catch (e) {
      handleException(
        InvalidException(
          "Courses cannot be added because there is something wrong with them 🤯",
          false,
        ),
      );
      return null;
    }
  }

  Future<void> deleteCourse(Course course) async {
    try {
      CollectionReference collectionReference = _firestore.collection("course");
      collectionReference.doc(course.id).delete().then((value) {
        debugPrint("course deleted successfully");
        return null;
      }).catchError((onError) {
        debugPrint("course is not deleted");
        throw InvalidException("Course deletion failed..😟", false);
      });
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> editCourse(Course course) async {
    try {
      CollectionReference collectionRef = _firestore.collection("course");
      collectionRef
          .doc(course.id)
          .update(course.toMap())
          .then((value) => log("${course.name} updated"))
          .catchError((error) {
        throw InvalidException("Course is not updated..😟", false);
      });
    } catch (e) {
      handleException(e);
    }
  }

  //* batch service

  Future<List<Batch>?> getBatches(Course course) async {
    try {
      //* fetching sorted course data by course code
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("course/${course.id}/batches")
          .orderBy("code")
          .get();

      return Future.wait(
        querySnapshot.docs.map(
          (e) async {
            DocumentReference ref = e.data()["teacher"];
            DocumentSnapshot teacher = await _firestore.doc(ref.path).get();

            return Batch.fromMap(
              {
                ...e.data(),
                "id": e.id,
                "course_id": course.id,
                "teacher": TeacherModel.fromTeacherJSON(
                  {
                    ...teacher.data() as Map<String, dynamic>,
                    "reference": teacher.reference,
                    "id": teacher.id,
                  },
                ),
              },
            );
          },
        ).toList(),
      );
    } catch (e) {
      handleException(
          InvalidException("Something wrong with course 🤯", false));
      return null;
    }
  }

  Future<Batch?> addBatch(Batch newBatch, {required String courseId}) async {
    try {
      var collectionRef = _firestore.collection("course/$courseId/batches");

      var docRef = await collectionRef.add(newBatch.toMap());
      var data = await docRef.get();

      return Batch.fromMap(
        {
          ...(data.data() as Map<String, dynamic>),
          "id": docRef.id,
          "course_id": courseId,
          "teacher": newBatch.teacher,
          "leader": newBatch.leader,
        },
      );
    } catch (e) {
      print(e);
      handleException(
        InvalidException(
          "Batch cannot be added because there is something wrong with them 🤯",
          false,
        ),
      );
    }
    return null;
  }

  Future<void> deleteBatch(Batch batch, {required String courseId}) async {
    try {
      CollectionReference collectionReference =
          _firestore.collection("course/$courseId/batches");
      collectionReference.doc(batch.id).delete().then((value) {
        debugPrint("batch deleted successfully");
        return null;
      }).catchError((onError) {
        debugPrint("batch is not deleted");
        throw InvalidException("batch deletion failed..😟", false);
      });
    } catch (e) {
      handleException(e);
    }
  }

  Future<Map<String, String?>> getCourseInnerData(Course course) async {
    String batchRef = "course/${course.id}/batches";

    try {
      //* fetching batch collection
      var batches = await _firestore.collection(batchRef).get();
      int count = 0;

      await Future.wait(batches.docs.map(
        (batch) async {
          //* fetching division collection
          var divisions = await _firestore
              .collection(batchRef)
              .doc(batch.id)
              .collection("divisions")
              .get();

          await Future.wait(
            divisions.docs.map(
              (division) async {
                var students = await _firestore
                    .collection(
                        "$batchRef/${batch.id}/divisions/${division.id}/students")
                    .get();

                count += students.docs.length;
              },
            ),
          );
        },
      ).toList());

      return {
        "batches": batches.docs.length.toString(),
        "students": count.toString(),
      };
    } catch (e) {
      handleException(e);
      return {
        "batches": null,
      };
    }
  }

  Future<void> editBatch(Batch updatedBatch) async {
    try {
      CollectionReference collectionRef =
          _firestore.collection("course/${updatedBatch.courseId}/batches");
      collectionRef
          .doc(updatedBatch.id)
          .update(updatedBatch.toMap())
          .then((value) => log("${updatedBatch.name} updated"))
          .catchError((error) {
        throw InvalidException("batch is not updated..😟", false);
      });
    } catch (e) {
      handleException(e);
    }
  }

  ///* batch service
  Future<List<TeacherModel>?> getTeachersUnderCourse(String courseId) async {
    try {
      //* fetching sorted course data by course code
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("course/$courseId/teachers")
          .orderBy("name")
          .get();

      return querySnapshot.docs
          .map(
            (e) => TeacherModel.fromTeacherJSON(
              {
                ...e.data(),
                "id": e.id,
                "reference": e.reference,
              },
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      handleException(
          InvalidException("Something wrong with course 🤯", false));
      // Future.error("error");
    }
    return null;
  }
}
