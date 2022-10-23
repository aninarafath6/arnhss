import 'dart:ui';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/models/user.model.dart';
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
  static const double _initialHeight = 190;
  static const double _expandedHeight = 500;
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

    if (notice == null) {
      updateStatus(false);
      height = _initialHeight;
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (height == _expandedHeight) {
            updateStatus(false);
            height = _initialHeight;
            _animationController.duration = const Duration(milliseconds: 1000);
            _animationController.reverse();
          } else {
            if (notice != null) {
              updateStatus(true);
            }
            _animationController.forward();
            height = _expandedHeight;
          }
        });
      },
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              key: ValueKey(notice?.id),
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
                            Row(
                              children: [
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      '- ${UserModel.toStringRole(notice.role ?? Role.teacher)}',
                                      style: GoogleFonts.baloo2(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
