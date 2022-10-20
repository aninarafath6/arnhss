import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/view/notice_veiw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    Key? key,
    // required this.notice,
  }) : super(key: key);
  // final IconData icon;
  // final String text;
  // final NoticeModel notice;

  @override
  Widget build(BuildContext context) {
    final _notices = Provider.of<QuerySnapshot?>(context);
    List<NoticeModel>? notices = NoticeModel.listFromJson(_notices);
    print(_notices);
    var notice = _notices != null
        ? notices![0]
        : NoticeModel(
            icon: Remix.patreon_line,
            title: "Everyone Bring the fee tomorrow",
            description:
                "Everyone bring the fee tomorrow. It will be difficult to collect the fee as the program will be held on the next day.",
            date: "01 March 2022",
            subDescription:
                " Examination fees for children taking the 1st Year Higher Secondary Improvement Examination are also due tomorrow (1/9/22, 2/9/22) at school. Documents to be submitted to the school 1. Application Form 2.+1 Marklist Copy fee Paper 1 N 175 + 40 A child can write maximum 3 papers",
          );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NoticeView.routeName, arguments: notice);
      },
      child: Container(
        width: context.getWidth(100) - 41,
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 21),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Remix.alarm_warning_line),
                    SizedBox(width: 5),
                    Text(
                      "Notice Board",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // const Spacer(),
                Text(
                  notice.title ?? "",
                  style: GoogleFonts.rokkitt(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      notice.date ?? "",
                      style: GoogleFonts.breeSerif(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                // Text(
                //   notice.date ?? "",
                //   style: const TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
