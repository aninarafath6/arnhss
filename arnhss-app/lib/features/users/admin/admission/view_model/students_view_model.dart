import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/student.model.dart';

class StudentViewModel extends ChangeNotifier {
  final AdmissionService _admissionService = AdmissionService();

  final List<StudentModel> _students = [];
  bool _loading = false;

//* getters
  List<StudentModel> get students => _students;
  bool get loading => _loading;

//* setters
  void toggleLoading() {
    _loading = !loading;
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
    toggleLoading();
    notifyListeners();
  }

  // void getStudents(Batch batch) {
  //   _admissionService.getStudentsUnderBatch(batch);
  // }
}
