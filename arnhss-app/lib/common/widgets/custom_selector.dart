import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class CustomSelector extends StatelessWidget {
  const CustomSelector({
    Key? key,
    this.icon = Remix.calendar_line,
    this.onTap,
    this.date,
  }) : super(key: key);
  final IconData? icon;
  final Function()? onTap;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: CustomColors.bgOverlay,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon!),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomColors.light,
                      fontSize: 13,
                    ),
                  ),
                  // SizedBox(height: 2),
                  Text(
                    date ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.dark,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}