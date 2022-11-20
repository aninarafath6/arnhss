import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';

import 'package:arnhss/features/authentication/account/view_model/select_account_view_model.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import 'package:shimmer/shimmer.dart';

class SelectAccount extends StatefulWidget {
  const SelectAccount({Key? key}) : super(key: key);
  static const routeName = "/selectAccount";

  @override
  State<SelectAccount> createState() => _SelectAccountState();
}

class _SelectAccountState extends State<SelectAccount> {
  int selectedIndex = 0;

  @override
  void initState() {
    context.read<SelectAccountViewModel>().getProfiles(
          context.read<CountryViewModel>().selectedCountry.dialCode +
              context.read<LoginViewModel>().mobileNumberController.text.trim(),
          context.read<LoginViewModel>().getUserRole ?? Role.student,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = context.watch<SelectAccountViewModel>().isEmpty;
    bool isLoading = context.watch<SelectAccountViewModel>().loading;

    return Scaffold(
      appBar: customAppBar(context, title: "Account"),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.default_padding),
        child: Column(
          mainAxisAlignment:
              isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            isEmpty ? const Spacer() : const SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBanner(
                image: isEmpty
                    ? "assets/images/icons/not_exist.png"
                    : "assets/images/icons/team-features-illustration.png.webp",
                title: isEmpty ? "Can't Find Profile" : "Get Your Profile",
                subtitle: isEmpty
                    ? "Your profile has not been found. Please contact Admin for assistance"
                    : "Choose an account to be proceed",
                isSmall: true,
                titiling: true,
              ),
            ),
            const SizedBox(height: 30),
            isEmpty
                ? const SizedBox()
                : Expanded(
                    child: isLoading
                        ? Center(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) =>
                                  Shimmer.fromColors(
                                    baseColor: CustomColors.bgOverlay,
                                    highlightColor:
                                        CustomColors.light.withOpacity(.4),
                                    child: const AccountTileSkelton(),
                                  )),
                              itemCount: 3,
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return AccountTile(
                                user: context
                                    .watch<SelectAccountViewModel>()
                                    .profilesList[index],
                                isSelected: context
                                        .watch<SelectAccountViewModel>()
                                        .selectedIndex ==
                                    index,
                                onTap: () {
                                  context
                                      .read<SelectAccountViewModel>()
                                      .setSelectedIndex = index;
                                },
                              );
                            },
                            itemCount: context
                                .watch<SelectAccountViewModel>()
                                .profilesList
                                .length,
                          ),
                  ),

            isEmpty
                ? const SizedBox()
                : Consumer<SelectAccountViewModel>(
                    builder: (context, value, child) {
                    return CustomButton(
                        label: "Continue",
                        loading: value.buttonLoading,
                        onTap: value.profilesList.isNotEmpty
                            ? () {
                                value.signIn(
                                  context
                                      .read<VerifyOtpViewModel>()
                                      .authCredential,
                                  value.profilesList[value.selectedIndex],
                                  () async {
                                    value.toggleButtonLoading();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    value.toggleButtonLoading();
                                    _buildSuccess(context);
                                    await Future.delayed(
                                        const Duration(seconds: 3));
                                    Get.offNamedUntil(
                                      HomeView.routeName,
                                      ((route) => false),
                                    );
                                    context
                                        .read<LoginViewModel>()
                                        .disposeLogin();
                                  },
                                );
                              }
                            : () {
                                print("users array is now empty");
                              });
                  }),
            const SizedBox(height: 30),
            isEmpty ? const Spacer() : const SizedBox(),
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

  Future<dynamic> _buildSuccess(BuildContext context) {
    return showDialog(
      barrierColor: CustomColors.dark.withOpacity(.8),
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Lottie.asset(
                  Images.successBgLottie,
                  repeat: false,
                  width: 300,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Lottie.asset(
                  Images.profileSuccess,
                  repeat: false,
                  width: 300,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
