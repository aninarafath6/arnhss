import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/batch_card.dart';
import 'package:arnhss/features/users/admin/admission/widgets/course_card.dart';
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
    });
    super.initState();
  }

  bool filter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Batches", center: false, actions: [
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                filter != filter;
              });
            },
            child: Row(
              children: [
                Icon(filter ? Remix.filter_line : Remix.filter_off_line),
                Text(
                  "Active",
                  style: CustomTextTheme(context: context).headLine2().copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 30),
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
    );
  }
}
