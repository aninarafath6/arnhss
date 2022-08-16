import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class StudentAuthencation extends StatelessWidget {
  const StudentAuthencation({Key? key}) : super(key: key);
  static const routeName = "/studentAutentication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Student"),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              height: context.getHeight(30),
              width: context.getWidth(90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/images/icons/team-features-illustration.png.webp")
                ],
              ),
            ),
            Text(
              "Find your Deteials",
              style: CustomTextTheme(context: context).headLine(),
            )
          ],
        ),
      ),
    );
  }
}
