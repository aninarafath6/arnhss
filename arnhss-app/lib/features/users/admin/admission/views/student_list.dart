import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/common/widgets/student_tile.dart';
import 'package:arnhss/features/authentication/account/widgets/account_tile_skelton.dart';
import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectFromList extends StatefulWidget {
  SelectFromList({Key? key}) : super(key: key);
  static const routeName = "/select_fromList";

  @override
  State<SelectFromList> createState() => _SelectFromListState();
}

class _SelectFromListState extends State<SelectFromList> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<StudentViewModel>()
          .getStudents(context.read<BatchViewModel>().selectedBatch);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var studentProvider = context.watch<StudentViewModel>();
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
        child: studentProvider.loading
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => Shimmer.fromColors(
                      baseColor: CustomColors.bgOverlay,
                      highlightColor: CustomColors.light.withOpacity(.4),
                      child: const AccountTileSkelton(),
                    )),
                itemCount: 20,
              )
            : ListView.separated(
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return StudentTile(
                    student: studentProvider.students[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemCount: studentProvider.students.length,
              ),
      ),
    );
  }
}


// StudentModel(
//                 phone: "sample phone",
//                 id: "id",
//                 name: "Anin Arafath",
//                 gender: Gender.female,
//                 dpURL: "https://aninarafath.me/images/about-1.jpeg",
//                 email: "email",
//                 lastLogin: DateTime.now(),
//                 department: "Cs",
//                 // reference: DocumentReference(),
//                 admissionNo: index + 22000,
//                 dob: DateTime.now(),
//                 parentPhone: "parentPhone",
//                 rollNumber: index + 1,
//                 secondLanguage: "secondLanguage",
//               ),
//             );