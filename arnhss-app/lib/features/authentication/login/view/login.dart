import 'package:arnhss/common/constants/image_constant.dart';

import './index.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void dispose() {
    LoginViewModel().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("=====login screen=====");
    return Scaffold(
      appBar: customAppBar(context, title: "Login"),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            controller: context.read<LoginViewModel>().scrollController,
            addAutomaticKeepAlives: true,
            children: [
              context.spacing(height: 10),
              const CustomBanner(
                title: "Login With Mobile Number",
                subtitle: "Enter your mobile number to Continue",
                image: Images.loginIcon,
              ),
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
