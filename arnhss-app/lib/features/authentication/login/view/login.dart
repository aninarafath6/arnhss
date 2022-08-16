import 'package:arnhss/common/constants/image_constant.dart';

import './index.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    debugPrint("=====login screen=====");
    return Scaffold(
      appBar: customAppBar(context, title: "Login"),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<LoginViewModel>(
            builder: ((context, value, child) => ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: value.scrollController,
                  addAutomaticKeepAlives: true,
                  children: [
                    context.spacing(height: 10),
                    const CustomBanner(
                        title: "Login With Mobile Number",
                        subtitle: "Enter your mobile number to Continue",
                        image: Images.loginIcon),
                    SizedBox(
                      height: context.getHeight(35),
                      child: const ActionSection(),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
