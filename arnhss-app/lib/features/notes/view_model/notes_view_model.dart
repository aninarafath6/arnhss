import 'package:arnhss/features/notes/model/department_mode.dart';
import 'package:flutter/material.dart';

class NotesViewModel with ChangeNotifier {
  Map<Department, DepartmentModel> subjectList = {
    Department.cs: DepartmentModel(
      subjects: [
        Subject(
          name: "Computer Science",
          imageURL: "assets/images/pngs/notes/data-science.png",
        ),
        Subject(
          name: "Maths",
          imageURL: "assets/images/pngs/notes/math.png",
        ),
        Subject(
          name: "Physics",
          imageURL: "assets/images/pngs/notes/physics.png",
        ),
        Subject(
          name: "Chemistry",
          imageURL: "assets/images/pngs/notes/chemistry.png",
        ),
        Subject(
          name: "English",
          imageURL: "assets/images/pngs/notes/understanding.png",
        ),
        Subject(
          name: "Language",
          imageURL: "assets/images/pngs/notes/language.png",
        ),
      ],
    ),
    Department.science: DepartmentModel(
      subjects: [
        Subject(
          name: "Zoology",
          imageURL: "assets/images/pngs/notes/zoology.png",
        ),
        Subject(
          name: "Botany",
          imageURL: "assets/images/pngs/notes/botany.png",
        ),
        Subject(
          name: "Maths",
          imageURL: "assets/images/pngs/notes/math.png",
        ),
        Subject(
          name: "Physics",
          imageURL: "assets/images/pngs/notes/physics.png",
        ),
        Subject(
          name: "Chemistry",
          imageURL: "assets/images/pngs/notes/chemistry.png",
        ),
        Subject(
          name: "English",
          imageURL: "assets/images/pngs/notes/understanding.png",
        ),
        Subject(
          name: "Language",
          imageURL: "assets/images/pngs/notes/language.png",
        ),
      ],
    ),
    Department.commerce: DepartmentModel(
      subjects: [
        Subject(
          name: "Accountancy",
          imageURL: "assets/images/pngs/notes/accounting.png",
        ),
        Subject(
          name: "Economics",
          imageURL: "assets/images/pngs/notes/economic.png",
        ),
        Subject(
          name: "Computer Applications",
          imageURL: "assets/images/pngs/notes/data-science.png",
        ),
        Subject(
          name: "Business Studies",
          imageURL: "assets/images/pngs/notes/case-study.png",
        ),
        Subject(
          name: "English",
          imageURL: "assets/images/pngs/notes/understanding.png",
        ),
        Subject(
          name: "Language",
          imageURL: "assets/images/pngs/notes/language.png",
        ),
      ],
    ),
    Department.humanities: DepartmentModel(
      subjects: [
        Subject(
          name: "Sub 1",
          imageURL: "assets/images/pngs/notes/accounting.png",
        ),
        Subject(
          name: "Sub 2",
          imageURL: "assets/images/pngs/notes/economic.png",
        ),
        Subject(
          name: "Sub 3",
          imageURL: "assets/images/pngs/notes/data-science.png",
        ),
        Subject(
          name: "Sub 4",
          imageURL: "assets/images/pngs/notes/case-study.png",
        ),
        Subject(
          name: "Sub 5",
          imageURL: "assets/images/pngs/notes/understanding.png",
        ),
        Subject(
          name: "Sub 6",
          imageURL: "assets/images/pngs/notes/language.png",
        ),
      ],
    ),
  };

  late final DepartmentModel _selectedDepartment = subjectList[Department.cs]!;
  bool _isSearching = false;

  // * getters
  DepartmentModel get selectedDepartment => _selectedDepartment;
  bool get isSearching => _isSearching;

  void toggleSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
    print("hereadfaf");
  }
}

enum Department {
  cs,
  humanities,
  commerce,
  science,
}
