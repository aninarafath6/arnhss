import 'dart:io';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/custom_drop_down.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/common/widgets/custom_selector.dart';
import 'package:arnhss/extensions/dt_extension.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/subject_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/teacher_view_model.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/models/teacher.model.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remixicon/remixicon.dart';

void showCourseForm(
  BuildContext context, {
  String title = "New Course",
  String buttonTXT = "Add",
  required VoidCallback onSubmit,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      var _provider = context.watch<AdmissionViewModel>();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // height: context.getHeight(65),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                        color: CustomColors.bgOverlay,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 10),

                FormHeader(title: title),
                const SizedBox(height: 10),

                CustomInput(
                  hintText: "Course name",
                  size: Sizing.sm,
                  controller: context.read<AdmissionViewModel>().nameController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Course code",
                  controller:
                      context.read<AdmissionViewModel>().courseCodeController,
                  size: Sizing.sm,
                ),
                const SizedBox(height: 5),

                CustomInput(
                  hintText: "Display code",
                  controller:
                      context.read<AdmissionViewModel>().displayCodeController,
                  size: Sizing.sm,
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 10),

                // const SizedBox(height: 15),
                CustomButton(
                  label: buttonTXT,
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  fontSize: context.isMobile ? 15 : 15,
                  loading: _provider.getSetLoading,
                  onTap: onSubmit,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: CustomColors.light),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: CustomColors.dark),
            ),
          ),
        ),
      ],
    );
  }
}

