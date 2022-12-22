import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/admin/admission/widgets/batch_card.dart';
import 'package:arnhss/features/users/admin/admission/widgets/course_card.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:remixicon/remixicon.dart';

class BatchesView extends StatefulWidget {
  const BatchesView({Key? key, required this.selectedCourse}) : super(key: key);
  final Course selectedCourse;

  static const String routeName = "/batches";

  @override
  State<BatchesView> createState() => _BatchesViewState();
}

class _BatchesViewState extends State<BatchesView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BatchViewModel>().getBatches(widget.selectedCourse);
      context.read<AdmissionViewModel>().getTeachers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFilterApplied = context.watch<BatchViewModel>().filter;
    return Scaffold(
      appBar: customAppBar(context, title: "Batches", center: false, actions: [
        Center(
          child: Container(
            width: 100,
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: CustomColors.lightBgOverlay,
            child: TextButton(
              onPressed: () {
                // setState(() {
                //   filter = !filter;
                // });
                context.read<BatchViewModel>().toggleFilter;
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isFilterApplied
                          ? Remix.filter_line
                          : Remix.filter_off_line,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    AnimatedSwitcher(
                      key: ValueKey(isFilterApplied),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        isFilterApplied ? "Active" : "All",
                        style: CustomTextTheme(context: context)
                            .headLine2()
                            .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 10, vertical: 5),
        child: Consumer<BatchViewModel>(
          builder: (context, value, _) {
            return value.loading
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        const CourseCard(isSkelton: true),
                  )
                : value.batchCount == 0
                    ? const NotFound(
                        imageURL:
                            "assets/images/icons/sales-and-crm-badge.png.webp",
                        title:
                            "Unfortunately, no batches have been found\nfor this time",
                      )
                    : ListView.builder(
                        itemCount: value.batchCount,
                        itemBuilder: (BuildContext context, index) {
                          Batch batch = value.batches[index];

                          return BatchCard(batch: batch);
                        },
                      );
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          context.read<BatchViewModel>().clearControllers();
          context
              .read<BatchViewModel>()
              .setupToAdd(widget.selectedCourse.d_code);

          showBatchForm(
            context,
            dc: widget.selectedCourse.d_code,
            title: "New Batch",
            onSubmit: () async {
              bool status = await context
                  .read<BatchViewModel>()
                  .addBatch(widget.selectedCourse.id);

              if (!status) {
                // HandleException().handleException(
                //   InvalidException("Sorry, course not added ", false),
                //   top: true,
                // );
              } else {
                DialogHelper.showSnackBar(
                  title: "Success🤡",
                  description: "Course added successfully ✔️",
                );
                Navigator.of(context).pop();
              }
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CustomColors.dark,
          ),
          child: const Icon(Remix.add_fill, color: Colors.white),
        ),
      ),
    );
  }
}
