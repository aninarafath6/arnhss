import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryInput extends StatelessWidget {
  const CountryInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30.0, bottom: 15, left: 20, right: 20),
      child: TextField(
        onChanged: context.read<CountryViewModel>().searchCountry,
        cursorColor: CustomColors.dark,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: const InputDecoration(
          hintText: "Search you country code...",
        ),
      ),
    );
  }
}
