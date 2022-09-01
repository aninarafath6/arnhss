import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
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
          physics: const BouncingScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: HomeBanner(),
            ),
            const SizedBox(height: 40),
            const NoticeList(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Jst For You",
                        style: CustomTextTheme(context: context)
                            .headLine()
                            .copyWith(fontSize: 20),
                      ),
                      const Spacer(),
                      Text(
                        "View all",
                        style: CustomTextTheme(context: context)
                            .paragraph()
                            .copyWith(fontSize: 14, color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                              color: CustomColors.dark,
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://collegemarker.com/blogs/wp-content/uploads/2022/02/secondary-school-student.jpg",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                              color: CustomColors.dark.withOpacity(.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "20 Ways to Learn More\nEfficiently",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextTheme(context: context)
                                    .headLine2()
                                    .copyWith(fontSize: 15),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                  "Ideation is a creative process where designersgenerate ideas in sessions (e.g. brainstorming",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 15),
                              Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg"),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Elone musk",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  // Spacer(),
                                  const SizedBox(width: 15),
                                  Icon(Icons.circle,
                                      size: 8, color: Colors.grey[600]),
                                  const SizedBox(width: 8),

                                  Text(
                                    "Yesterday",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
