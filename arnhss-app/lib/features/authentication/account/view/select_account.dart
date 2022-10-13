import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/widgets/custom_banner.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/extensions/string_extension.dart';
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
      appBar: customAppBar(context, title: "Student"),
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
                  if (snapshot.data!.isEmpty) {
                    return const NotFound();
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
                      color: CustomColors.white,
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

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: CustomColors.lightBgOverlay,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: const RoundedRectangleBorder(),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: CustomColors.lightBgOverlay,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(Images.studentRoleIcon),
            ),
          ),
        ),
        title: user?.name?.toText(),
        subtitle: user?.department?.toText(),
        trailing: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
              color: getOverlayColor(user?.role),
              borderRadius: BorderRadius.circular(2)),
          child: getRoleString(user?.role).toText(),
        ),
      ),
    );
  }

  Color getOverlayColor(Role? role) {
    if (role == Role.student) {
      return CustomColors.presentColor.withOpacity(.1);
    } else if (role == Role.parent) {
      return CustomColors.absentColor.withOpacity(.1);
    } else {
      return CustomColors.halfColor.withOpacity(.1);
    }
  }

  String getRoleString(Role? role) {
    if (role == Role.student) {
      return "Student";
    } else if (role == Role.parent) {
      return "Parent";
    } else {
      return "Teacher";
    }
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
