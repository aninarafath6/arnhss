import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

AppBar searchAppBar<T>(BuildContext context,
    {Brightness type = Brightness.dark,
    Function()? onTap,
    Function()? onSearchTap,
    bool? searching = false,
    bool center = false,
    String? hintText = "Search you country code...",
    String? title = "Choose your country",
    FocusNode? focusNode}) {
  return AppBar(
    backgroundColor: type == Brightness.dark ? CustomColors.dark : Colors.white,
    // toolbarHeight: 80,

    elevation: type == Brightness.dark ? 1 : .1,
    leading: IconButton(
      splashRadius: 26,
      icon: Icon(Icons.arrow_back_ios_new,
          color: type == Brightness.dark ? Colors.white : CustomColors.dark),
      onPressed: onTap,
    ),
    title: searching!
        ? TextField(
            focusNode: focusNode,
            onChanged: context.read<CountryViewModel>().searchCountry,
            cursorColor:
                type == Brightness.dark ? Colors.white : CustomColors.dark,
            style: TextStyle(
                color:
                    type == Brightness.dark ? Colors.white : CustomColors.dark),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: CustomColors.light)),
          )
        : Text(
            title ?? "",
            style: TextStyle(
                color:
                    type == Brightness.dark ? Colors.white : CustomColors.dark),
          ),
    centerTitle: center,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onSearchTap,
          icon: Icon(Icons.search_rounded,
              color:
                  type == Brightness.dark ? Colors.white : CustomColors.dark),
          splashRadius: 26,
        ),
      )
    ],
  );
}
