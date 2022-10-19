import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/view/notice_veiw.dart';

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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NoticeView.routeName, arguments: notice);
      },
      child: Container(
        width: context.getWidth(55),
        height: 180,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: CustomColors.lightBgOverlay,
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
      ),
    );
  }
}
