import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/student_avatar.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:flutter/material.dart';

class TeacherTile extends StatelessWidget {
  const TeacherTile(
      {Key? key, required this.teacher, this.onTap, this.isSelected = false})
      : super(key: key);
  final TeacherModel teacher;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: isSelected ? 1.5 : 0,
            strokeAlign: StrokeAlign.outside,
            color: CustomColors.dark.withOpacity(isSelected ? .2 : .0),
          ),
        ),
        child: ListTile(
          tileColor: CustomColors.lightBgOverlay,
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape: const RoundedRectangleBorder(),
          leading: Stack(
            children: [
              DynamicAvatar(user: teacher),
              isSelected
                  ? Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: CustomColors.dark.withOpacity(.4),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          title: teacher.name.toString().capitalize.toText(),
          subtitle: Text(
            teacher.email,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: getOverlayColor(Role.student),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(teacher.subject.name),
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
