import 'package:arnhss/common/constants/network_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectFromList extends StatelessWidget {
  SelectFromList({Key? key}) : super(key: key);
  static const routeName = "/select_fromList";
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(
        context,
        title: "Select a teacher",
        hintText: "Search a teacher...",
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
              physics: const PageScrollPhysics(),
              itemBuilder: (context, index) {
                // bool status =
                //     context.read<CountryViewModel>().selectedCountry.code ==
                //         snapshot.data![index].code;
                return ListTile(
                  onTap: () {
                    context.read<CountryViewModel>().setCountry(
                          snapshot.data![index],
                        );
                    Navigator.pop(context);
                  },
                  trailing: Text(
                    snapshot.data![index].dialCode,
                    style:
                        CustomTextTheme(context: context).paragraph().copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  title: Text(snapshot.data![index].name),
                  leading: Image.network(
                    "${NetworkConstants.baseFlagURL}${snapshot.data![index].code.toLowerCase()}.png",
                    errorBuilder: ((context, error, stackTrace) {
                      return Text(
                        snapshot.data?[index].code ?? "",
                      );
                    }),
                    width: 25,
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
          },
        ),
      ),
    );
  }
}
