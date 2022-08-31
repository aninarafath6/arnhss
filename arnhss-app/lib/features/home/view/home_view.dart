import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view_models/notice_view_model.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/user_avatar.dart';
import 'package:flutter/services.dart';

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: HomeBanner(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    context.read<NoticeViewModel>().noticeList.length + 1,
                itemBuilder: (BuildContext context, index) {
                  if (context.read<NoticeViewModel>().noticeList.length !=
                      index) {
                    return context.read<NoticeViewModel>().noticeList[index];
                  } else {
                    return Row(
                      children: [
                        const SizedBox(width: 24),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_outlined),
                        ),
                        const SizedBox(width: 24),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
