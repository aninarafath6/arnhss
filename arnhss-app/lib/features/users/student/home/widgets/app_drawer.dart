import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/common/widgets/user_avatar.dart';
import 'package:arnhss/extensions/enum_extension.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/profile/view/profile_view.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:remixicon/remixicon.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    this.image = "assets/images/icons/home-and-living-badge.png.webp",
  }) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.getWidth(80),
      child: Stack(
        children: [
          Consumer<UserViewModel>(builder: (context, value, _) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.all(15.0),
                  curve: Curves.easeInOutBack,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: 0,
                        left: 190,
                        bottom: -30,
                        // alignment: Alignment.bottomRight,
                        child: Image.asset(image),
                      ),
                      Positioned(
                        right: 0,
                        // left: 0,
                        top: 0,
                        // alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const AccountTile()
                                  .getOverlayColor(value.user?.role),
                              borderRadius: BorderRadius.circular(2)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          child: Text(
                            "${value.user?.role!.fancy ?? ""}  ",
                            style: CustomTextTheme(context: context)
                                .paragraph()
                                .copyWith(
                                  fontSize: 12,
                                  color: CustomColors.dark,
                                ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserAvatar(
                            user: value.user,
                            radius: 28,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${value.user?.name?.capitalize ?? "Unknown User"} ",
                                      style: CustomTextTheme(context: context)
                                          .headLine2()
                                          .copyWith(fontSize: 17)),
                                ],
                              ),
                              Text(
                                value.user?.phone ?? "+91 XXXXXXXXXX",
                                style: CustomTextTheme(context: context)
                                    .paragraph()
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 50),
                ListTile(
                  title: const Text('My Profile'),
                  leading: const Icon(Remix.user_6_line),
                  onTap: () {
                    _drawerAction(ProfileView.routeName);
                    // Update the state of the app.

                    //* test notice board working

                    // ...
                  },
                ),
                ListTile(
                    title: const Text('Notifications'),
                    leading: const Icon(Remix.notification_2_line),
                    onTap: () {
                      _drawerAction(NotificationView.routeName);
                    }),

                ListTile(
                  title: const Text('Attendance'),
                  leading: const Icon(Remix.shield_check_line),
                  onTap: () {
                    _drawerAction(AttendanceView.routeName);
                  },
                ),
                ListTile(
                  title: const Text('Planner'),
                  leading: const Icon(Remix.file_list_2_line),
                  onTap: () {
                    _drawerAction(PlannerView.routeName);

                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Notes'),
                  leading: const Icon(Remix.book_2_line),
                  onTap: () {
                    _drawerAction(NotesView.routeName);

                    // Update the state of the app.
                    // ...
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Divider(
                    thickness: 1.2,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Get Help',
                  ),
                  leading: const Icon(Remix.chat_voice_line),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text(
                    'Developer Contact',
                  ),
                  leading: const Icon(Remix.code_s_slash_line),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                const _LogoutTile(),
              ],
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Made with ❤️ by CS2 2021-23",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "version 0.01",
                    textAlign: TextAlign.center,
                    style: CustomTextTheme(context: context)
                        .paragraph()
                        .copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _drawerAction([String? routeName]) async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(routeName ?? StudentHome.routeName);
  }
}

class _LogoutTile extends StatefulWidget {
  const _LogoutTile({
    Key? key,
  }) : super(key: key);

  @override
  State<_LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<_LogoutTile> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Logout',
        style: TextStyle(color: Colors.redAccent),
      ),
      leading: const Icon(Remix.logout_circle_r_line),
      onTap: () {
        loginModal(
          context,
          title: "Are you sure?",
          content: "Could you please confirm that you wish to sign out now?",
          deny: "DENY",
          onDeny: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            Navigator.pop(context);
          },
          done: loading
              ? const CupertinoActivityIndicator(
                  color: CustomColors.dark,
                )
              : const Text("SURE"),
          // done: "SURE".toText(style: const TextStyle(color: Colors.red)),
          // loading: loading,
          // loadingWidget: const CupertinoActivityIndicator(),
          onDone: () async {
            await Future.delayed(const Duration(milliseconds: 200));

            await context
                .read<LoginViewModel>()
                .logout(context.read<UserViewModel>().user);
            // setState(() => loading = true);
            // await Future.delayed(const Duration(milliseconds: 800));
            // setState(() => loading = false);
            // await Future.delayed(const Duration(milliseconds: 200));

            Get.offNamedUntil(LoginView.routeName, (_) => false);
          },
        );
      },
    );
  }
}
