import 'dart:developer';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:arnhss/extensions/enum_extension.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter/cupertino.dart';

class RoleLayout extends StatelessWidget {
  const RoleLayout({
    Key? key,
    required this.student,
    required this.teacher,
    // required this.principle,
    required this.admin,
  }) : super(key: key);

  final Widget student;
  final Widget teacher;
  final Widget admin;
  // final Widget principle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Role?>(
      future: context.getRole,
      builder: ((context, snapshot) {
        // print(snapshot.data.toString() + "this is snapshot");
        // if (role == null) {
        //   Get.toNamed(LoginView.routeName);
        // }

        if (snapshot.hasError) {
          HandleException()
              .handleException("sorry you account is not reactive😔");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }

        if (snapshot.hasData) {
          log("welcome", name: snapshot.data?.fancy ?? "");

          Role? role = snapshot.data;

          if (role == Role.student) {
            return student;
          } else if (role == Role.admin || role == Role.principle) {
            return admin;
          } else if (role == Role.teacher) {
            return teacher;
          } else {
            return const Center(
              child: Text("sorry we are not able to find your role"),
            );
          }
        }

        return const Center(
          child: Text("sorry we are not able to find your role"),
        );
      }),
    );
  }
}
