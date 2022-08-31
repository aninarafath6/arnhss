import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:flutter/material.dart';

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    Key? key,
    required this.notice,
  }) : super(key: key);
  // final IconData icon;
  // final String text;
  final NoticeModel notice;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 180,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Icon(notice.icon),
              const Spacer(),
              Text(
                notice.title ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                notice.date ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
