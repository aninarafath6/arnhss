import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/network_constants.dart';
import 'package:arnhss/features/authentication/login/widgets/country_select.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintText,
  }) : super(key: key);
  final String hintText;

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
              // ).then((value) =>
              //     context.read<CountryViewModel>().updateDropDown(false));
              Navigator.pushNamed(context, CountrySelect.routeName);
            },
            child: Row(
              children: [
                Text(
                  context.watch<CountryViewModel>().selectedCountry.dialCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.dark,
                  ),
                ),
                const SizedBox(width: 2),
                Image.network(
                  "${NetworkConstants.baseFlagURL}${context.watch<CountryViewModel>().selectedCountry.code.toLowerCase()}.png",
                  errorBuilder: ((context, error, stackTrace) {
                    return Text(
                      context.watch<CountryViewModel>().selectedCountry.code,
                    );
                  }),
                  width: 15,
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
        InputBox(hintText: hintText),
      ],
    );
  }
}
