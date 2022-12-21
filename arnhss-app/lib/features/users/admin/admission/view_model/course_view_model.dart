import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:intl/intl.dart';

class CourseViewModel with ChangeNotifier, HandleException {




  final List<Batch> _batches = [];
  // int get batchCount => _batches.length;
  bool _deleteLoading = false;

  bool _setLoading = false;
//* getters.
  // List<Batch> get batches => _batches;
  bool get getSetLoading => _setLoading;
  bool get getDeleteLoading => _deleteLoading;

  // //* setters.
  // set _toggleLoading(bool state) {
  //   _loading = state;
  //   notifyListeners();
  // }

  // set _setBatch(List<Batch> newBatch) {
  //   // _batches.clear();
  //   _batches.addAll(newBatch);

  //   notifyListeners();
  // }


//   //* add course functionality
//   Future<bool> addBatch(Course course) async {
//     bool isValid = validate();

// // * validate inputs fields
//     if (isValid) {
//       //* create new course with new data
//       Batch newBatch = Batch(
//         name: nameController.text.trim().capitalize,
//         startDate: startDateController,
//         code: batchCodeController.text.trim().toUpperCase(),
//         endDate: endDateController,
//         id: "",
//       );

//       //* start loading
//       //* and set course on firebase
//       _setToggleLoading = true;
//       await _admissionService.addBatch(newBatch, courseId: course.id).then(
//             (course) => _setBatch = [
//               ..._batches,
//               course ?? newBatch,
//             ],
//           );
//       //* set loading as false
//       _setToggleLoading = false;

//       //* clear input controllers's value
//       clearControllers();
//       return true;
//     } else {
//       return false;
//     }
//   }

  // Future<void> deleteCourse(Batch? batch, {required Course course}) async {
  //   if (batch != null) {
  //     _batches.removeWhere((element) => element.id == batch.id);
  //     debugPrint("=== batch deletion process started =====");
  //     _setToggleDeleteLoading = true;
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     await _admissionService.deleteBatch(batch, courseId: course.id).then(
  //           (value) => DialogHelper.showErrorDialog(
  //             title: "success..✅",
  //             description:
  //                 "The ${batch.name} batch has been successfully deleted.",
  //           ),
  //         );

  //     _setToggleDeleteLoading = false;
  //   } else {
  //     HandleException().handleException(
  //       InvalidException("Batch deletion failed..😟, check batch id..", false),
  //     );
  //   }
  // }
}
