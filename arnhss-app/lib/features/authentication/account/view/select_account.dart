import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/widgets/custom_banner.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skeliton.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/authentication/repo/login_service.dart';
import 'package:arnhss/features/home/view/home_view.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

class SelectAccount extends StatelessWidget {
  const SelectAccount({Key? key}) : super(key: key);
  static const routeName = "/selectAccount";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Account"),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.default_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBanner(
                  image:
                      "assets/images/icons/team-features-illustration.png.webp",
                  title: "Find Your Profile",
                  subtitle: "Choose an account to be proceed",
                  isSmall: true),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: FutureBuilder<List<UserModel>?>(
                future: LoginService().getListUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator(
                      color: CustomColors.dark,
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    // Get.to(const NotExist());
                    return const SizedBox();
                  } else if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return AccountTile(
                          user: snapshot.data?[index],
                        );
                      },
                      itemCount: snapshot.data?.length,
                    );
                  } else {
                    return const CupertinoActivityIndicator(
                      color: CustomColors.dark,
                    );
                  }
                },
              ),
            ),

            CustomButton(
              label: "Continue",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, HomeView.routeName),
            ),
            const SizedBox(height: 30),
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

class NotExist extends StatelessWidget {
  const NotExist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

enum Role {
  student,
  teacher,
  parent,
}
