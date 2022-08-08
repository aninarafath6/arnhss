import 'package:arnhss/common/routes/app_routes.dart';
import 'package:arnhss/common/theme/theme.dart';
import 'package:arnhss/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'arnhss',
      initialRoute: SplashView.routeName,
      theme: Theming.theme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
