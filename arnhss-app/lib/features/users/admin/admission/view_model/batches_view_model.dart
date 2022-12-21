import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';

class BatchViewModel extends ChangeNotifier with HandleException {
  final AdmissionService _admissionService = AdmissionService();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController batchCodeController = TextEditingController();
  DateTime startDateController = DateTime.now();
  DateTime endDateController = DateTime.utc(DateTime.now().year + 2);
  bool _loading = false;
  bool _deleteLoading = false;
  bool _filter = true;
  bool _isActive = true;
  final List<Batch> _batches = [];
  List<Batch> hold = [];

  set _setBatch(List<Batch> newBatch) {
    _batches.clear();
    _batches.addAll(newBatch);
    notifyListeners();
  }

  set _setHold(List<Batch> holdings) {
    hold.clear();
    hold.addAll(holdings);
    notifyListeners();
  }

  //* getters
  bool get loading => _loading;
  bool get deleteLoading => _deleteLoading;
  int get batchCount => _batches.length;
  bool get filter => _filter;
  List<Batch> get batches => _batches;
  bool get isActive => _isActive;

  //* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  set _setToggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  set _setToggleDeleteLoading(bool state) {
    _deleteLoading = state;
    notifyListeners();
  }

  set setEndDate(DateTime date) {
    endDateController = date;
    notifyListeners();
  }

  set setStartDate(DateTime date) {
    startDateController = date;
    notifyListeners();
  }

  //* edit batch
  void setUpToUpdate(Batch batch) {
    nameController.text = batch.name;
    endDateController = batch.endDate;
    startDateController = batch.startDate;
    batchCodeController.text = batch.code;
  }

  void clearControllers() {
    nameController.clear();
    batchCodeController.clear();
  }

  void setUpForAdd(Course course) {
    final DateFormat formatter = DateFormat('yyyy');
    nameController.text =
        "${formatter.format(startDateController).toString()}-${formatter.format(endDateController).toString()} ${course.d_code.toUpperCase()}";
  }

  void get toggleFilter {
    _filter = !filter;
    if (_filter) {
      filterWithDate();
    } else {
      _setBatch = hold;
    }
    notifyListeners();
  }

  void filterWithDate() {
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
    _setHold = result ?? [];
    _setBatch = result ?? [];

    if (_filter) {
      filterWithDate();
    }
    _toggleLoading = false;
  }

  //* validate
  bool validate({String? id}) {
    //* handling errors
    try {
      // * if mobile number is empty then throw a invalid exception
      if (nameController.text.isEmpty) {
        throw InvalidException("Please enter batch name..!! ", false);
      } else {
        if (batchCodeController.text.isEmpty) {
          throw InvalidException("Please enter batch code..!!", false);
        } else {
          List<Batch> check = _batches.where(
            (element) {
              if (id == null) {
                return element.code.toUpperCase() ==
                        batchCodeController.text.trim().toUpperCase() ||
                    element.name.toUpperCase() ==
                        nameController.text.trim().toUpperCase();
              } else {
                return element.code.toUpperCase() ==
                            batchCodeController.text.trim().toUpperCase() &&
                        element.id != id ||
                    element.name.toUpperCase() ==
                        nameController.text.trim().toUpperCase();
              }
            },
          ).toList();

          if (check.isNotEmpty) {
            throw InvalidException(
                "Batch id or name is already exist..", false);
          } else {
            if (startDateController.microsecondsSinceEpoch <
                endDateController.microsecondsSinceEpoch) {
              return true;
            } else {
              throw InvalidException(
                  "Start date must be greater than end date...", false);
            }
          }
        }
      }
    } catch (e) {
      handleException(e, top: true);
      return false;
    }
  }

//   //* add course functionality
  Future<bool> addBatch(String courseID) async {
    bool isValid = validate();

// * validate inputs fields
    if (isValid) {
      //* create new course with new data
      Batch newBatch = Batch(
        name: nameController.text.trim().capitalize ?? "",
        startDate: startDateController,
        code: batchCodeController.text.trim().toUpperCase(),
        endDate: endDateController,
        courseId: courseID,
        id: "",
      );

      //* start loading
      //* and set course on firebase
      _setToggleLoading = true;
      await _admissionService.addBatch(newBatch, courseId: courseID).then(
            (course) => _setBatch = [
              ..._batches,
              course ?? newBatch,
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

  Future<void> deleteBatch(Batch? batch) async {
    if (batch != null) {
      _batches.removeWhere((element) => element.id == batch.id);
      debugPrint("=== batch deletion process started =====");
      _setToggleDeleteLoading = true;
      await Future.delayed(const Duration(milliseconds: 300));
      await _admissionService.deleteBatch(batch, courseId: batch.courseId).then(
            (value) => DialogHelper.showErrorDialog(
              title: "success..✅",
              description:
                  "The ${batch.name} batch has been successfully deleted.",
            ),
          );

      _setToggleDeleteLoading = false;
    } else {
      HandleException().handleException(
        InvalidException("Batch deletion failed..😟, check batch id..", false),
      );
    }
  }

  Future<bool> update(Batch oldBatch) async {
    bool isValid = validate(id: oldBatch.id);

    print("here");

// * validate inputs fields
    if (isValid) {
      //* create new batch with new data
      Batch updatedBatch = Batch(
        name: nameController.text.trim().capitalize ?? "",
        code: batchCodeController.text.trim().toUpperCase(),
        endDate: endDateController,
        startDate: startDateController,
        courseId: oldBatch.courseId,
        id: oldBatch.id,
      );

      //* start loading
      //* and set batch on firebase
      _setToggleLoading = true;
      await _admissionService.editBatch(updatedBatch).then((value) {
        var index =
            _batches.indexWhere((element) => element.id == updatedBatch.id);
        _batches[index] = updatedBatch;
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
}
