import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/student_avatar.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({Key? key, required this.student, this.onTap})
      : super(key: key);
  final StudentModel student;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          tileColor: CustomColors.lightBgOverlay,
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape: const RoundedRectangleBorder(),
          leading: StudentAvatar(student: student),
          title: student.name.toString().capitalize.toText(),
          subtitle: Text("Admission-No: ${student.admissionNo}"),
          trailing: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: getOverlayColor(Role.student),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text("Roll-No: ${student.rollNumber}"),
          ),
        ),
      ),
    );
  }

// * get overlay color with respect to role
  Color getOverlayColor(Role? role) {
    if (role == Role.student) {
      return CustomColors.presentColor.withOpacity(.1);
    } else if (role == Role.admin || role == Role.principle) {
      return CustomColors.absentColor.withOpacity(.1);
    } else {
      return CustomColors.halfColor.withOpacity(.1);
    }
  }
}
