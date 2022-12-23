import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/common/widgets/student_tile.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/add_batch_form.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

class SelectFromList extends StatefulWidget {
  const SelectFromList({Key? key}) : super(key: key);
  static const routeName = "/select_fromList";

  @override
  State<SelectFromList> createState() => _SelectFromListState();
}

class _SelectFromListState extends State<SelectFromList> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<StudentViewModel>()
          .getStudents(context.read<BatchViewModel>().selectedBatch);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var studentProvider = context.watch<StudentViewModel>();
    return Scaffold(
      appBar: customAppBar(context, title: "Students"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: studentProvider.loading
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => Shimmer.fromColors(
                      baseColor: CustomColors.bgOverlay,
                      highlightColor: CustomColors.light.withOpacity(.4),
                      child: const AccountTileSkelton(),
                    )),
                itemCount: 20,
              )
            : studentProvider.students.isNotEmpty
                ? ListView.separated(
                    physics: const PageScrollPhysics(),
                    itemBuilder: (context, index) {
                      return StudentTile(
                        student: studentProvider.students[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: studentProvider.students.length,
                  )
                : Center(
                    child: NotFound(
                      imageURL: "assets/images/icons/map.png.webp",
                      isBig: false,
                      title:
                          "There is no students for ${context.read<AdmissionViewModel>().selectedCourse.name} in ${context.read<BatchViewModel>().selectedBatch.name} batch",
                    ),
                  ),
      ),
      floatingActionButton: Row(
        children: [
          const Spacer(),
          TextButton(
            onPressed: () {
              showStudentAddForm(
                context,
                onSubmit: () {},
                dc: '',
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
          Tooltip(
            message: "import students from csv",
            child: TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors.dark,
                ),
                child: const Icon(Remix.download_cloud_2_line,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// StudentModel(
//                 phone: "sample phone",
//                 id: "id",
//                 name: "Anin Arafath",
//                 gender: Gender.female,
//                 dpURL: "https://aninarafath.me/images/about-1.jpeg",
//                 email: "email",
//                 lastLogin: DateTime.now(),
//                 department: "Cs",
//                 // reference: DocumentReference(),
//                 admissionNo: index + 22000,
//                 dob: DateTime.now(),
//                 parentPhone: "parentPhone",
//                 rollNumber: index + 1,
//                 secondLanguage: "secondLanguage",
//               ),
//             );