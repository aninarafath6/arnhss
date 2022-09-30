import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:arnhss/services/app_exceptions.dart';
import 'package:arnhss/services/handle_exception.dart';
import 'package:get/route_manager.dart';
import 'package:uuid/uuid.dart';

class PlannerViewModel extends ChangeNotifier with HandleException {
  final DatePickerController _timelineController = DatePickerController();
  final Uuid uuid = const Uuid();

  late DateTime _selectedDate = DateTime.now();
  bool _loading = false;
  final List<PlannerModel> _planList = [];

  // form controllers
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _timeController = TimeOfDay.now();
  String _planType = "#home-work";
  String _subject = "#maths";

  // getters
  TextEditingController get titleController => _titleTextController;
  TextEditingController get descriptionController => _descriptionTextController;
  DateTime get date => _date;
  TimeOfDay get time => _timeController;
  String get planType => _planType;
  String get subject => _subject;
  List<PlannerModel> get plans => _planList;
  bool get loading => _loading;

  DatePickerController get dateController => _timelineController;
  DateTime get selectedDate => _selectedDate;

  // setters
  set date(value) {
    value != null ? _date = value : _date = DateTime.now();
    notifyListeners();
  }

  set subject(value) => _subject = value;
  set planType(value) => _planType = value;
  set setTime(value) {
    _timeController = value;
    notifyListeners();
  }

  set setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

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

  void toToday() {
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
  }

  void setList(PlannerModel plan) {
    _planList.add(plan);
    notifyListeners();
  }

  void savePlan() {
    bool status = validate();

    if (status) {
      setList(
        PlannerModel(
          id: uuid.v1(),
          title: _titleTextController.text,
          note: _descriptionTextController.text,
          date: _date,
          time: _timeController,
          subject: _subject,
          type: _planType,
          isCompleted: false,
        ),
      );
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

    return _planList
        .where((e) =>
            DateTime.utc(e.date!.year, e.date!.month, e.date!.day) ==
            DateTime.utc(date.year, date.month, date.day))
        .toList();
  }

  void deletePlan(String id) {
    _planList.removeWhere((element) {
      if (element.id == id) {
        customSnackBar(
          title: "Deleted🪚",
          content: element.title! + "is deleted",
          pos: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        customSnackBar(
          pos: SnackPosition.BOTTOM,
        );

        return false;
      }
    });
    notifyListeners();
  }

  void initialDateSelectedInFor() {
    _date = _selectedDate;
    notifyListeners();
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
