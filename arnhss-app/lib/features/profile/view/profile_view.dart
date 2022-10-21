import 'package:arnhss/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customAppBar(context, title: "Profile"),
    );
  }
}
