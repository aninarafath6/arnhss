import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter/material.dart';

class AdmissionViewModel with ChangeNotifier, HandleException {
  //* admission service object.
  final AdmissionService _admissionService = AdmissionService();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController courseCodeController = TextEditingController();
  late TextEditingController displayCodeController = TextEditingController();

  final List<Course> _courses = [];
  bool _loading = false;
  bool _setLoading = false;

//* getters.
  List<Course> get courses => _courses;
  int get courseCount => _courses.length;
  bool get loading => _loading;
  bool get getSetLoading => _setLoading;

//* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  set _setToggleLoading(bool state) {
    _setLoading = state;
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
  bool validate() {
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
            return true;
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
            (value) => _setCourses = [
              ..._courses,
              newCourse,
            ],
          );
//* set loading as false
      _setToggleLoading = false;

      //* clear input controllers's value
      nameController.clear();
      courseCodeController.clear();
      displayCodeController.clear();
      return true;
    } else {
      return false;
    }
  }
}
