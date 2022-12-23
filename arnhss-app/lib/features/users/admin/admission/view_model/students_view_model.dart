import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/student.model.dart';

class StudentViewModel extends ChangeNotifier {
  final AdmissionService _admissionService = AdmissionService();

  final List<StudentModel> _students = [];
  final List<StudentModel> _allStudents = [];

  bool _loading = false;
  bool _isSearching = false;

//* getters
  List<StudentModel> get students => _students;
  bool get loading => _loading;
  bool get isSearching => _isSearching = false;

//* setters
  void toggleLoading() {
    _loading = !loading;
    notifyListeners();
  }

  void toggleSearching() {
    _isSearching = !_isSearching;
    print(_isSearching);
    notifyListeners();
  }

  void searchCountry(String qry) {
    qry = qry.toLowerCase();
    if (qry.isEmpty) {
      _students.addAll(_allStudents);
    } else {
      _students.addAll(
        _allStudents.where((element) {
          return element.admissionNo.toString().toLowerCase().contains(qry) ||
              element.name.toLowerCase().contains(qry) ||
              element.rollNumber.toString().toLowerCase().contains(qry);
        }).toList(),
      );
    }
    notifyListeners();
  }

  //* get students under course  from firebase methods
  void getStudents(Batch batch) async {
    toggleLoading();
    await Future.delayed(const Duration(milliseconds: 300));
    List<StudentModel>? result =
        await _admissionService.getStudentsUnderBatch(batch);
    _students.clear();
    _students.addAll(result ?? []);
    _allStudents.addAll(result ?? []);

    toggleLoading();
    notifyListeners();
  }

  // void getStudents(Batch batch) {
  //   _admissionService.getStudentsUnderBatch(batch);
  // }
}
