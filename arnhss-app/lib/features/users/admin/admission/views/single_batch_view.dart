import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/extensions/dt_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:remixicon/remixicon.dart';

class SingleBatchView extends StatefulWidget {
  const SingleBatchView({
    Key? key,
    required this.selectedBatch,
  }) : super(key: key);
  final Batch selectedBatch;
  static const String routeName = "/";

  @override
  State<SingleBatchView> createState() => _SingleBatchViewState();
}

class _SingleBatchViewState extends State<SingleBatchView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BatchViewModel>().checkStatus(widget.selectedBatch);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: widget.selectedBatch.name,
        // center: false,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position:
                    const RelativeRect.fromLTRB(double.infinity, 10, 10, 0),
                items: [
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        // context
                        //     .read<AdmissionViewModel>()
                        //     .setUpToUpdate(widget.selectedBatch);
                        // showCourseForm(
                        //   context,
                        //   title: "Edit Course",
                        //   buttonTXT: "Update",
                        //   onSubmit: () async {
                        //     bool status = await context
                        //         .read<AdmissionViewModel>()
                        //         .update(widget.selectedBatch);

                        //     if (!status) {
                        //       HandleException().handleException(
                        //         InvalidException(
                        //             "Sorry, course not updated ", false),
                        //         top: true,
                        //       );
                        //     } else {
                        //       DialogHelper.showSnackBar(
                        //         title: "Success😊",
                        //         description: "Course updated successfully ✔️",
                        //       );
                        //       Navigator.of(context).pop();
                        //     }
                        //   },
                        // );
                      },
                      child: Row(
                        children: const [
                          Icon(Remix.edit_line),
                          SizedBox(width: 15),
                          Text("Edit Course"),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Material(
                      child: GestureDetector(
                        onTap: () async {
                          // bool status = false;
                          // await courseModal(
                          //   context,
                          //   content:
                          //       "If you agree to the deletion of this course, can we proceed?",
                          //   title: "Delete Course?",
                          //   deny: "DENY",
                          //   done: "SURE".toText(
                          //       style: const TextStyle(color: Colors.red)),
                          //   onDeny: () {
                          //     status = false;
                          //     Navigator.pop(context);
                          //   },
                          //   onDone: () {
                          //     status = true;
                          //     Navigator.pop(context);
                          //   },
                          // );

                          // if (status) {
                          //   context
                          //       .read<AdmissionViewModel>()
                          //       .deleteCourse(widget.selectedCourse);
                          //   Navigator.pop(context);
                          //   Navigator.pop(context);
                          // } else {
                          //   Navigator.pop(context);
                          // }
                        },
                        child: Row(
                          children: const [
                            Icon(Remix.delete_bin_line),
                            SizedBox(width: 15),
                            Text("Delete Course"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            splashRadius: 20,
            icon: const Icon(
              Remix.menu_5_line,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.default_padding,
          vertical: 5,
        ),
        child: Column(
          children: [
            DetailCard(
              listData: [
                DText(value: widget.selectedBatch.name, name: "Name"),
                const Divider(),
                DText(value: widget.selectedBatch.code, name: "Code"),
                const Divider(),
                DText(
                  value: widget.selectedBatch.startDate
                      .dtFrm(e: "", d: "dd", m: " MMM ", y: "y"),
                  name: "Start Date",
                ),
                const Divider(),
                DText(
                  value: widget.selectedBatch.endDate.dtFrm(
                    e: "",
                    m: " MMM ",
                    d: "dd",
                    y: "y",
                  ),
                  name: "End Date",
                ),
                const Divider(),
                DText(
                  value: context.watch<BatchViewModel>().isActive
                      ? "ACTIVE"
                      : "NOT ACTIVE",
                  name: "Status",
                  style: TextStyle(
                    color: context.watch<BatchViewModel>().isActive
                        ? CustomColors.presentColor
                        : CustomColors.absentColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
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

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List<Widget> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listData,
      ),
    );
  }
}

class DText extends StatelessWidget {
  const DText({
    Key? key,
    required this.value,
    required this.name,
    this.style = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  }) : super(key: key);

  final String value;
  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          maxLines: 3,
          style: CustomTextTheme(context: context).headLine().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
        ),
        const Spacer(),
        AnimatedSwitcher(
          key: ValueKey(value),
          duration: const Duration(milliseconds: 800),
          child: Text(
            value,
            key: UniqueKey(),
            maxLines: 3,
            style: style,
          ),
        ),
      ],
    );
  }
}
