import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batch_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/add_batch_form.dart';
import 'package:arnhss/features/users/admin/admission/widgets/batch_card.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:remixicon/remixicon.dart';

class BatchView extends StatefulWidget {
  const BatchView({
    Key? key,
    required this.selectedCourse,
  }) : super(key: key);
  final Course selectedCourse;
  static const String routeName = "/batch_view";

  @override
  State<BatchView> createState() => _BatchViewState();
}

class _BatchViewState extends State<BatchView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BatchViewModel>().getBatches(widget.selectedCourse);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.selectedCourse.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.default_padding,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 10,
            vertical: 5,
          ),
          child: Consumer<BatchViewModel>(
            builder: (context, value, _) {
              return value.loading
                  ? ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          const BatchCard(isSkelton: true),
                    )
                  : value.batchCount == 0
                      ? NotFound(
                          imageURL:
                              "assets/images/icons/spot-workflow.png.webp",
                          title:
                              "Unfortunately, no batch have been found under the ${widget.selectedCourse.name} course for this time",
                        )
                      : ListView.builder(
                          itemCount: value.batchCount,
                          itemBuilder: (BuildContext context, index) {
                            Batch course = value.batches[index];

                            return BatchCard(batch: course);
                          },
                        );
            },
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          context.read<BatchViewModel>().clearControllers();
          showBatchForm(
            context,
            onSubmit: () async {
              bool status = await context
                  .read<BatchViewModel>()
                  .addBatch(widget.selectedCourse);

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
