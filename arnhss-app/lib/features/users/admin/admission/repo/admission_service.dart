import 'dart:developer';

import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
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

      return querySnapshot.docs
          .map((e) => Batch.fromMap(
                {
                  ...e.data(),
                  "id": e.id,
                },
              ))
          .toList();
    } catch (e) {
      print(e);
      handleException(
          InvalidException("Something wrong with course 🤯", false));
      return null;
    }
  }

  Future<Batch?> addBatch(Batch newBatch, {required String courseId}) async {
    try {
      CollectionReference collectionRef =
          _firestore.collection("course/$courseId/batches");

      DocumentReference docRef = await collectionRef.add(newBatch.toMap());
      var data = await docRef.get();

      return Batch.fromMap(
        {
          ...(data.data() as Map<String, dynamic>),
          "id": docRef.id,
        },
      );
    } catch (e) {
      handleException(
        InvalidException(
          "Batch cannot be added because there is something wrong with them 🤯",
          false,
        ),
      );
      return null;
    }
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
}
