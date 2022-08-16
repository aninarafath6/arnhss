import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class StudentAuthencation extends StatelessWidget {
  const StudentAuthencation({Key? key}) : super(key: key);
  static const routeName = "/studentAutentication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Student"),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defualt_padding),
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
              "Find Your Profile",
              style: CustomTextTheme(context: context).headLine(),
            ),
            const SizedBox(height: 15),

            Text(
              "serach your profile and get access from your class teacher within 48 Hours",
              textAlign: TextAlign.center,
              style: CustomTextTheme(context: context).paragraph(),
            ),
            const SizedBox(height: 80),
            Container(
              width: context.getWidth(100),
              height: 55,
              decoration: BoxDecoration(
                  color: const Color(0xfff1f5f9),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(
                  "Select your Profile",
                  style: CustomTextTheme(context: context).headLine2().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: context.getHeight(1.6),
                      ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            )
            // const CustomButton(
            //   label: "Select your Profile",
            //   color: Color(0xfff1f5f9),
            //   textColor: CustomColors.dark,
            // ),
          ],
        ),
      ),
    );
  }
}
