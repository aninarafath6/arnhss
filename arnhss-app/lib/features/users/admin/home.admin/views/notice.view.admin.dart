import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/features/users/student/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/users/student/planner/widgets/add_plan_bottom_form.dart';
import 'package:arnhss/features/users/student/planner/widgets/date_timeline.dart';
import 'package:arnhss/features/users/student/planner/widgets/floating_button.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/features/users/student/planner/widgets/planner_app_bar.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
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
    debugPrint("Planner build");

    return Scaffold(
      appBar: customAppBar(context, title: "Notices"),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<NoticeViewModel>(
                      builder: (context, value, child) {
                    // return SizedBox();
                    return value.getLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : value.notices.isEmpty
                            ? const Center(child: NotFound())
                            : ListView.separated(
                                separatorBuilder: ((context, index) =>
                                    const SizedBox(height: 20)),
                                itemBuilder: (context, index) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    layoutBuilder: (child, _) {
                                      return child!;
                                    },
                                    child: NoticeItem(
                                      notice: value.notices[index],
                                      header: false,
                                      isExpanded: true,
                                    ),
                                  );
                                },
                                itemCount: value.notices.length,
                              );
                  }),
                ),
              ],
            ),
            FloatingButton(
              onTap: () => showAddPlanForm(context),
            )
          ],
        ),
      ),
    );
  }
}
