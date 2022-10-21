import 'dart:ui';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/services/firebase_database_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class NoticeItem extends StatefulWidget {
  const NoticeItem({
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeItem> createState() => _NoticeItemState();
}

class _NoticeItemState extends State<NoticeItem>
    with SingleTickerProviderStateMixin {
  static const double _expandedHeight = 450;
  static const double _initialHeight = 190;
  double height = _initialHeight;
  bool _isExpanded = false;

  late AnimationController _animationController;
  // final IconData icon;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notice = Provider.of<NoticeModel?>(context);
    updateStatus(bool status) async {
      await Future.delayed(const Duration(milliseconds: 800));
      setState(() {
        _isExpanded = status;
      });
    }

    return InkWell(
      onTap: () {
//         FireBaseDatabaseService().setNotice(NoticeModel(
//           date: "01 March 2022",
//           role: Role.principle,
//           subDescription:
//               "(Write the answer letter given below and submit it to the class teacher with the signature of the parents)\n\nNotice of parent meeting to be held on 01.09.2022 has been received. He knows that he will come to the meeting.\nParent's Signature:\nName:\nStudent Name:\nClass studied:",
//           subject: """
// Dear Parents,
// Plus one A meeting of the parents of Plus Two students is being held on Thursday 01.09.2022 at 2 pm in the Higher Secondary  Auditorium in order to evaluate the result of the general examination and similarly  to evaluate the result of the unit test and to directly assess the learning progress of the teachers' children. Your presence is requested in the said meeting.

// Regards,
// Dr. C. Anas Principal
//  29.08.2022.""",
//         ));
        setState(() {
          if (height == _expandedHeight) {
            updateStatus(false);
            height = _initialHeight;
            _animationController.duration = const Duration(milliseconds: 1000);
            _animationController.reverse();
          } else {
            updateStatus(true);
            _animationController.forward();
            height = _expandedHeight;
          }
        });
      },
<<<<<<< HEAD
      child: StreamProvider<NoticeModel?>.value(
        initialData: null,
        value: FireBaseDatabaseService().notice,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1400),
          curve: const ElasticInOutCurve(.8),
          width: context.getWidth(100) - 41,
          height:
              notice?.subject == "" || notice == null ? _initialHeight : height,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: CustomColors.lightBgOverlay,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
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
=======
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: const ElasticInCurve(1),
        width: context.getWidth(100) - 41,
        height: height,
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
>>>>>>> f0e8bef (developer branding on app draower)
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              notice?.subject == "" || notice == null
                  ? Center(
                      child: Image.asset(
                        "assets/images/icons/hero.png.webp",
                        width: 250,
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, _) {
                                      return Text(
                                        notice.subject ?? "",
                                        style: GoogleFonts.rokkitt(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: lerpDouble(3, 20,
                                                _animationController.value)!
                                            .toInt(),
                                        overflow: _isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      );
                                    }),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Positioned(
                            right: 10,
                            bottom: 0,
                            child: Column(
                              children: [
                                Text(
                                  notice.date ?? "",
                                  style: GoogleFonts.breeSerif(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    // fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  '- ${NoticeModel.toRoleString(notice.role)}',
                                  style: GoogleFonts.baloo2(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                    // fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
