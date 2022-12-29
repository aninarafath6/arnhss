import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/teacher_tile.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/teacher_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

class AddTeacherToCourseView extends StatefulWidget {
  const AddTeacherToCourseView({Key? key}) : super(key: key);
  static const routeName = "/add_teacher_to_course";

  @override
  State<AddTeacherToCourseView> createState() => _AddTeacherToCourseViewState();
}

class _AddTeacherToCourseViewState extends State<AddTeacherToCourseView> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TeacherViewModel>().getBalanceTeachers();
    });
    super.initState();
  }

  Set<TeacherModel> selectedTeachers = {};

  @override
  Widget build(BuildContext context) {
    var teacherProvider = context.watch<TeacherViewModel>();

    return Scaffold(
      appBar: customAppBar(context, title: "Add Teachers", actions: [
        selectedTeachers.isNotEmpty
            ? CircleAvatar(
                radius: 14,
                backgroundColor: CustomColors.absentColor.withOpacity(.2),
                child: Center(
                  child: Text(
                    selectedTeachers.length.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(
          width: 15,
        )
      ]),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: teacherProvider.allTeacherLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) => Shimmer.fromColors(
                            baseColor: CustomColors.bgOverlay,
                            highlightColor: CustomColors.light.withOpacity(.4),
                            child: const AccountTileSkelton(),
                          )),
                      itemCount: 30,
                    )
                  : teacherProvider.balanceTeachers.isNotEmpty
                      ? ListView.separated(
                          physics: const PageScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TeacherTile(
                              teacher: teacherProvider.balanceTeachers[index],
                              onTap: () {
                                setState(() {
                                  if (selectedTeachers.contains(
                                      teacherProvider.balanceTeachers[index])) {
                                    selectedTeachers.remove(
                                        teacherProvider.balanceTeachers[index]);
                                  } else {
                                    selectedTeachers.add(
                                        teacherProvider.balanceTeachers[index]);
                                  }
                                });
                              },
                              isSelected: selectedTeachers.contains(
                                  teacherProvider.balanceTeachers[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemCount: teacherProvider.balanceTeachers.length,
                        )
                      : Center(
                          child: NotFound(
                            imageURL: "assets/images/icons/map.png.webp",
                            isBig: false,
                            title:
                                "There is no Teachers found in  ${context.read<AdmissionViewModel>().selectedCourse.name} course",
                          ),
                        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(29.0),
            child: CustomButton(
              label: "ADD ",
              isDisabled: selectedTeachers.isEmpty,
              loading: teacherProvider.addTeacherLoading,
              onTap: () {
                if (context
                        .read<AdmissionViewModel>()
                        .selectedCourse
                        .reference !=
                    null) {
                  context.read<TeacherViewModel>().addTeacherToCourse(
                        selectedTeachers.toList(),
                        context
                            .read<AdmissionViewModel>()
                            .selectedCourse
                            .reference!,
                      );
                  Navigator.pop(context);
                }
              },
            ),
          )
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