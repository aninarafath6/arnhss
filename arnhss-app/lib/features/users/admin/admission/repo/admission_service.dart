import 'dart:developer';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/firebase_common_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AdmissionService with HandleException {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final FirebaseCommonService _firebaseCommonService = FirebaseCommonService();

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
      DocumentSnapshot oldCourse = await collectionRef.doc(course.id).get();
      Map<String, dynamic> old = oldCourse.data() as Map<String, dynamic>;

      print(old["name"]);

      storage
          .ref("")
          .updateMetadata(
              SettableMetadata(customMetadata: {'name': course.name}))
          .then((_) {
        print('Folder successfully renamed');
      }).catchError((error) {
        print('Error renaming folder: $error');
      });

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
            DocumentReference teacherRef = e.data()["teacher"];
            DocumentReference? leaderRef = e.data()["leader"];

            DocumentSnapshot teacher =
                await _firestore.doc(teacherRef.path).get();
            DocumentSnapshot? leader;

            if (leaderRef != null) {
              leader = await _firestore.doc(leaderRef.path).get();
            }

            // var batchDetails = await e.reference.parent.parent?.get();

            //* fetching batch details
            var courseDetails = await e.reference.parent.parent?.get();
            // String? leaderDP = await _firebaseCommonService.getStudentDP(
            //     courseDetails?.data()?["name"], e.data()["name"], e.id);

            return Batch.fromMap(
              {
                ...e.data(),
                "id": e.id,
                "course_id": course.id,
                "reference": e.reference,
                "leader": leader != null
                    ? StudentModel.fromJSON(
                        {
                          ...leader.data() as Map<String, dynamic>,
                          "reference": leader.reference,
                          "id": leader.id,
                          "batch": e.data()["name"],
                          "department": courseDetails?.data()?["name"],
                        },
                      )
                    : null,
                "teacher": TeacherModel.fromMap(
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
          "reference": docRef,
        },
      );
    } catch (e) {
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
          var _batch = await _firestore
              .collection(batchRef)
              .doc(batch.id)
              .collection("students")
              .get();
          count += _batch.docs.length;

          // await Future.wait(
          //   _batch.map(
          //     (division) async {
          //       var students = await _firestore
          //           .collection("$batchRef/${batch.id}/${batch.id}/students")
          //           .get();

          //       count += students.docs.length;
          //     },
          //   ),
          // );
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
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("course/$courseId/teachers").get();

      return Future.wait(
        querySnapshot.docs.map(
          (e) async {
            DocumentReference teacherRef =
                e.data()["reference"] as DocumentReference;
            DocumentSnapshot<Map<String, dynamic>> teacher =
                await _firestore.doc(teacherRef.path).get();
            return TeacherModel.fromMap(
              {
                ...?teacher.data(),
                "id": teacher.id,
                "reference": teacher.reference,
              },
            );
          },
        ).toList(),
      );
    } catch (e) {
      // print(e);
      handleException(
          InvalidException("Something wrong with teachers 🤯", false));
      // Future.error("error");
    }
    return null;
  }

  ///* batch service
  Future<List<StudentModel>?> getStudentsUnderBatch(Batch batch) async {
    try {
      //* fetching sorted course data by course code
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("course/${batch.courseId}/batches/${batch.id}/students")
          .orderBy("roll_no")
          .get();

      print(querySnapshot.docs);
      return Future.wait(querySnapshot.docs.map(
        (e) async {
          //* fetching division details
          var batchDetails = await e.reference.parent.parent?.get();

          //* fetching batch details
          var courseDetails =
              await batchDetails?.reference.parent.parent?.get();
          String? dpURL = await _firebaseCommonService.getStudentDP(
            batchDetails?.reference,
            e.id,
          );
          return StudentModel.fromJSON(
            {
              ...e.data(),
              "id": e.id,
              "reference": e.reference,
              "batch": batchDetails?.data()?["name"],
              "department": courseDetails?.data()?["name"],
              "dpURL": dpURL,
            },
          );
        },
      ).toList());
    } catch (e) {
      debugPrint(e.toString());
      handleException(
        InvalidException("Something wrong with course 🤯", false),
      );
      // Future.error("error");
    }
    return null;
  }

  Future<int> getStudentsCount(Batch batch) async {
    try {
      //* fetching sorted course data by course code
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("course/${batch.courseId}/batches/${batch.id}/students")
          .get();

      return querySnapshot.size;
    } catch (e) {
      debugPrint(e.toString());
      handleException(
        InvalidException("Something wrong with course 🤯", false),
      );
      // Future.error("error");
    }
    return 0;
  }

  Future<StudentModel?> addStudent({
    required StudentModel student,
    required Batch batch,
    File? dp,
  }) async {
    try {
      var collectionRef =
          _firestore.collection("${batch.reference?.path}/students");

      var docRef = await collectionRef.add(student.toJSON());
      var data = await docRef.get();

      if (dp != null) {
        print("${batch.reference?.parent.parent?.id.toString()}is p id");

        print("${batch.reference?.id} is b id");
        await storage
            .ref(
                'students/${batch.reference?.parent.parent?.id}/${batch.id}/dp/${docRef.id}.jpg')
            .putFile(dp);
      }

      String? dpURL = await _firebaseCommonService.getStudentDP(
        batch.reference,
        data.id,
      );

      return StudentModel.fromJSON(
        {
          ...(data.data() as Map<String, dynamic>),
          "id": data.id,
          "reference": data.reference,
          "batch": batch.name,
          "department": student.department,
          "dpURL": dpURL,
        },
      );
    } catch (e) {
      print(e);
      handleException(
        InvalidException(
          "Student is not added 🤯",
          false,
        ),
      );
    }
    return null;
  }
}
