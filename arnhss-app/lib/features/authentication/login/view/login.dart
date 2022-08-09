import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/action_section.dart';
import 'package:arnhss/features/authentication/login/widgets/login_banner.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          !context.watch<CountryViewModel>().isDropDownOpen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.dark,
          ),
        ),
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const ActionSection(),
              const Expanded(
                flex: 3,
                child: LoginBanner(),
              ),
              const Expanded(
                flex: 2,
                child: ActionSection(),
              ),

              context.spacing(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
