import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      child: ListView(
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
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          "https://aninarafath.me/images/about-1.jpeg"),
                    ),
                    const SizedBox(width: 10),
                    Column(
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
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Made with ❤️ by CS2 2021-23",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
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
    );
  }
}
