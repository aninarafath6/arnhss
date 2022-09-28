import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:arnhss/services/app_exceptions.dart';
import 'package:arnhss/services/handle_exception.dart';

import 'package:get/route_manager.dart';

class NewPlanViewModel extends ChangeNotifier with HandleException {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _timeController = TimeOfDay.now();
  String _planType = "#home-work";
  String _subject = "#maths";
  bool _loading = false;
  final List<PlannerModel> _planList = [];

  // getters
  TextEditingController get titleController => _titleTextController;
  TextEditingController get descriptionController => _descriptionTextController;
  DateTime get date => _date;
  TimeOfDay get time => _timeController;
  String get planType => _planType;
  String get subject => _subject;
  List<PlannerModel> get plans => _planList;
  bool get loading => _loading;

  // setters
  set date(value) => _date = value;
  set subject(value) => _subject = value;
  set planType(value) => _planType = value;
  set setTime(value) => _timeController = value;

  bool validate() {
    try {
      if (_titleTextController.text.isEmpty ||
          _descriptionTextController.text.isEmpty) {
        throw InvalidException("please add title and description", false);
      } else {
        return true;
      }
    } catch (e) {
      handleException(e);
      return false;
    }
  }

  void savePlan() {
    bool status = validate();

    if (status) {
      _planList.add(PlannerModel(
        title: _titleTextController.text,
        note: _descriptionTextController.text,
        date: _date,
        time: _timeController,
        subject: _subject,
        type: _planType,
        isCompleted: false,
      ));
      Get.back();

      // reset
      _titleTextController.text = "";
      _descriptionTextController.text = "";
      _date = DateTime.now();
      _timeController = TimeOfDay.now();
      _subject = "#maths";
      _planType = "#home-work";

      customSnackBar(
        title: "Done😉",
        content: "new plan added to you timeline🎉",
        white: false,
        pos: SnackPosition.BOTTOM,
      );
    } else {
      debugPrint("validation false");
    }
  }

  Future<List<PlannerModel>> getTasksOfTheDay(DateTime date) async {
    _loading = true;
    await Future.delayed(const Duration(milliseconds: 800));
    return _planList;
  }
}

const List<String> monthName = <String>[
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "Mah",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

enum PlanType {
  homeWork,
  exam,
  pPlan,
}

enum Subject {
  maths,
  physics,
  cs,
  english,
  malayalam,
  chemistry,
}
