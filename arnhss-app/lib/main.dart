import 'package:arnhss/common/routes/app_routes.dart';
import 'package:arnhss/common/theme/theme.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'arnhss',
        initialRoute: SplashView.routeName,
        theme: Theming.theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
