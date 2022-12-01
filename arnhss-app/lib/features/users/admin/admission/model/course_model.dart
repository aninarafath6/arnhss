// ignore_for_file: non_constant_identifier_names

class Course {
  final String id;
  final String code;
  final String d_code;
  final String name;

  Course({
    required this.name,
    required this.d_code,
    required this.code,
    required this.id,
  });

  Map<String, dynamic> toMap() => {
        "code": code,
        "d_code": d_code,
        "name": name,
      };

  factory Course.fromMap(Map<String, dynamic> courseMap) {
    return Course(
      name: courseMap["name"],
      d_code: courseMap["d_code"],
      code: courseMap["code"],
      id: courseMap["id"],
    );
  }
}
