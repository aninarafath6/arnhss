import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/common/widgets/custom_selector.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:remixicon/remixicon.dart';

void showAddPlanForm(BuildContext context) {
  PlannerViewModel _provider = context.read<PlannerViewModel>();

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
                OptionChipList(
                  options: const ["#home-work", "#exam", "#p-plan"],
                  onSelect: (value) {
                    _provider.planType = value;
                  },
                  selectedBg: CustomColors.halfColor.withOpacity(.2),
                ),
                const SizedBox(height: 5),
                Text(
                  "Title",
                  style: CustomTextTheme(context: context).headLine2(),
                ),
                const SizedBox(height: 5),

                CustomInput(
                  hintText: "Task title",
                  controller: _provider.titleController,
                ),
                Text("Note",
                    style: CustomTextTheme(context: context).headLine2()),
                const SizedBox(height: 8),

                CustomInput(
                  hintText: "Enter your note",
                  large: true,
                  controller: _provider.descriptionController,
                ),
                Text("Date & Time",
                    style: CustomTextTheme(context: context).headLine2()),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: CustomSelector(
                        label: 'Select Date',
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: context
                                      .read<PlannerViewModel>()
                                      .selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.utc(DateTime.now().year + 2))
                              .then(
                            (value) {
                              _provider.date = value;
                            },
                          );
                        },
                        content: context
                                .watch<PlannerViewModel>()
                                .date
                                .day
                                .toString() +
                            " " +
                            monthName[
                                context.watch<PlannerViewModel>().date.month -
                                    1] +
                            " " +
                            context
                                .watch<PlannerViewModel>()
                                .date
                                .year
                                .toString(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomSelector(
                        label: 'Remind on',
                        content: context
                            .watch<PlannerViewModel>()
                            .time
                            .format(context),
                        icon: Remix.time_line,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) => _provider.setTime = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 5),

                Text("Subject",
                    style: CustomTextTheme(context: context).headLine2()),
                OptionChipList(
                  options: const [
                    "#maths",
                    "#physics",
                    "#cs",
                    "#english",
                    "#malayalam",
                    "#chemistry"
                  ],
                  selectedBg: CustomColors.halfColor.withOpacity(.2),
                  onSelect: (value) {
                    _provider.subject = value;
                  },
                ),

                const SizedBox(height: 10),
                // const SizedBox(height: 15),
                CustomButton(
                  label: "Save",
                  onTap: () => _provider.savePlan(context),
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
          "New Plan",
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
