import 'dart:io';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/subject_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';

class TeacherViewModel extends ChangeNotifier with HandleException {
  final AdmissionService _admissionService = AdmissionService();

  List<TeacherModel> _teachers = [];
  List<TeacherModel> _allTeachers = [];
  final List<SubjectModel> _allSubjects = [];

  // final List<StudentModel> _allStudents = [];

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  Gender? gender;
  SubjectModel? subject;
  File? dp;

  //* form controllers

  bool _loading = false;
  bool _addTeacherLoading = false;
  bool _isSearching = false;
  int studentsCount = 0;

//* getters
  List<TeacherModel> get teachers => _teachers;
  List<TeacherModel> get allTeachers => _allTeachers;
  List<SubjectModel> get allSubjects => _allSubjects;
  bool get loading => _loading;
  bool get isSearching => _isSearching = false;
  bool get addTeacherLoading => _addTeacherLoading;

//* setters
  set setDp(File file) {
    dp = file;
    notifyListeners();
  }

  void toggleLoading() {
    _loading = !loading;
    notifyListeners();
  }

  void clearTeachers() {
    _teachers.clear();
    _allTeachers.clear();
    notifyListeners();
  }

  void toggleSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void toggleAddTeacherLoading() {
    _addTeacherLoading = !_addTeacherLoading;
    notifyListeners();
  }

  set setSubject(SubjectModel newSubject) {
    subject = newSubject;
    notifyListeners();
  }

  //* validate

  bool validate({String? id}) {
    //* handling errors
    try {
      // * if mobile number is empty then throw a invalid exception
      if (nameController.text.isEmpty) {
        throw InvalidException("Please enter teacher name!! ", false);
      } else {
        if (emailController.text.isEmpty) {
          throw InvalidException("Please enter teacher email id!!", false);
        } else {
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
              .hasMatch(emailController.text);

          if (!emailValid) {
            throw InvalidException("Please enter genuine email id!!", false);
          } else {
            if (phoneController.text.isEmpty) {
              throw InvalidException("Please enter phone number!! ", false);
            } else {
              // * mobile number regular expression pattern
              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              //* regExp
              RegExp regExp = RegExp(pattern);

              if (regExp.hasMatch(phoneController.text)) {
                if (gender != null) {
                  if (subject == null) {
                    throw InvalidException(
                        "Please select teacher's subject!", false);
                  } else {
                    return true;
                  }
                } else {
                  throw InvalidException(
                      "Please select teacher gender!", false);
                }
              } else {
                throw InvalidException(
                    "Please enter valid mobile number!", false);
              }
            }
          }
        }
      }
    } catch (e) {
      handleException(e, top: true);
      return false;
    }
  }

  //* get teachers under course  from firebase methods
  void getTeachers(String courseId) async {
    toggleLoading();

    List<TeacherModel>? result =
        await _admissionService.getTeachersUnderCourse(courseId);

    _teachers.clear();
    _teachers.addAll(result ?? []);
    toggleLoading();
    notifyListeners();
  }

  void getAllTeachers() async {
    toggleLoading();
    List<TeacherModel>? result = await _admissionService.getAllTeachers();
    _allTeachers.clear();
    _allTeachers.addAll(result ?? []);
    toggleLoading();
    notifyListeners();
  }

  void getAllSubject() async {
    List<SubjectModel>? result = await _admissionService.getAllSubjects();
    _allSubjects.clear();
    _allSubjects.addAll(result ?? []);
    notifyListeners();
  }

//   //   //* add course functionality
  Future<bool> addTeacher() async {
    bool isValid = validate();

// * validate inputs fields
    if (isValid) {
      //* create new student with new data
      TeacherModel newTeacher = TeacherModel(
        id: "",
        name: nameController.text.trim().capitalize,
        phone: phoneController.text,
        gender: gender!,
        email: emailController.text,
        lastLogin: DateTime.now(),
        subject: subject!,
      );

      //* start loading
      //* and set course on firebase
      toggleAddTeacherLoading();
      await _admissionService.addTeacher(dp: dp, teacher: newTeacher).then(
        (teacher) {
          if (teacher != null) {
            _allTeachers = [..._allTeachers, teacher];
          }
        },
      );
      //* set loading as false
      toggleAddTeacherLoading();
      //* clear input controllers's value
      clearControllers();
      return true;
    } else {
      return false;
    }
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    gender = null;
    dp = null;
    subject = null;
  }
  // void getStudents(Batch batch) {
  //   _admissionService.getStudentsUnderBatch(batch);
  // }
}
