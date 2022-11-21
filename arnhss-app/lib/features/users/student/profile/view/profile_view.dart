import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customAppBar(
        context,
        title: "Profile",
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {},
            icon: const Icon(Remix.qr_code_line, color: CustomColors.dark),
          ),
        ],
      ),
    );
  }
}
