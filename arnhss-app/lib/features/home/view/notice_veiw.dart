import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:flutter/material.dart';

class NoticeView extends StatelessWidget {
  static const routeName = "/noticeView";

  const NoticeView({Key? key, required this.notice}) : super(key: key);
  final NoticeModel notice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice", style: TextStyle(color: CustomColors.dark)),
        centerTitle: false,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
              child: Text(notice.date ?? "",
                  textAlign: TextAlign.right,
                  style: CustomTextTheme(context: context).paragraph().copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      )),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 58.0, vertical: 15),
                    child: Image.asset(
                      "assets/images/icons/banner.png",
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notice.title!,
                    style: CustomTextTheme(context: context).headLine2(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(notice.description ?? "",
                      textAlign: TextAlign.start,
                      style: CustomTextTheme(context: context).paragraph()),
                  const SizedBox(height: 15),
                  Text(notice.subDescription ?? "",
                      textAlign: TextAlign.start,
                      style: CustomTextTheme(context: context).paragraph()),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            CustomButton(
              label: "Okay",
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
