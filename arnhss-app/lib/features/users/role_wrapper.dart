import 'package:arnhss/common/widgets/layout/role_layout.dart';
import 'package:arnhss/features/users/admin/home.admin/views/home.view.admin.dart';
import 'package:arnhss/features/users/student/home/view/home.view.student.dart';
import "package:flutter/material.dart";

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({Key? key}) : super(key: key);
  static const String routeName = "/roleWrapper";

  @override
  Widget build(BuildContext context) {
    return const RoleLayout(
      admin: AdminHome(),
      student: StudentHome(),
      teacher: StudentHome(),
    );
  }
}
