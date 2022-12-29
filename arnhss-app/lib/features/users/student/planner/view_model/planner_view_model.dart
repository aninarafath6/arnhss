import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/planner/models/plan.dart';
import 'package:arnhss/features/users/student/planner/repo/plan_db_service.dart';

import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:get/route_manager.dart';
import 'package:uuid/uuid.dart';

class PlannerViewModel extends ChangeNotifier with HandleException {
  final DatePickerController _timelineController = DatePickerController();
  final PlanDBService _planDBService = PlanDBService();
  final Uuid uuid = const Uuid();
  final PlanDBService _dbService = PlanDBService();

  late DateTime _selectedDate = DateTime.now();
  final List<Plan> _planList = [];
  static final TimeOfDay initialRemind =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));

  // * form controllers
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _timeController = initialRemind;
  String _planType = "#home-work";
  String _subject = "#maths";

  //* getters
  TextEditingController get titleController => _titleTextController;
  TextEditingController get descriptionController => _descriptionTextController;
  DateTime get date => _date;
  TimeOfDay get time => _timeController;
  String get planType => _planType;
  String get subject => _subject;
  List<Plan> get plans => _planList;
  int get planCount => _planList.length;

  DatePickerController get dateController => _timelineController;
  DateTime get selectedDate => _selectedDate;

  // *setters
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

// ? setter of selectedState
  set setSelectedDate(DateTime date) {
    _selectedDate = date;
    // * when change selected date then call getTaskOfTheDay which will give the selected day's plans
    getTasksOfTheDay(date);
    notifyListeners();
  }

// * validate the all inputs
  bool validate() {
    // * if anything throw error then it cath and handle exception with handleException function.
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

// * navigate to today
  void toSelectedDay() {
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
  }

  void toToday() {
    _timelineController.jumpToSelection();
  }

  void savePlan(BuildContext context) async {
    // * validate the all text field is filled
    bool status = validate();

    // * new plan with given values
    Plan newPlan = Plan(
      id: uuid.v1(),
      title: _titleTextController.text,
      note: _descriptionTextController.text,
      date: _date,
      remind: _timeController,
      subject: _subject,
      type: _planType,
      isComplete: false,
    );

    // * if status is okay ,then save the plan to local database
    if (status) {
      int res = await _planDBService.newPlan(
        newPlan,
        context,
      );

      // ?? go back to prev screen after press save button
      Get.back();

/*
  * if res  is greater than zero then we can understand 
  * the plan is added to database successfully
 */
      if (res > 0) {
        /* 
        * if selected date is new Plan's date then add this plan to plan list
        * other wise continue
      */
        if (_selectedDate == _date) {
          _planList.add(newPlan);
          notifyListeners();
        }
        // * clear all the input fields
        _titleTextController.text = "";
        _descriptionTextController.text = "";
        _date = DateTime.now();
        _timeController = initialRemind;
        _subject = "#maths";
        _planType = "#home-work";

        // ?? show the bottom snackbar
        customSnackBar(
          title: "Done😉",
          content: "new plan added to you timeline🎉",
          white: false,
          pos: SnackPosition.BOTTOM,
        );
      }
    }
  }

// * get task of the day by using date
  Future<void> getTasksOfTheDay(DateTime date) async {
    var plans = await _dbService
        .getTaskOfTheDay(DateTime.utc(date.year, date.month, date.day));

    // * clear plan list and add task which got from getTAsk of the day function from local database
    _planList.clear();
    _planList.addAll(plans);
    // ?? notify all the listeners
    notifyListeners();
  }

// * delete plan from local database
  void deletePlan(String id) {
    _dbService.removePlan(id);
    getTasksOfTheDay(_selectedDate);
  }

//* initial data selected in for
  void initialDateSelectedInFor() async {
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
