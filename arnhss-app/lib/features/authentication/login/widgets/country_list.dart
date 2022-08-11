import 'package:arnhss/features/authentication/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryList extends StatelessWidget {
  const CountryList({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot<List<CountryModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
