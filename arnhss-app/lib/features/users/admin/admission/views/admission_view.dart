import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/admin/admission/widgets/course_card.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:remixicon/remixicon.dart';

class AdmissionView extends StatefulWidget {
  const AdmissionView({Key? key}) : super(key: key);
  static const String routeName = "/admin_dashboard";

  @override
  State<AdmissionView> createState() => _AdmissionViewState();
}

class _AdmissionViewState extends State<AdmissionView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AdmissionViewModel>().getCourses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Courses"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 10, vertical: 5),
        child: Consumer<AdmissionViewModel>(
          builder: (context, value, _) {
            return value.loading
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        const CourseCard(isSkelton: true),
                  )
                : value.courseCount == 0
                    ? const NotFound(
                        imageURL: "assets/images/icons/spot-workflow.png.webp",
                        title:
                            "Unfortunately, no courses have been found\nfor this time",
                      )
                    : ListView.builder(
                        itemCount: value.courseCount,
                        itemBuilder: (BuildContext context, index) {
                          Course course = value.courses[index];

                          return CourseCard(course: course);
                        },
                      );
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          context.read<AdmissionViewModel>().clearControllers();
          showCourseForm(
            context,
            onSubmit: () async {
              bool status =
                  await context.read<AdmissionViewModel>().addCourse();

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
