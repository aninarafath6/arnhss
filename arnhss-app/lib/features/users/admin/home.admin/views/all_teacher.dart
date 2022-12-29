import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/teacher_tile.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/teacher_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

class AllTeacherListView extends StatefulWidget {
  const AllTeacherListView({Key? key}) : super(key: key);
  static const routeName = "/all_teacher_list";

  @override
  State<AllTeacherListView> createState() => _AllTeacherListViewState();
}

class _AllTeacherListViewState extends State<AllTeacherListView> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TeacherViewModel>().getAllTeachers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var teacherProvider = context.watch<TeacherViewModel>();
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "All Teachers",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: teacherProvider.allTeacherLoading
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => Shimmer.fromColors(
                      baseColor: CustomColors.bgOverlay,
                      highlightColor: CustomColors.light.withOpacity(.4),
                      child: const AccountTileSkelton(),
                    )),
                itemCount: 20,
              )
            : teacherProvider.allTeachers.isNotEmpty
                ? ListView.separated(
                    physics: const PageScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TeacherTile(
                        teacher: teacherProvider.allTeachers[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: teacherProvider.allTeachers.length,
                  )
                : const Center(
                    child: NotFound(
                      imageURL: "assets/images/icons/map.png.webp",
                      isBig: false,
                      title: "This school has not teachers.🙄",
                    ),
                  ),
      ),
      floatingActionButton: Row(
        children: [
          const Spacer(),
          TextButton(
            onPressed: () {
              showTeacherAddForm(
                context,
                onSubmit: () async {
                  bool status =
                      await context.read<TeacherViewModel>().addTeacher();

                  if (status) {
                    DialogHelper.showSnackBar(
                      title: "Success🤡",
                      description: "Successfully added a student ✔️",
                    );
                    Navigator.of(context).pop();
                  }
                },
              );
              // showTeacherAddForm(
              //   context,
              //   onSubmit: () async {
              //     bool status = await context
              //         .read<StudentViewModel>()
              //         .addStudent(
              //             courseName: context
              //                 .read<AdmissionViewModel>()
              //                 .selectedCourse
              //                 .name,
              //             batch: context.read<BatchViewModel>().selectedBatch);

              //     if (!status) {
              //       // HandleException().handleException(
              //       //   InvalidException("Sorry, course not added ", false),
              //       //   top: true,
              //       // );
              //     } else {
              //       DialogHelper.showSnackBar(
              //         title: "Success🤡",
              //         description: "Successfully added a student ✔️",
              //       );
              //       Navigator.of(context).pop();
              //     }
              //   },
              //   dc: '',
              // );
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