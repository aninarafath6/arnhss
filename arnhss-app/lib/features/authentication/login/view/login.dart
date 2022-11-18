import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/widgets/responsive_layout.dart';
import 'package:arnhss/features/onboarding/view/onboard_background.dart';

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
    // LoginViewModel().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("=====login screen=====");
    return Scaffold(
      appBar: customAppBar(context, title: "Login"),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.default_padding),
          child: ResponsiveLayout(
            mobile: Column(
              // physics: NeverScrollableScrollPhysics(),
              // controller: context.watch<LoginViewModel>().scrollController,
              // addAutomaticKeepAlives: true,
              children: const [
                Expanded(
                    child: Background(image: Images.loginIcon, padding: 30),
                    flex: 1),
                SizedBox(height: 10),
                Expanded(
                  child: ActionSection(
                    title: "Login With Mobile Number",
                    subtitle: "Enter your mobile number to Continue",
                  ),
                ),
              ],
            ),
            tablet: Row(
              // physics: NeverScrollableScrollPhysics(),
              // controller: context.watch<LoginViewModel>().scrollController,
              // addAutomaticKeepAlives: true,
              children: const [
                Expanded(child: Background(image: Images.loginIcon)),
                SizedBox(height: 30),
                Expanded(
                  child: ActionSection(
                    title: "Login With Mobile Number",
                    subtitle: "Enter your mobile number to Continue",
                  ),
                ),

                // context.spacing(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
