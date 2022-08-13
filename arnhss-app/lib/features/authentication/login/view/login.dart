import './index.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Login"),
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
