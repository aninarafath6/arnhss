import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.options,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  final IconData leadingIcon;
  final List<T> options;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState<T> extends State<CustomDropDown> {
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
            value: dropDownValue,
            underline: const SizedBox(),
            enableFeedback: true,
            isDense: false,
            items: widget.options
                .map((e) => DropdownMenuItem<T>(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
            onChanged: (T? value) {
              setState(() {
                dropDownValue = value;
              });
            }),
      ),
    );
    // return Container(
    //   width: context.getWidth(100),
    //   height: 55,
    //   decoration: BoxDecoration(
    //       color: CustomColors.lightBgOverlay,
    //       borderRadius: BorderRadius.circular(8)),
    //   child: ListTile(
    //     onTap: onTap,
    //     title: Text(
    //       title,
    //       style: CustomTextTheme(context: context).headLine2().copyWith(
    //             fontWeight: FontWeight.w400,
    //             fontSize: context.getHeight(1.6),
    //           ),
    //     ),
    //     leading: Icon(
    //       leadingIcon,
    //     ),
    //   ),
    // );
  }
}
