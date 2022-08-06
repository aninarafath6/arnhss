import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      " is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout",
      style: TextStyle(
        color: Colors.grey.withOpacity(.8),
        fontSize: context.getHeight(1.7),
        fontWeight: FontWeight.normal,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }
}
