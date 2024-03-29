import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/dt_extension.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/features/users/admin/admission/views/course_view.dart';
import 'package:arnhss/features/users/admin/admission/views/student_list.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:remixicon/remixicon.dart';

enum Choice { delete, update }

class SingleBatchView extends StatefulWidget {
  const SingleBatchView({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/singleBatch";

  @override
  State<SingleBatchView> createState() => _SingleBatchViewState();
}

class _SingleBatchViewState extends State<SingleBatchView> {
  @override
  void initState() {
    var selectedBatch = context.read<BatchViewModel>().selectedBatch;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<StudentViewModel>()
          .getStudentsCountUnderBatch(selectedBatch);
      context.read<BatchViewModel>().checkStatus(selectedBatch);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Batch? watchBatch = context.watch<BatchViewModel>().selectedBatch;
    return Scaffold(
      appBar: customAppBar(
        context,
        title: watchBatch.name,
        // center: false,
        actions: [
          PopupMenuButton<Choice>(
            icon: const Icon(
              Remix.menu_5_line,
              color: Colors.black,
            ),
            enableFeedback: true,
            onSelected: (value) async {
              if (value == Choice.update) {
                context.read<BatchViewModel>().setUpToUpdate();
                context
                    .read<StudentViewModel>()
                    .getStudents(context.read<BatchViewModel>().selectedBatch);

                showBatchForm(
                  context,
                  title: "Edit Batch",
                  buttonTXT: "Update",
                  dc: context.read<AdmissionViewModel>().selectedCourse.d_code,
                  onSubmit: () async {
                    bool status =
                        await context.read<BatchViewModel>().update(watchBatch);
                    context.read<BatchViewModel>().setBatchLeader = null;
                    context.read<StudentViewModel>().clearStudents();

                    if (!status) {
                      HandleException().handleException(
                        InvalidException("Sorry, Batch not updated ", false),
                        top: true,
                      );
                    } else {
                      DialogHelper.showSnackBar(
                        title: "Success😊",
                        description: "Batch updated successfully ✔️",
                      );
                      Navigator.of(context).pop();
                    }
                  },
                );
              } else {
                bool status = false;
                await batchModal(
                  context,
                  content:
                      "If you agree to the deletion of this batch, can we proceed?",
                  title: "Delete Batch?",
                  deny: "DENY",
                  done:
                      "SURE".toText(style: const TextStyle(color: Colors.red)),
                  onDeny: () {
                    status = false;
                    Navigator.pop(context);
                  },
                  onDone: () {
                    status = true;
                    Navigator.pop(context);
                  },
                );

                if (status) {
                  context.read<BatchViewModel>().deleteBatch(watchBatch);
                  Navigator.pop(context);
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Choice.update,
                child: MenuChip(
                  name: "Edit Batch",
                  icon: Remix.edit_line,
                ),
              ),
              const PopupMenuItem(
                value: Choice.delete,
                child: MenuChip(
                  name: "Delete Batch",
                  icon: Remix.delete_bin_line,
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.default_padding,
          vertical: 5,
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 5.5,
              child: DetailCard(
                listData: [
                  DText(value: watchBatch.name, name: "Name"),
                  const Divider(),
                  DText(value: watchBatch.code.toString(), name: "Code"),
                  const Divider(),
                  DText(
                    value: watchBatch.teacher.name.capitalize,
                    name: "Teacher",
                  ),
                  const Divider(),
                  DText(
                    value: watchBatch.leader?.name ?? "NUll",
                    name: "Leader",
                  ),
                  const Divider(),
                  DText(
                    value: context
                        .watch<StudentViewModel>()
                        .studentsCount
                        .toString(),
                    name: "Total Students",
                  ),
                  const Divider(),
                  DText(
                    value: watchBatch.startDate
                        .dtFrm(e: "", d: "dd", m: " MMM ", y: "y"),
                    name: "Start Date",
                  ),
                  const Divider(),
                  DText(
                    value: watchBatch.endDate.dtFrm(
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
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 1,
                image: "assets/images/icons/planning-badge.png.webp",
                label: "Time Table",

                // onTap: () => Navigator.of(context).pushNamed(),
                count: 0,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 7,
              child: Tile(
                index: 0,
                image:
                    "assets/images/icons/oc-reading-book-removebg-preview.png",
                label: "Students",
                onTap: () =>
                    Navigator.of(context).pushNamed(StudentList.routeName),
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 4,
              child: Tile(
                index: 0,
                image: "assets/images/icons/nt-to-do-list-removebg-preview.png",
                label: "Attendance",
              ),
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
