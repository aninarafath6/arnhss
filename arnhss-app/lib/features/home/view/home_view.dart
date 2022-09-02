import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:remixicon/remixicon.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<HomeViewModel>().scaffoldKey,
      extendBodyBehindAppBar: false,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        width: context.getWidth(80),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: CustomColors.light.withOpacity(.1),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: 0,
                          left: 180,
                          bottom: -28,
                          // alignment: Alignment.bottomRight,
                          child: Image.asset(
                              "assets/images/icons/home-and-living-badge.png.webp"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://aninarafath.me/images/about-1.jpeg"),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              // margin: const EdgeInsets.only(top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Anin Arafath",
                                      style: CustomTextTheme(context: context)
                                          .headLine2()
                                          .copyWith(fontSize: 17)),
                                  Text(
                                    "+91 6282062527",
                                    style: CustomTextTheme(context: context)
                                        .paragraph()
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 50),
                  ListTile(
                    title: const Text('My Profile'),
                    leading: Icon(Remix.user_6_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Notifications'),
                    leading: Icon(Remix.notification_2_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Notice Board'),
                    leading: Icon(Remix.alarm_warning_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Attendance'),
                    leading: Icon(Remix.shield_check_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Todo Tasks'),
                    leading: Icon(Remix.file_list_2_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),

                  ListTile(
                    title: const Text('Notes'),
                    leading: Icon(Remix.booklet_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('TimeTable'),
                    leading: Icon(Remix.timer_2_line),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Events'),
                    leading: Icon(Remix.calendar_event_line),
                    onTap: () {
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
                    leading: Icon(Remix.chat_voice_line),
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
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("made with ❤️ by CS2 2021-23",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "version 0.001 (alpha)",
                      textAlign: TextAlign.center,
                      style: CustomTextTheme(context: context)
                          .paragraph()
                          .copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: customHomeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            NoticeList(),
            HomeGrid(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
