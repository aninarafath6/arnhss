import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_banner.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/authentication/repo/login_service.dart';
import 'package:arnhss/features/home/view/home_view.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:get/route_manager.dart';
import 'package:shimmer/shimmer.dart';

class SelectAccount extends StatefulWidget {
  const SelectAccount({Key? key}) : super(key: key);
  static const routeName = "/selectAccount";

  @override
  State<SelectAccount> createState() => _SelectAccountState();
}

class _SelectAccountState extends State<SelectAccount> {
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    LoginService().getListUsers().then(((value) {
      if (value!.isEmpty) {
        setState(() {
          isError = true;
        });
      }
    }));

    return Scaffold(
      appBar: customAppBar(context, title: "Account"),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.default_padding),
        child: Column(
          mainAxisAlignment:
              isError ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            isError ? const Spacer() : SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBanner(
                image: isError
                    ? "assets/images/icons/not_exist.png"
                    : "assets/images/icons/team-features-illustration.png.webp",
                title: isError ? "Can't Find Profile" : "Get Your Profile",
                subtitle: isError
                    ? "Your profile has not been found. Please contact your class teacher for assistance"
                    : "Choose an account to be proceed",
                isSmall: true,
              ),
            ),
            const SizedBox(height: 30),
            isError
                ? const SizedBox()
                : Expanded(
                    child: FutureBuilder<List<UserModel>?>(
                      future: LoginService().getListUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) =>
                                Shimmer.fromColors(
                                  baseColor: CustomColors.bgOverlay,
                                  highlightColor:
                                      CustomColors.light.withOpacity(.4),
                                  child: const AccountTileSkelton(),
                                )),
                            itemCount: 3,
                          );
                        }
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("error"),
                          );
                        } else if (snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AccountTile(
                                user: snapshot.data?[index],
                              );
                            },
                            itemCount: snapshot.data?.length,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),

            isError
                ? const SizedBox()
                : CustomButton(
                    label: "Continue",
                    onTap: () => Navigator.pushReplacementNamed(
                        context, HomeView.routeName),
                  ),
            const SizedBox(height: 30),
            isError ? const Spacer() : SizedBox(),
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
