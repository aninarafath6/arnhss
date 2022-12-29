import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/student.model.dart';
import 'dart:io';

import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';

class StudentViewModel extends ChangeNotifier with HandleException {
  final AdmissionService _admissionService = AdmissionService();

  List<StudentModel> _students = [];
  // final List<StudentModel> _allStudents = [];

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController parentPhoneController = TextEditingController();
  late TextEditingController rollNoController = TextEditingController();
  late TextEditingController admissionNoController = TextEditingController();
  DateTime? dob;
  Gender? gender;
  String? secondLang;
  File? dp;

  //* form controllers

  bool _loading = false;
  bool _addStudentLoading = false;
  bool _isSearching = false;
  int studentsCount = 0;

//* getters
  List<StudentModel> get students => _students;
  bool get loading => _loading;
  bool get isSearching => _isSearching = false;
  bool get addStudentLoading => _addStudentLoading;

//* setters
  set setDp(File file) {
    dp = file;
    notifyListeners();
  }

  set setDob(DateTime newDob) {
    dob = newDob;
    notifyListeners();
  }

  void toggleLoading() {
    _loading = !loading;
    notifyListeners();
  }

  void clearStudents() {
    _students.clear();
    notifyListeners();
  }

  void toggleSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void toggleAddStudentLoading() {
    _addStudentLoading = !_addStudentLoading;
    notifyListeners();
  }

  // void searchCountry(String qry) {
  //   qry = qry.toLowerCase();
  //   if (qry.isEmpty) {
  //     _students.addAll(_allStudents);
  //   } else {
  //     _students.addAll(
  //       _allStudents.where((element) {
  //         return element.admissionNo.toString().toLowerCase().contains(qry) ||
  //             element.name.toLowerCase().contains(qry) ||
  //             element.rollNumber.toString().toLowerCase().contains(qry);
  //       }).toList(),
  //     );
  //   }
  //   notifyListeners();
  // }

  //* validate

  bool validate({String? id}) {
    //* handling errors
    try {
      // * if mobile number is empty then throw a invalid exception
      if (nameController.text.isEmpty) {
        throw InvalidException("Please enter student name!! ", false);
      } else {
        if (emailController.text.isEmpty) {
          throw InvalidException("Please enter email id!!", false);
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
                if (parentPhoneController.text.isEmpty) {
                  throw InvalidException(
                      "Please enter parent's phone number!! ", false);
                } else {
                  if (regExp.hasMatch(parentPhoneController.text)) {
                    if (admissionNoController.text.isEmpty) {
                      throw InvalidException(
                          "Please enter Admission number!! ", false);
                    } else {
                      if (rollNoController.text.isEmpty) {
                        throw InvalidException(
                            "Please enter roll number!! ", false);
                      } else {
                        if (gender == null) {
                          throw InvalidException(
                              "Please select gender!! ", false);
                        } else {
                          if (secondLang == null) {
                            throw InvalidException(
                                "Please select second language!! ", false);
                          } else {
                            if (dob == null) {
                              throw InvalidException(
                                  "Please enter date of birth!! ", false);
                            } else {
                              return true;
                            }
                          }
                        }
                      }
                    }
                  } else {
                    throw InvalidException(
                        "Please enter valid parent phone number!", false);
                  }
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

  //* get students under course  from firebase methods
  void getStudents(Batch batch) async {
    toggleLoading();
    await Future.delayed(const Duration(milliseconds: 100));
    List<StudentModel>? result =
        await _admissionService.getStudentsUnderBatch(batch);
    _students.clear();
    _students.addAll(result ?? []);
    // _allStudents.addAll(result ?? []);

    toggleLoading();
    notifyListeners();
  }

  void getStudentsCountUnderBatch(Batch batch) async {
    // print("here");
    studentsCount = await _admissionService.getStudentsCount(batch);
    // print(studentsCount);
    notifyListeners();
  }

  //   //* add course functionality
  Future<bool> addStudent(
      {required Batch batch, required String courseName}) async {
    bool isValid = validate();

// * validate inputs fields
    if (isValid) {
      //* create new student with new data
      StudentModel newStudent = StudentModel(
        id: "",
        name: nameController.text.trim().capitalize,
        admissionNo: int.parse(admissionNoController.text),
        phone: phoneController.text,
        parentPhone: parentPhoneController.text,
        gender: gender!,
        email: emailController.text,
        lastLogin: DateTime.now(),
        dob: dob!,
        rollNumber: int.parse(rollNoController.text),
        secondLanguage: secondLang!,
        department: courseName,
      );

      //* start loading
      //* and set course on firebase
      toggleAddStudentLoading();
      await _admissionService
          .addStudent(student: newStudent, batch: batch, dp: dp)
          .then(
        (student) {
          if (student != null) {
            _students = [..._students, student];
          }
        },
      );
      //* set loading as false
      toggleAddStudentLoading();
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
    admissionNoController.clear();
    phoneController.clear();
    parentPhoneController.clear();
    rollNoController.clear();
    gender = null;
    secondLang = null;
    dob = null;
    dp = null;
  }
  // void getStudents(Batch batch) {
  //   _admissionService.getStudentsUnderBatch(batch);
  // }
}
