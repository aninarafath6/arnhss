import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter/material.dart';

class AdmissionViewModel with ChangeNotifier, HandleException {
  //* admission service object.
  final AdmissionService _admissionService = AdmissionService();
  late Course selectedCourse;

  late TextEditingController nameController = TextEditingController();
  late TextEditingController courseCodeController = TextEditingController();
  late TextEditingController displayCodeController = TextEditingController();

  final List<Course> _courses = [];
  bool _loading = false;
  bool _deleteLoading = false;
  List<TeacherModel> teachers = [];
  bool _setLoading = false;

//* getters.
  List<Course> get courses => _courses;
  int get courseCount => _courses.length;
  bool get loading => _loading;
  bool get getSetLoading => _setLoading;
  bool get getDeleteLoading => _deleteLoading;

//* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  set setSelectedCourse(Course course) {
    selectedCourse = course;
    notifyListeners();
  }

  set _setToggleLoading(bool state) {
    _setLoading = state;
    notifyListeners();
  }

  set _setToggleDeleteLoading(bool state) {
    _deleteLoading = state;
    notifyListeners();
  }

  set _setCourses(List<Course> newCourses) {
    _courses.clear();
    _courses.addAll(newCourses);

    notifyListeners();
  }

//* get course from firebase methods
  void getCourses() async {
    _toggleLoading = true;
    //? actings as delay
    await Future.delayed(const Duration(milliseconds: 300));
    //* getting course form firebase service function.
    List<Course>? result = await _admissionService.getCourse();
    //* setting result into courses by the help of setting method.
    _setCourses = result ?? [];
    _toggleLoading = false;
  }

  //* validate
  bool validate({String? id}) {
    //* handling errors
    try {
      // * if mobile number is empty then throw a invalid exception
      if (nameController.text.isEmpty) {
        throw InvalidException("Please enter course name..!! ", false);
      } else {
        if (courseCodeController.text.isEmpty) {
          throw InvalidException("Please enter course code..!!", false);
        } else {
          if (courseCodeController.text.isEmpty) {
            throw InvalidException("Please enter display code..!!", false);
          } else {
            List<Course> check = _courses.where(
              (element) {
                if (id == null) {
                  return element.code.toUpperCase() ==
                      courseCodeController.text.trim().toUpperCase();
                } else {
                  return element.code.toUpperCase() ==
                          courseCodeController.text.trim().toUpperCase() &&
                      element.id != id;
                }
              },
            ).toList();

            if (check.isNotEmpty) {
              throw InvalidException("Course id is  already exist..", false);
            } else {
              return true;
            }
          }
        }
      }
    } catch (e) {
      handleException(e, top: true);
      return false;
    }
  }

  //* add course functionality
  Future<bool> addCourse() async {
    bool isValid = validate();

// * validate inputs fields
    if (isValid) {
      //* create new course with new data
      Course newCourse = Course(
        name: nameController.text.trim().capitalize,
        d_code: displayCodeController.text.trim().toUpperCase(),
        code: courseCodeController.text.trim().toUpperCase(),
        id: "",
      );

      //* start loading
      //* and set course on firebase
      _setToggleLoading = true;
      await _admissionService.addCourse(newCourse).then(
            (course) => _setCourses = [
              ..._courses,
              course ?? newCourse,
            ],
          );
      //* set loading as false
      _setToggleLoading = false;

      //* clear input controllers's value
      clearControllers();
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteCourse(Course? course) async {
    if (course != null) {
      _courses.removeWhere((element) => element.id == course.id);
      debugPrint("=== course deletion process started =====");
      _setToggleDeleteLoading = true;
      await Future.delayed(const Duration(milliseconds: 300));
      await _admissionService.deleteCourse(course).then(
            (value) => DialogHelper.showErrorDialog(
              title: "success..✅",
              description:
                  "The ${course.name} course has been successfully deleted.",
            ),
          );

      _setToggleDeleteLoading = false;
    } else {
      HandleException().handleException(
        InvalidException(
            "Course deletion failed..😟, check course id..", false),
      );
    }
  }

  //* edit course
  void setUpToUpdate(Course course) {
    nameController.text = course.name;
    displayCodeController.text = course.d_code;
    courseCodeController.text = course.code;
  }

  void clearControllers() {
    nameController.clear();
    courseCodeController.clear();
    displayCodeController.clear();
  }

  Future<bool> update(Course oldCourse) async {
    bool isValid = validate(id: oldCourse.id);

// * validate inputs fields
    if (isValid) {
      //* create new course with new data
      Course updatedCourse = Course(
        name: nameController.text.trim().capitalize,
        d_code: displayCodeController.text.trim().toUpperCase(),
        code: courseCodeController.text.trim().toUpperCase(),
        id: oldCourse.id,
      );

      //* start loading
      //* and set course on firebase
      _setToggleLoading = true;
      await _admissionService.editCourse(updatedCourse).then((value) {
        var index =
            _courses.indexWhere((element) => element.id == updatedCourse.id);
        _courses[index] = updatedCourse;
        selectedCourse = updatedCourse;
      });
      //* set loading as false
      _setToggleLoading = false;

      //* clear input controllers's value
      clearControllers();
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, String?>> getCourseData(Course course) async {
    return await _admissionService.getCourseInnerData(course);
  }

  //* get teachers under course  from firebase methods
  void getTeachers() async {
    
    List<TeacherModel>? result =
        await _admissionService.getTeachersUnderCourse(selectedCourse.id);
    teachers.clear();
    teachers.addAll(result ?? []);
    notifyListeners();
  }
}
