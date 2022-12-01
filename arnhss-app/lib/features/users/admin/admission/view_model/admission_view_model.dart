import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:flutter/material.dart';

class AdmissionViewModel with ChangeNotifier {
  //* admission service object.
  final AdmissionService _admissionService = AdmissionService();

  final List<Course> _courses = [];
  bool _loading = false;

//* getters.
  List<Course> get courses => _courses;
  int get courseCount => _courses.length;
  bool get loading => _loading;

//* setters.
  set _toggleLoading(bool state) {
    _loading = state;
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
}
