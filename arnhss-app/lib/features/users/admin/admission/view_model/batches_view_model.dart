import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';

class BatchViewModel extends ChangeNotifier {
  final AdmissionService _admissionService = AdmissionService();

  bool _loading = false;
  List<Batch> _batches = [];

  set _setBatch(List<Batch> newBatch) {
    _batches.clear();
    _batches.addAll(newBatch);

    notifyListeners();
  }

  //* getters
  bool get loading => _loading;
  int get batchCount => _batches.length;
  List<Batch> get batches => _batches;

  //* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  //* get course from firebase methods
  void getBatches(Course course) async {
    _toggleLoading = true;
    //? actings as delay
    await Future.delayed(const Duration(milliseconds: 300));
    //* getting course form firebase service function.
    List<Batch>? result = await _admissionService.getBatches(course);
    //* setting result into courses by the help of setting method.
    _setBatch = result ?? [];
    _toggleLoading = false;
  }
}
