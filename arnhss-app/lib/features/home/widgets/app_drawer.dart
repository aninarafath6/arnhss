import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/user_avatar.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/authentication/repo/auth_service.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';
import 'package:arnhss/features/notes/view/notes_view.dart';
import 'package:arnhss/features/notifications/view/notification_view.dart';
import 'package:arnhss/services/firebase_database_service.dart';
import 'package:get/route_manager.dart';
import 'package:remixicon/remixicon.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
      {Key? key,
      this.image = "assets/images/icons/home-and-living-badge.png.webp"})
      : super(key: key);

  final String? image;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.getWidth(80),
      child: Stack(
        children: [
          Consumer<HomeViewModel>(builder: (context, value, _) {
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
                        child: Image.asset(image!),
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
                              Text(value.user?.name ?? "Unknown User",
                                  style: CustomTextTheme(context: context)
                                      .headLine2()
                                      .copyWith(fontSize: 17)),
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
                    // print("hereadfaf");
                    // Update the state of the app.
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
                // ListTile(
                //   title: const Text('Todo Tasks'),
                //   leading: Icon(Remix.file_list_2_line),
                //   onTap: () {
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),

                // ListTile(
                //   title: const Text('Notes'),
                //   leading: Icon(Remix.booklet_line),
                //   onTap: () {
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),
                // ListTile(
                //   title: const Text('TimeTable'),
                //   leading: Icon(Remix.timer_2_line),
                //   onTap: () {
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),
                // ListTile(
                //   title: const Text('Events'),
                //   leading: Icon(Remix.calendar_event_line),
                //   onTap: () {
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),
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
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  leading: const Icon(Remix.logout_circle_r_line),
                  onTap: () {
                    AuthService().logout();
                    Get.offNamedUntil(LoginView.routeName, (_) => false);
                  },
                ),
                // const SizedBox(height: 40),
                // Spacer(),
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
                    "Developed by Anin Arafath  (version 0.001)",
                    textAlign: TextAlign.center,
                    style: CustomTextTheme(context: context)
                        .paragraph()
                        .copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 10),
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
    Get.toNamed(routeName ?? HomeView.routeName);
  }
}
