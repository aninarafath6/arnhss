import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/notice_item.dart';
import 'package:arnhss/features/home/widgets/user_avatar.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leadingWidth: 60,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
        elevation: 0,
        leading: const Icon(Icons.abc, color: Colors.transparent),
        actions: const [UserAvatar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: ListView(
          children: [
            // SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: HomeBanner(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 24),
                  NoticeItem(
                    notice: NoticeModel(
                      icon: Remix.notification_line,
                      title:
                          "Everyone bring the fee tomorrow. It will be difficult to collect the fee as the program will be held on the next day.",
                      date: "01 March 2022",
                    ),
                  ),
                  NoticeItem(
                    notice: NoticeModel(
                      date: "01 March 2022",
                      icon: Remix.money_pound_circle_line,
                      title: "School is going for veccation in next month.",
                    ),
                  ),
                  NoticeItem(
                    notice: NoticeModel(
                      date: "01 March 2022",
                      icon: Remix.notification_line,
                      title: "School is going for veccation in next month.",
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_outlined),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
