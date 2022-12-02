import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';

void showAddCourse(BuildContext context) {
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

                const FormHeader(title: "New Course"),
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
                  label: "Add ",
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  fontSize: context.isMobile ? 15 : 15,
                  loading: _provider.getSetLoading,
                  onTap: (() async {
                    bool status =
                        await context.read<AdmissionViewModel>().addCourse();

                    if (!status) {
                      HandleException().handleException(
                        InvalidException("Sorry, course not added ", false),
                        top: true,
                      );
                    } else {
                      DialogHelper.showSnackBar(
                        title: "Success🤡",
                        description: "Course added successfully ✔️",
                      );
                    }

                    Navigator.of(context).pop();
                  }),
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
