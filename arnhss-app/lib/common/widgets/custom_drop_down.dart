import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:flutter/foundation.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
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
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
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
                      child: Text(describeEnum(e.toString()).capitalize()),
                      value: e,
                    ))
                .toList(),
            onChanged: (T? value) {
              setState(() {
                dropDownValue = value;
              });
              widget.changed(dropDownValue);
            }),
      ),
    );
  }
}
