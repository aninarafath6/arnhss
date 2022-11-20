import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/user_avatar.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:arnhss/extensions/enum_extension.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, this.user, this.isSelected = true, this.onTap})
      : super(key: key);
  final UserModel? user;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected ? 1.5 : 0,
            color: CustomColors.dark.withOpacity(isSelected ? .2 : .0),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          tileColor: CustomColors.lightBgOverlay,
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape: const RoundedRectangleBorder(),
          leading: UserAvatar(user: user),
          title: user!.name.toString().capitalize.toText(),
          subtitle: (user!.role == Role.student
              ? user!.department?.describe.capitalize.toText(
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )
              : user!.email?.toText(
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )),
          trailing: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: getOverlayColor(user?.role),
              borderRadius: BorderRadius.circular(2),
            ),
            child: user!.role!.describe.capitalize.toText(),
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

  // String getRoleString(Role? role) {
  //   if (role == Role.student) {
  //     return "Student";
  //   } else if (role == Role.parent) {
  //     return "Parent";
  //   } else {
  //     return "Teacher";
  //   }
  // }
}
