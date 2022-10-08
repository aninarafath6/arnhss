class DepartmentModel {
  final List<Subject>? subjects;
  DepartmentModel({this.subjects});
}

class Subject {
  final String? name;
  final String? imageURL;

  Subject({this.imageURL, this.name});
}
