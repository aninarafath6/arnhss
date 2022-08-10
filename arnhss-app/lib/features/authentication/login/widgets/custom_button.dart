import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/country_drop_down.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => CustomColors.dark.withOpacity(.1)),
            ),
            onPressed: () {
              context.read<CountryViewModel>().updateDropDown(true);
              showDialog(
                context: context,
                builder: (context) {
                  return const CountryDropDown();
                },
              ).then((value) =>
                  context.read<CountryViewModel>().updateDropDown(false));
            },
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  context.watch<CountryViewModel>().selectedCountry.dialCode,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: CustomColors.dark),
                ),
                const Icon(Icons.arrow_drop_down, color: CustomColors.dark)
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: VerticalDivider(),
        ),
        const InputBox(),
      ],
    );
  }
}
