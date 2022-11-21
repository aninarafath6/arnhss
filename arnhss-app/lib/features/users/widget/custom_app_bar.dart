import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

AppBar customHomeAppBar(BuildContext context, UserModel? user) {
  final DateFormat formatter = DateFormat('EEEE, dd MMMM');

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false, // Don't show the leading button
    toolbarHeight: 80,
    title: Row(
      children: [
        IconButton(
          splashRadius: 28,
          onPressed: () => context
              .read<UserViewModel>()
              .scaffoldKey
              .currentState!
              .openDrawer(),
          icon: const Icon(Remix.command_fill, color: Colors.black, size: 30),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Hey, ${user?.name ?? ""} ${user?.role == Role.admin ? "🔓" : ""}",
                style: const TextStyle(
                  color: CustomColors.dark,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 5),
            Text(
            formatter.format(DateTime.now()).toString(),
              style: const TextStyle(
                color: CustomColors.light,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
    elevation: 0,
    centerTitle: false,
  );
}
