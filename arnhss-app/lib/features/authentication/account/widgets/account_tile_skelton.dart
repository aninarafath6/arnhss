import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../view/select_account.dart';

class AccountTileSkelton extends StatelessWidget {
  const AccountTileSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.lightBgOverlay,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 15,
                color: Colors.green,
              ),
              const SizedBox(height: 5),
              Container(
                width: 120,
                height: 10,
                color: Colors.green,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 60,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.green,
              // borderRadius: BorderRadius.circular(25),
            ),
          )
        ],
      ),
      height: 80,
      margin: const EdgeInsets.only(bottom: 15),
    );
  }

  Color getOverlayColor(Role? role) {
    if (role == Role.student) {
      return CustomColors.presentColor.withOpacity(.1);
    } else if (role == Role.parent) {
      return CustomColors.absentColor.withOpacity(.1);
    } else {
      return CustomColors.halfColor.withOpacity(.1);
    }
  }

  String getRoleString(Role? role) {
    if (role == Role.student) {
      return "Student";
    } else if (role == Role.parent) {
      return "Parent";
    } else {
      return "Teacher";
    }
  }
}
