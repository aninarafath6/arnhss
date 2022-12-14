import 'dart:developer';
import 'dart:ui';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

class NoticeItem extends StatefulWidget {
  const NoticeItem({
    Key? key,
    this.role,
    required this.notice,
    this.header = true,
    this.isExpanded = false,
  }) : super(key: key);
  final Role? role;
  final NoticeModel? notice;
  final bool header;
  final bool isExpanded;

  @override
  State<NoticeItem> createState() => _NoticeItemState();
}

class _NoticeItemState extends State<NoticeItem>
    with SingleTickerProviderStateMixin {
  //* for animations
  static const double _initialHeight = 190;
  static const double _expandedHeight = 500;
  double height = _initialHeight;
  bool _isExpanded = false;

  late AnimationController _animationController;
  final DateFormat formatter = DateFormat('EE, dd MMM');

  @override
  void initState() {
    context.read<NoticeViewModel>().noticeController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final loading = context.watch<NoticeViewModel>().loading;
    updateStatus(bool status) async {
      await Future.delayed(const Duration(milliseconds: 800));
      // Before calling setState check if the state is mounted.
      if (mounted) {
        setState(() => _isExpanded = status);
      }
    }

    if (widget.notice == null) {
      updateStatus(false);
      height = _initialHeight;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Consumer<NoticeViewModel>(builder: (context, value, _) {
        return InkWell(
          onTap: () {
            setState(() {
              if (height == _expandedHeight) {
                updateStatus(false);
                height = _initialHeight;
                _animationController.duration =
                    const Duration(milliseconds: 1000);
                _animationController.reverse();
              } else {
                if (widget.notice != null) {
                  updateStatus(true);
                }
                _animationController.forward();
                height = _expandedHeight;
              }
            });
          },

          //* delete a notice
          //* only notice can delete admin's
          onLongPress: () {
            if (widget.notice != null) {
              if (widget.role == Role.admin || widget.role == Role.principle) {
                noticeModal(
                  context,
                  title: "Delete Notice?",
                  content:
                      "If you agree to the deletion of this notice, can we proceed?",
                  deny: "DENY",
                  onDeny: () => Navigator.pop(context),
                  done:
                      "SURE".toText(style: const TextStyle(color: Colors.red)),
                  onDone: () async {
                    await context.read<NoticeViewModel>().deleteNotice(
                      () async {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
                log("let me delete");
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1400),
            curve: const ElasticInOutCurve(.8),
            width: context.getWidth(100) - 41,
            height: widget.notice?.notice == "" || widget.notice == null
                ? _initialHeight
                : height,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: CustomColors.lightBgOverlay,
              borderRadius: BorderRadius.circular(5),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Column(
                key: ValueKey(widget.notice?.id),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  widget.header
                      ? Row(
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
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  widget.notice?.notice == "" || widget.notice == null
                      ? Center(
                          child: Image.asset(
                           Images.noNotice,
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
                                            widget.notice?.notice ?? "",
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        formatter
                                            .format(DateTime.now())
                                            .toString(),
                                        style: GoogleFonts.breeSerif(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          // fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        '- ${UserModel.toStringRole(widget.notice?.role ?? Role.teacher)}',
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
        );
      }),
    );
  }
}
