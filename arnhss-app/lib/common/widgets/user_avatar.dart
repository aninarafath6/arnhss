
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.user,
    this.radius = 25,
  }) : super(key: key);

  final UserModel? user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: CustomColors.bgOverlay,
      backgroundImage:
          user?.dpURL != null ? NetworkImage(user!.dpURL!) : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: user?.dpURL == null
              ? Image.asset(
                  user?.gender == Gender.male
                      ? Images.maleStudentRoleIcon
                      : Images.femaleStudentRoleIcon,
                )
              : null,
        ),
      ),
    );
  }
}
