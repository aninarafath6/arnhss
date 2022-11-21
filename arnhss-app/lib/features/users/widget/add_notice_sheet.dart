import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:get/route_manager.dart';

void showAddNotice(BuildContext context) {
  context.read<PlannerViewModel>().initialDateSelectedInFor();
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
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

                const _FormHeader(),
                const SizedBox(height: 10),

                // Text(
                //   "Notice ",
                //   style: CustomTextTheme(context: context).headLine2(),
                // ),
                const SizedBox(height: 5),

                CustomInput(
                  hintText: "Write your notice ....",
                  size: Sizing.xl,
                  controller: context.read<NoticeViewModel>().noticeController,
                ),

                const SizedBox(height: 10),
                // const SizedBox(height: 15),
                CustomButton(
                  label: "Send ",
                  width: context.isMobile
                      ? context.getWidth(100)
                      : context.getWidth(50),
                  height: context.isMobile ? context.getHeight(8) : 60,
                  loading: context.watch<NoticeViewModel>().loading,
                  fontSize: context.isMobile ? 15 : 15,
                  onTap: (() {
                    context
                        .read<NoticeViewModel>()
                        .addNotice(
                          NoticeModel(
                            notice: context
                                .read<NoticeViewModel>()
                                .noticeController
                                .text,
                            role: context.read<UserViewModel>().user?.role,
                            useId: context.read<UserViewModel>().user?.id,
                            createdAt: DateTime.now(),
                          ),
                        )
                        .then((value) {
                      Get.back();
                      DialogHelper.showErrorDialog(
                        description: "The notice has been successfully added.",
                        top: false,
                        title: "Success ✅",
                      );
                    });
                  }),
                  // onTap: () => _provider.savePlan(context),
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

class _FormHeader extends StatelessWidget {
  const _FormHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel      ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: CustomColors.light),
            ),
          ),
        ),
        const Text(
          "New Notice",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: CustomColors.dark),
        ),
        const Text(
          "New Plan",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.transparent),
        ),
      ],
    );
  }
}

class OptionChipList extends StatefulWidget {
  const OptionChipList({
    Key? key,
    required this.options,
    required this.selectedBg,
    this.onSelect,
  }) : super(key: key);
  final List<String> options;
  final Color selectedBg;
  final Function(String)? onSelect;

  @override
  State<OptionChipList> createState() => _OptionChipListState();
}

class _OptionChipListState extends State<OptionChipList> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.options.length,
        (index) => Container(
          key: Key(widget.options[index]),
          margin: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            elevation: 0,
            pressElevation: 0,
            backgroundColor: CustomColors.bgOverlay,
            onSelected: (_) {
              setState(
                () {
                  selected = index;
                },
              );
              widget.onSelect!(widget.options[index]);
            },
            label: Text(widget.options[index]),
            selectedColor: widget.selectedBg,
            // avatar: const Icon(Remix.check_line),
            selected: index == selected,
          ),
        ),
      ),
    );
  }
}
