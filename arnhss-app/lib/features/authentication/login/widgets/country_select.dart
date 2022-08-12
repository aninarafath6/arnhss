import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySelect extends StatelessWidget {
  CountrySelect({Key? key}) : super(key: key);
  static const routeName = "/country_selection";
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.dark,
        toolbarHeight: 80,
        leading: IconButton(
          splashRadius: 26,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (context.read<CountryViewModel>().isSearching) {
              focusNode.unfocus();
              context.read<CountryViewModel>().toggleSearching();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: context.watch<CountryViewModel>().isSearching
            ? TextField(
                focusNode: focusNode,
                onChanged: context.read<CountryViewModel>().searchCountry,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Search you country code...",
                    hintStyle: TextStyle(color: CustomColors.light)),
              )
            : const Text("Choose your country"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                context.read<CountryViewModel>().toggleSearching();

                if (context.read<CountryViewModel>().isSearching) {
                  focusNode.requestFocus();
                }
              },
              icon: const Icon(Icons.search_rounded),
              splashRadius: 26,
            ),
          )
        ],
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
