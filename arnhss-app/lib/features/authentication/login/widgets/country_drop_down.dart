import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/country_input.dart';
import 'package:arnhss/features/authentication/login/widgets/country_list.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Material(
          color: Colors.transparent,
          child: Center(
            child: FutureBuilder<List<CountryModel>>(
              future: context.watch<CountryViewModel>().result,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                return Container(
                  height: context.getHeight(snapshot.data!.isEmpty ? 20 : 90),
                  width: context.getWidth(80),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Column(
                    children: [
                      const CountryInput(),
                      Expanded(
                        child: CountryList(snapshot: snapshot),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
