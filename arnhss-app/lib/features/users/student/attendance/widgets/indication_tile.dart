import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class IndicationTile extends StatelessWidget {
  const IndicationTile({
    Key? key,
    required this.label,
    required this.count,
  }) : super(key: key);

  final String label;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            label,
            style: CustomTextTheme(context: context)
                .headLine2()
                .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(15.5),
            decoration: BoxDecoration(
              color: CustomColors.bgOverlay,
              borderRadius: BorderRadius.circular(
                2,
              ),
            ),
            child: Center(
              child: Text(count.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
