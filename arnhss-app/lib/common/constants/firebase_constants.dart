import 'package:arnhss/common/enums.dart';

class FirebaseConstants {
  static const String userCollection = "users";
  static const String studentsCollection = "students";
  static const String teachersCollection = "teachers";
  static const String parentsCollection = "teachers";
  static const String noticeCollection = "notices";

  //* topics
  static const String authenticatedUSERS = "verified";
  static const String students = "students";
  static const String teachers = "teachers";
  static const String admins = "admins";

  static String getCollectionName(Role role) {
    switch (role) {
      case Role.student:
        return studentsCollection;
      case Role.teacher:
        return teachersCollection;
      case Role.parent:
        return parentsCollection;
      case Role.admin:
        return userCollection;
      default:
        return userCollection;
    }
  }
}
