import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({Key? key, required this.label, this.color})
      : super(key: key);
  final String? label;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      label: Text(
        label!,
        style: const TextStyle(fontSize: 12),
      ),
      // backgroundColor: ,
    );
  }
}
