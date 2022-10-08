import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySelect extends StatelessWidget {
  CountrySelect({Key? key}) : super(key: key);
  static const routeName = "/country_selection";
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(
        context,
        type: Brightness.dark,
        onTap: () {
          if (context.read<CountryViewModel>().isSearching) {
            focusNode.unfocus();
            context.read<CountryViewModel>().toggleSearching();
          } else {
            Navigator.pop(context);
          }
        },
        searching: context.watch<CountryViewModel>().isSearching,
        focusNode: focusNode,
        onSearchTap: () {
          context.read<CountryViewModel>().toggleSearching();

          if (context.read<CountryViewModel>().isSearching) {
            focusNode.requestFocus();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: FutureBuilder<List<CountryModel>>(
            future: context.read<CountryViewModel>().result,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  bool status =
                      context.read<CountryViewModel>().selectedCountry.code ==
                          snapshot.data![index].code;
                  return ListTile(
                    onTap: () {
                      context.read<CountryViewModel>().setCountry(
                            snapshot.data![index],
                          );
                      Navigator.pop(context);
                    },
                    trailing: Text(
                      snapshot.data![index].dialCode,
                      style: CustomTextTheme(context: context)
                          .paragraph()
                          .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    title: Text(snapshot.data![index].name),
                    leading: Image.network(
                      "${Images.flag_base_url + snapshot.data![index].code.toLowerCase()}.png",
                      width: 25,
                      errorBuilder: ((context, error, stackTrace) {
                        return Text(snapshot.data![index].code);
                      }),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1.2,
                  );
                },
                itemCount: snapshot.data?.length ?? 0,
              );
            }),
      ),
    );
  }
}
