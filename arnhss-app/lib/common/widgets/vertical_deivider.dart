import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: 1,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
