import 'package:arnhss/features/authentication/login/widgets/country_input.dart';
import 'package:arnhss/features/authentication/login/widgets/country_list.dart';
import 'package:arnhss/features/authentication/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<CountryModel>>(
          future: context.watch<CountryViewModel>().result,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            return Column(
              children: [
                const CountryInput(),
                Expanded(
                  child: CountryList(snapshot: snapshot),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
