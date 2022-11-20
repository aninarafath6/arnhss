import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

AppBar customHomeAppBar(BuildContext context) {
  print(context.watch<HomeViewModel>().user?.name.toString() ?? "this is");
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
          onPressed: () {
            context
                .read<HomeViewModel>()
                .scaffoldKey
                .currentState!
                .openDrawer();
          },
          icon: const Icon(Remix.command_fill, color: Colors.black, size: 30),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Hey, ${context.watch<HomeViewModel>().user?.name ?? "Unknown user"}",
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
