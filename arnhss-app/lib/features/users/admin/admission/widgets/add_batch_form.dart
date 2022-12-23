import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/common/widgets/custom_selector.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:intl/intl.dart';

void showBatchForm(
  BuildContext context, {
  String title = "New Batch",
  String buttonTXT = "Add",
  required VoidCallback onSubmit,
  required Course course,
}) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      var _provider = context.watch<BatchViewModel>();
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
                  hintText: "Batch name",
                  size: Sizing.sm,
                  controller: context.read<BatchViewModel>().nameController,
                ),
                const SizedBox(height: 5),
                CustomInput(
                  hintText: "Batch code",
                  controller:
                      context.read<BatchViewModel>().batchCodeController,
                  size: Sizing.sm,
                ),
                const SizedBox(height: 5),

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
                                    firstDate:
                                        DateTime.utc(DateTime.now().year - 4),
                                    lastDate:
                                        DateTime.utc(DateTime.now().year + 4))
                                .then(
                              (value) {
                                context.read<BatchViewModel>().setStartDate =
                                    value ?? DateTime.now();
                                context
                                    .read<BatchViewModel>()
                                    .setUpForAdd(course);
                              },
                            );
                          },
                          content: formatter
                              .format(context
                                  .watch<BatchViewModel>()
                                  .startDateController)
                              .toString()),
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
                                    firstDate:
                                        DateTime.utc(DateTime.now().year - 4),
                                    lastDate:
                                        DateTime.utc(DateTime.now().year + 4))
                                .then(
                              (value) {
                                context.read<BatchViewModel>().setEndDate =
                                    value ?? DateTime.now();
                                context
                                    .read<BatchViewModel>()
                                    .setUpForAdd(course);
                              },
                            );
                          },
                          content: formatter
                              .format(context
                                  .watch<BatchViewModel>()
                                  .endDateController)
                              .toString()),
                    ),
                    // Expanded(
                    //   child:
                    // ),
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
