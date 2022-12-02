import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:intl/intl.dart';

class BatchViewModel with ChangeNotifier, HandleException {
  final AdmissionService _admissionService = AdmissionService();
  final DateFormat formatter = DateFormat('yyyy');

  late TextEditingController nameController = TextEditingController();
  late TextEditingController batchCodeController = TextEditingController();
  DateTime startDateController = DateTime.now();
  DateTime endDateController =
      DateTime.now().add(const Duration(days: 365 * 2));

  final List<Batch> _batches = [];
  bool _loading = false;
  int get batchCount => _batches.length;
  bool _deleteLoading = false;

  bool _setLoading = false;
//* getters.
  List<Batch> get batches => _batches;
  bool get loading => _loading;
  bool get getSetLoading => _setLoading;
  bool get getDeleteLoading => _deleteLoading;

  //* setters.
  set _toggleLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  set _setBatch(List<Batch> newBatch) {
    _batches.clear();
    _batches.addAll(newBatch);

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

  set setEndDate(DateTime date) {
    endDateController = date;
    notifyListeners();
  }

  set setStartDate(DateTime date) {
    startDateController = date;
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

  //* edit course
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
          if (startDateController == null || endDateController == null) {
            throw InvalidException(
                "Please select start date and end date..!!", false);
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
      }
    } catch (e) {
      handleException(e, top: true);
      return false;
    }
  }

  void setUpForAdd(Course course) {
    nameController.text =
        "${formatter.format(startDateController).toString()}-${formatter.format(endDateController).toString()} ${course.d_code.toUpperCase()}";
  }

  //* add course functionality
  Future<bool> addBatch(Course course) async {
    bool isValid = validate();

// * validate inputs fields
    if (isValid) {
      //* create new course with new data
      Batch newBatch = Batch(
        name: nameController.text.trim().capitalize,
        startDate: startDateController,
        code: batchCodeController.text.trim().toUpperCase(),
        endDate: endDateController,
        id: "",
      );

      //* start loading
      //* and set course on firebase
      _setToggleLoading = true;
      await _admissionService.addBatch(newBatch, courseId: course.id).then(
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

  Future<void> deleteCourse(Batch? batch, {required Course course}) async {
    if (batch != null) {
      _batches.removeWhere((element) => element.id == batch.id);
      debugPrint("=== batch deletion process started =====");
      _setToggleDeleteLoading = true;
      await Future.delayed(const Duration(milliseconds: 300));
      await _admissionService.deleteBatch(batch, courseId: course.id).then(
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
}
