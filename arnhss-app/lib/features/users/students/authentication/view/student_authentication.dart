import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/widgets/custom_banner.dart';
import 'package:arnhss/common/widgets/custom_drop_down.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class StudentAuthentication extends StatelessWidget {
  const StudentAuthentication({Key? key}) : super(key: key);
  static const routeName = "/studentAutentication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Student"),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defualt_padding),
        child: Column(
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomBanner(
                image:
                    "assets/images/icons/team-features-illustration.png.webp",
                title: "Find Your Profile",
                subtitle:
                    "serach your profile and get access from your class teacher within 48 Hours",
              ),
            ),
            const SizedBox(height: 30),
            CustomDropDown(
              title: "Select Your Profile",
              leadingIcon: Icons.keyboard_arrow_down_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 30),

            const CustomButton(
              label: "Containue",
            ),
            const SizedBox(height: 30),
            const Spacer(flex: 2),
//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Cant't find your profile? "),
                Text(
                  "Contact with us",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
