import 'dart:io';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/features/users/student/notes/model/department_mode.dart';
import 'package:arnhss/features/users/student/notes/model/note_model.dart';
import 'package:arnhss/features/users/student/notes/repo/pdf_view.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter/material.dart';

class NotesViewModel extends ChangeNotifier with HandleException {
  final PdfService _pdfService = PdfService();
  final List<Note> _notes = [
    Note(
      name: "Relations and Functions",
      sub: "Chapter 1 / 28-12-2022",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Inverse Trigonometric Functions",
      sub: "Chapter 2 / 29-12-2022",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Matrices",
      sub: "Chapter 3 / 30-12-2022",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Determinants",
      sub: "Chapter 4 / 1-1-2023",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Continuity and Differentiability",
      sub: "Chapter 5 / 2-1-2023",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Application of Derivatives",
      sub: "Chapter 6 / 3-1-2023",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Integrals",
      sub: "Chapter 7 / 4-1-2023",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
    Note(
      name: "Application of Integrals",
      sub: "Chapter 8 / 5-1-2023",
      fileURL: "http://www.africau.edu/images/default/sample.pdf",
    ),
  ];
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
          name: "History",
          imageURL: "assets/images/pngs/notes/history.png",
        ),
        Subject(
          name: "Economics",
          imageURL: "assets/images/pngs/notes/economic.png",
        ),
        Subject(
          name: "Political Science",
          imageURL: "assets/images/pngs/notes/political-science.png",
        ),
        Subject(
          name: "Sociology",
          imageURL: "assets/images/pngs/notes/network.png",
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
  };

  // late final DepartmentModel _selectedDepartment = subjectList[Department.cs]!;
  bool _isSearching = false;
  String _path = "";

  // * getters
  // DepartmentModel get selectedDepartment => _selectedDepartment;
  bool get isSearching => _isSearching;
  List<Note> get notes => _notes;
  int get notCount => _notes.length;

  DepartmentModel getSubjects(Department? dep) {
    print(dep);
    return subjectList[dep ?? Department.cs]!;
  }

  void toggleSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

// * get notes functions
  String get file => _path;
  Future<List<Note>>? getNotes() async {
    // await Future.delayed(const Duration(seconds: 2));
    // _notes.add(

    // );
    return _notes;
    // ignore: todo
    // TODO: get note from api and add to notes list;
  }

// * setters
  set setFilePath(String path) {
    _path = path;
  }

  Future<File?> openPdfNote(Note note) async {
    return await _pdfService
        .getPdfFromNetwork(
      note.fileURL!,
    )
        .catchError((e) {
      HandleException().handleException(e);
    });
  }
}
