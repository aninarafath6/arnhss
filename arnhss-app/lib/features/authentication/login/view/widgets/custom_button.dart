import 'package:arnhss/features/authentication/login/view/widgets/input_box.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          height: 55,
          onPressed: () {},
          child: Row(
            children: const [
              Text(
                "+91",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        const Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.0),
          child:  VerticalDivider(),
        ),
        const InputBox(),
      ],
    );
  }
}
