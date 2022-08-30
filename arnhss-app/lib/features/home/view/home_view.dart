import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/user_avatar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
        elevation: 0,
        actions: const [UserAvatar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const HomeBanner(),
            const SizedBox(height: 30),
            Container(
              height: 200,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CustomColors.dark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: .1,
                    child: Image.asset(
                      "assets/images/pngs/right-quote-sign.png",
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "We cannot solve our problems with the same thinking we used when we created them....",
                          style: CustomTextTheme(context: context)
                              .paragraph()
                              .copyWith(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              "- Albert Einstein",
                              style: CustomTextTheme(context: context)
                                  .paragraph()
                                  .copyWith(
                                      color: Colors.grey[400],
                                      fontStyle: FontStyle.italic),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notice Bord",
                    style: CustomTextTheme(context: context)
                        .headLine2()
                        .copyWith(color: Colors.grey[800])),
                Text("View all",
                    style: CustomTextTheme(context: context)
                        .paragraph()
                        .copyWith(color: Colors.blue[800])),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Container(
                  height: 250,
                  width: 200,
                  color: Colors.grey[100],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
