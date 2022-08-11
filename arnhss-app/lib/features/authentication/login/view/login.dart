import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/action_section.dart';
import 'package:arnhss/features/authentication/login/widgets/loginAppBar.dart';
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
      appBar: customLoginAppBar(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            controller: context.watch<LoginViewModel>().scrollController,
            children: [
              context.spacing(height: 10),
              const LoginBanner(),
              SizedBox(
                height: context.getHeight(35),
                child: const ActionSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
