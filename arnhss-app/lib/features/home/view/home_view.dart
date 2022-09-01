import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/blog_list.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:arnhss/features/home/widgets/qout_0f_the_day.dart';
import 'package:arnhss/features/home/widgets/user_avatar.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home ";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leadingWidth: 60,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
        elevation: 0,
        leading:
            const Icon(Remix.menu_4_line, color: CustomColors.dark, size: 30),
        actions: const [UserAvatar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24, top: 20),
              child: HomeBanner(),
            ),
            SizedBox(height: 40),
            // Padding(
            //   padding: EdgeInsets.all(24.0),
            //   child: QoutOfTheDay(),
            // ),
            NoticeList(),

            // SizedBox(height: 20),
            BlogList()
          ],
        ),
      ),
    );
  }
}
