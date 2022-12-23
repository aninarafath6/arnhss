import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/common/widgets/student_tile.dart';
import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/models/student.model.dart';
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
        title: "Students",
        hintText: "Search a student...",
        type: Brightness.light,
        center: true,
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
                return StudentTile(
                  student: StudentModel(
                    phone: "sample phone",
                    id: "id",
                    name: "Anin Arafath",
                    gender: Gender.female,
                    dpURL: "https://aninarafath.me/images/about-1.jpeg",
                    email: "email",
                    lastLogin: DateTime.now(),
                    department: "Cs",
                    // reference: DocumentReference(),
                    admissionNo: index + 22000,
                    dob: DateTime.now(),
                    parentPhone: "parentPhone",
                    rollNumber: index + 1,
                    secondLanguage: "secondLanguage",
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: snapshot.data?.length ?? 0,
            );
          },
        ),
      ),
    );
  }
}
