import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:flutter/foundation.dart';

class EnumDropDown<T> extends StatefulWidget {
  const EnumDropDown({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.options,
    this.value,
    required this.changed,
    // this.onTap,
  }) : super(key: key);
  final String title;
  // final Function()? onTap;
  final IconData leadingIcon;
  final List<T> options;
  final Function(dynamic) changed;
  final T? value;

  @override
  State<EnumDropDown> createState() => _EnumDropDownState();
}

class _EnumDropDownState<T> extends State<EnumDropDown<T>> {
  T? dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      padding: const EdgeInsets.all(12),
      height: context.isMobile ? 55 : 50,
      decoration: BoxDecoration(
          color: CustomColors.lightBgOverlay,
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: DropdownButton<T>(
            hint: Text(widget.title),
            isExpanded: true,
            value: widget.value ?? dropDownValue,
            underline: const SizedBox(),
            enableFeedback: true,
            isDense: false,
            items: widget.options
                .map((e) => DropdownMenuItem<T>(
                      child: Text(describeEnum(e.toString()).capitalize),
                      value: e,
                    ))
                .toList(),
            onChanged: (T? value) {
              setState(() {
                dropDownValue = value;
                widget.changed(dropDownValue);
              });
            }),
      ),
    );
  }
}

class TeacherDropdown extends StatefulWidget {
  const TeacherDropdown({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.options,
    this.value,
    required this.changed,
    // this.onTap,
  }) : super(key: key);
  final String title;
  // final Function()? onTap;
  final IconData leadingIcon;
  final List<TeacherModel> options;
  final Function(TeacherModel) changed;
  final TeacherModel? value;

  @override
  State<TeacherDropdown> createState() => _TeacherDropdownState();
}

class _TeacherDropdownState<T> extends State<TeacherDropdown> {
  String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      padding: const EdgeInsets.all(12),
      height: context.isMobile ? 55 : 50,
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DropdownButton<String>(
          hint: Text(widget.title),
          isExpanded: true,
          value: widget.value?.id ?? dropDownValue,
          underline: const SizedBox(),
          enableFeedback: true,
          isDense: false,
          items: widget.options
              .map(
                (e) => DropdownMenuItem<String>(
                  child: Text(e.name.toString()),
                  value: e.id,
                ),
              )
              .toList(),
          onChanged: (String? value) {
            setState(() {
              dropDownValue = value;
              widget.changed(
                  widget.options.firstWhere((element) => element.id == value));
            });
          },
        ),
      ),
    );
  }
}
