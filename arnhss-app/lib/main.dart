import 'package:arnhss/common/routes/app_routes.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/theme.dart';
import 'package:arnhss/features/attendance/view_model/attendance_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';

import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => VerifyOtpViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => PlannerViewModel()),
      ],
      child: GetMaterialApp(
        title: 'arnhss',
        initialRoute: HomeView.routeName,
        theme: Theming(context: context).theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
