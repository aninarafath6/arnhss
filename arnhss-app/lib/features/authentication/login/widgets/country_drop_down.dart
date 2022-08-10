import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: context.getHeight(90),
          width: context.getWidth(80),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: FutureBuilder<List<CountryModel>>(
            future: context.watch<CountryViewModel>().result,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 15, left: 20, right: 20),
                    child: TextField(
                      onChanged: context.read<CountryViewModel>().searchCountry,
                      cursorColor: CustomColors.dark,
                      style: Theme.of(context).textTheme.subtitle1,
                      decoration: const InputDecoration(
                        hintText: "Search you country code...",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.read<CountryViewModel>().setCountry(
                                    snapshot.data![index],
                                  );
                              Navigator.pop(context);
                            },
                            enableFeedback: true,
                            leading: Image.network(
                              "https://flagcdn.com/48x36/${snapshot.data![index].code.toLowerCase()}.png",
                              width: 30,
                            ),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].dialCode),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: snapshot.data?.length ?? 0,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
