import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';

class BatchViewModel extends ChangeNotifier {
  final AdmissionService _admissionService = AdmissionService();

  bool _loading = false;
  bool _filter = true;
  bool _isActive = true;
  final List<Batch> _batches = [];
  List<Batch> hold = [];

  set _setBatch(List<Batch> newBatch) {
    _batches.clear();
    _batches.addAll(newBatch);

    notifyListeners();
  }

  //* getters
  bool get loading => _loading;
  int get batchCount => _batches.length;
  bool get filter => _filter;
  List<Batch> get batches => _batches;
  bool get isActive => _isActive;

  //* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  void get toggleFilter {
    _filter = !filter;
    if (_filter) {
      filterWithDate();
    } else {
      print(hold);
      _setBatch = hold;
    }
    notifyListeners();
  }

  void filterWithDate() {
    // hold = _batches;
    // print(hold);
    _setBatch = hold
        .where(
          (element) =>
              element.endDate.microsecondsSinceEpoch >=
              DateTime.now().microsecondsSinceEpoch,
        )
        .toList();
    notifyListeners();
  }

  bool checkStatus(Batch batch) {
    bool status = batch.endDate.microsecondsSinceEpoch >=
        DateTime.now().microsecondsSinceEpoch;
    _isActive = status;
    notifyListeners();
    return status;
  }

  //* get course from firebase methods
  void getBatches(Course course) async {
    _toggleLoading = true;
    //? actings as delay
    await Future.delayed(const Duration(milliseconds: 300));
    //* getting course form firebase service function.
    List<Batch>? result = await _admissionService.getBatches(course);
    //* setting result into courses by the help of setting method.
    hold = result ?? [];
    filterWithDate();
    _toggleLoading = false;
  }
}
