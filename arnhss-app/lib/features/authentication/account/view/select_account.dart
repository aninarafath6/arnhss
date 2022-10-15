import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_banner.dart';
import 'package:arnhss/features/authentication/account/view_model/select_account_view_modl.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view/home_view.dart';
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
    // SelectAccountViewModel().getProfiles();
    context.read<SelectAccountViewModel>().getProfiles();

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
                    ? "Your profile has not been found. Please contact your class teacher for assistance"
                    : "Choose an account to be proceed",
                isSmall: true,
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
                : CustomButton(
                    label: "Continue",
                    onTap: () => Navigator.pushReplacementNamed(
                        context, HomeView.routeName),
                  ),
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
}
