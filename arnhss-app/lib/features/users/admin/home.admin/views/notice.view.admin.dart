import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/widgets/custom_loading.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/student/planner/widgets/floating_button.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
import 'package:arnhss/features/users/widget/add_notice_sheet.dart';
import 'package:arnhss/features/users/widget/notice_item.dart';
import 'package:flutter/cupertino.dart';

class NoticeView extends StatefulWidget {
  const NoticeView({Key? key}) : super(key: key);
  static const routeName = '/noticeView';

  @override
  State<NoticeView> createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  @override
  void initState() {
    // * get task of the day when widget's first build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NoticeViewModel>().getNotices();

      //... others are same
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("older notice build");

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: customAppBar(context, title: "Prev-Notices"),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<NoticeViewModel>(
                      builder: (context, value, child) {
                    // return SizedBox();
                    return Stack(
                      children: [
                        value.getLoading
                            ? const CustomLoading()
                            : const SizedBox(),
                        value.notices.isEmpty && value.getLoading != true
                            ? const SizedBox(
                                child: NotFound(
                                  imageURL: Images.noNotice,
                                  title:
                                      "At this time, there is no notice of any kind\navailable to you",
                                ),
                                width: double.infinity,
                              )
                            : const SizedBox(),
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            CupertinoSliverRefreshControl(
                              builder: (context,
                                  refreshState,
                                  pulledExtent,
                                  refreshTriggerPullDistance,
                                  refreshIndicatorExtent) {
                                return const SizedBox(height: .1);
                              },
                              // refreshTriggerPullDistance: 10,
                              // refreshIndicatorExtent: 10,
                              onRefresh: value.getNotices,
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                ((context, index) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    layoutBuilder: (child, _) {
                                      return child!;
                                    },
                                    child: Column(
                                      children: [
                                        NoticeItem(
                                          notice: value.notices[index],
                                          header: false,
                                          isExpanded: true,
                                        ),
                                        const SizedBox(height: 15)
                                      ],
                                    ),
                                  );
                                }),
                                childCount: value.notices.length,
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
            FloatingButton(
              onTap: () => showAddNotice(context),
            )
          ],
        ),
      ),
    );
  }
}