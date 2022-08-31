import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:flutter/material.dart';

import '../../authentication/otp_verification/view/index.dart';

class NoticeDailog extends StatelessWidget {
  const NoticeDailog({
    Key? key,
    required this.notice,
  }) : super(key: key);

  final NoticeModel notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            "Notice!!",
            style: CustomTextTheme(context: context).headLine(),
          ),
          const SizedBox(height: 30),
          Image.asset(
            "assets/images/icons/nt-going-through-files.png",
            width: 200,
          ),
          const SizedBox(height: 30),
          Text(
            notice.title ?? "",
            textAlign: TextAlign.start,
            style: CustomTextTheme(context: context)
                .headLine()
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Text(notice.descritption ?? "",
              textAlign: TextAlign.start,
              style: CustomTextTheme(context: context).paragraph()),
          const SizedBox(height: 15),
          Text(notice.subDescription ?? "",
              textAlign: TextAlign.start,
              style: CustomTextTheme(context: context).paragraph()),
          const Spacer(),
          CustomButton(
            label: "Okay",
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
