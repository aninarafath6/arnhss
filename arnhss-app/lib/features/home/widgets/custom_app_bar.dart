import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

AppBar customHomeAppBar(BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false, // Don't show the leading button
    toolbarHeight: 100,
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
            // print("opend");
          },
          icon: const Icon(Remix.command_fill, color: Colors.black, size: 30),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hey, Anin Arafath",
                style: TextStyle(
                  color: CustomColors.dark,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 5),
            Text(
              "Monday, 4 march ",
              style: TextStyle(
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