void showBatchForm(
  BuildContext context, {
  String title = "New Batch",
  String buttonTXT = "Add",
  required VoidCallback onSubmit,
  required String dc,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      var _provider = context.watch<BatchViewModel>();
      context.watch<BatchViewModel>();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // height: context.getHeight(65),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                        color: CustomColors.bgOverlay,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 10),

                FormHeader(title: title),
                const SizedBox(height: 10),

                CustomInput(
                  hintText: "Name",
                  size: Sizing.sm,
                  controller: context.read<BatchViewModel>().nameController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Code",
                  controller:
                      context.read<BatchViewModel>().batchCodeController,
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 5),
                Consumer<BatchViewModel>(builder: (context, provider, child) {
                  return TeacherDropdown(
                    title: "Select batch teacher",
                    leadingIcon: Remix.arrow_down_s_line,
                    options: context.watch<TeacherViewModel>().teachers,
                    value: provider.teacher,
                    changed: (TeacherModel teacher) {
                      provider.setBatchTeacher = teacher;
                    },
                  );
                }),
                const SizedBox(height: 15),

                Consumer<BatchViewModel>(builder: (context, provider, child) {
                  return StudentDropdown(
                    title: "Select class leader",
                    leadingIcon: Remix.arrow_down_s_line,
                    options: context.watch<StudentViewModel>().students,
                    value: provider.leader,
                    changed: (StudentModel leader) {
                      provider.setBatchLeader = leader;
                    },
                  );
                }),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomSelector(
                        label: 'Start Date',
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: context
                                .read<BatchViewModel>()
                                .startDateController,
                            firstDate: DateTime.utc(DateTime.now().year - 4),
                            lastDate: DateTime.utc(DateTime.now().year + 4),
                          ).then(
                            (value) {
                              _provider.setStartDate = value ?? DateTime.now();
                              context.read<BatchViewModel>().setupToAdd(dc);
                            },
                          );
                        },
                        content: context
                            .watch<BatchViewModel>()
                            .startDateController
                            .dtFrm(e: "", d: "dd ", m: "MMM", y: " y"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomSelector(
                        label: 'End Date',
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: context
                                .read<BatchViewModel>()
                                .endDateController,
                            firstDate: DateTime.utc(DateTime.now().year - 4),
                            lastDate: DateTime.utc(DateTime.now().year + 4),
                          ).then(
                            (value) {
                              _provider.setEndDate = value ?? DateTime.now();
                              context.read<BatchViewModel>().setupToAdd(dc);
                            },
                          );
                        },
                        content: context
                            .watch<BatchViewModel>()
                            .endDateController
                            .dtFrm(e: "", d: "dd ", m: "MMM", y: " y"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 10),

                // const SizedBox(height: 15),
                CustomButton(
                  label: buttonTXT,
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  fontSize: context.isMobile ? 15 : 15,
                  loading: _provider.loading,
                  onTap: onSubmit,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

void showStudentAddForm(
  BuildContext context, {
  String title = "Add Student",
  String buttonTXT = "Add",
  required VoidCallback onSubmit,
  required String dc,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      var _readProvider = context.read<StudentViewModel>();
      var _provider = context.watch<StudentViewModel>();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // height: context.getHeight(65),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                        color: CustomColors.bgOverlay,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 10),

                FormHeader(title: title),
                const SizedBox(height: 10),

                CustomInput(
                  hintText: "Name",
                  size: Sizing.sm,
                  controller: _readProvider.nameController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Email",
                  size: Sizing.sm,
                  keyboardType: TextInputType.emailAddress,
                  controller: _readProvider.emailController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Phone Number",
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                  controller: _readProvider.phoneController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Parent's Phone Number",
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                  controller: _readProvider.parentPhoneController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Roll Number",
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                  controller: _readProvider.rollNoController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Admission Number",
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                  controller: _readProvider.admissionNoController,
                ),
                const SizedBox(height: 5),
                EnumDropDown<Gender>(
                  title: "Gender",
                  leadingIcon: Remix.arrow_down_s_line,
                  options: const [
                    Gender.female,
                    Gender.male,
                    Gender.other,
                  ],
                  changed: (gender) {
                    _readProvider.gender = gender;
                  },
                ),
                const SizedBox(height: 10),
                StringDropDown(
                  title: "Second Language",
                  leadingIcon: Remix.arrow_down_s_line,
                  options: const ["Malayalam", "Arabic"],
                  changed: (secLang) {
                    _readProvider.secondLang = secLang;
                  },
                ),
                const SizedBox(height: 10),
                CustomSelector(
                  label: 'Date Of Birth',
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.utc(DateTime.now().year - 10),
                      firstDate: DateTime.utc(DateTime.now().year - 20),
                      lastDate: DateTime.utc(DateTime.now().year - 10),
                    ).then(
                      (value) {
                        _provider.setDob = value ?? DateTime.now();
                        // context.read<BatchViewModel>().setupToAdd(dc);
                      },
                    );
                  },
                  content: _provider.dob != null
                      ? _provider.dob?.dtFrm(e: "", d: "dd ", m: "MMM", y: " y")
                      : "Select your Date of birth",
                ),
                const SizedBox(height: 10),

                CustomSelector(
                  label: 'Profile Photo',
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      File f = File(image.path);
                      _readProvider.setDp = f;
                    } else {
                      DialogHelper.showSnackBar(
                        title: "Oh,🤨",
                        description: "Profile photo is not selected...",
                        top: true,
                      );
                    }
                  },
                  icon: Remix.image_2_line,
                  imagePath: _provider.dp,
                  content: _provider.dp == null
                      ? "Please select student dp"
                      : _provider.dp?.path.split("/").last,
                ),
                const SizedBox(height: 15),

                // Image.file(),
                const SizedBox(height: 10),

                // const SizedBox(height: 15),
                CustomButton(
                  label: buttonTXT,
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  fontSize: context.isMobile ? 15 : 15,
                  loading: _provider.addStudentLoading,
                  onTap: onSubmit,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

void showTeacherAddForm(
  BuildContext context, {
  String title = "Add Teacher",
  String buttonTXT = "Add",
  required VoidCallback onSubmit,
  // required String dc,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      var _readProvider = context.read<TeacherViewModel>();
      var _provider = context.watch<TeacherViewModel>();
      context.watch<TeacherViewModel>().getAllSubject();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // height: context.getHeight(65),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                        color: CustomColors.bgOverlay,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 10),

                FormHeader(title: title),
                const SizedBox(height: 10),

                CustomInput(
                  hintText: "Name",
                  size: Sizing.sm,
                  controller: _readProvider.nameController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Email",
                  size: Sizing.sm,
                  keyboardType: TextInputType.emailAddress,
                  controller: _readProvider.emailController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Phone Number",
                  size: Sizing.sm,
                  keyboardType: TextInputType.number,
                  controller: _readProvider.phoneController,
                ),
                const SizedBox(height: 5),
                EnumDropDown<Gender>(
                  title: "Gender",
                  leadingIcon: Remix.arrow_down_s_line,
                  options: const [
                    Gender.female,
                    Gender.male,
                    Gender.other,
                  ],
                  changed: (gender) {
                    _readProvider.gender = gender;
                  },
                ),
                const SizedBox(height: 10),
                Consumer<TeacherViewModel>(builder: (context, provider, child) {
                  return SubjectDropDown(
                    title: "Select subject",
                    leadingIcon: Remix.arrow_down_s_line,
                    options: context.watch<TeacherViewModel>().allSubjects,
                    value: provider.subject,
                    changed: (SubjectModel subject) {
                      provider.setSubject = subject;
                    },
                  );
                }),
                const SizedBox(height: 10),

                CustomSelector(
                  label: 'Profile Photo',
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      File f = File(image.path);
                      _readProvider.setDp = f;
                    } else {
                      DialogHelper.showSnackBar(
                        title: "Oh,🤨",
                        description: "Profile photo is not selected...",
                        top: true,
                      );
                    }
                  },
                  icon: Remix.image_2_line,
                  imagePath: _provider.dp,
                  content: _provider.dp == null
                      ? "Please select teacher dp"
                      : _provider.dp?.path.split("/").last,
                ),
                const SizedBox(height: 15),

                // Image.file(),
                const SizedBox(height: 10),

                // const SizedBox(height: 15),
                CustomButton(
                  label: buttonTXT,
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  fontSize: context.isMobile ? 15 : 15,
                  loading: _provider.addTeacherLoading,
                  onTap: onSubmit,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }),
  );
}
