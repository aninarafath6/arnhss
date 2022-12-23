import 'package:arnhss/abstract/loader.abstract.dart';
import 'package:arnhss/common/routes/app_routes.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/theme.dart';
import 'package:arnhss/features/authentication/repo/auth_service.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/student/attendance/view_model/attendance_view_model.dart';
import 'package:arnhss/features/authentication/account/view_model/select_account_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/users/student/home/view_models/home_view_model.dart';
import 'package:arnhss/features/users/student/notes/view_model/notes_view_model.dart';
import 'package:arnhss/features/users/student/notifications/view_model/notification_view_model.dart';
import 'package:arnhss/features/users/student/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/firebase_options.dart';
import 'package:arnhss/services/db_service.dart';
import 'package:arnhss/services/notification/local_notification_service.dart';
import 'package:arnhss/services/notification/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//* Handle notification while app is working on background
Future<void> onBackgroundHandler(RemoteMessage message) async {
  LocalNotificationService.firePlay(message);
}

NotificationService notificationService = NotificationService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

  await DBService.initDB();
  await dotenv.load(fileName: ".env");

// ? cache cleaner just a
//   DefaultCacheManager manager = new DefaultCacheManager();
//   manager.emptyCache(); //clears all data in cache.

  initializeDateFormatting().then(
    (_) async {
      await Firebase.initializeApp(
        name: 'arnhss',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // FirebaseMessaging.instance.unsubscribeFromTopic(Role.admin.describe);
      // FirebaseMessaging.instance.unsubscribeFromTopic(Role.teacher.describe);
      // FirebaseMessaging.instance.unsubscribeFromTopic(Role.principle.describe);
      // FirebaseMessaging.instance.unsubscribeFromTopic(Role.everyone.describe);
      // FirebaseMessaging.instance.unsubscribeFromTopic(Role.student.describe);
      // FirebaseMessaging.instance
      //     .unsubscribeFromTopic(FirebaseConstants.authenticatedUSERS);

      debugPrint("${AuthService().getCurrentUser()?.phoneNumber} user ");

      runApp(const MyApp());
    },
  );
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
        ChangeNotifierProvider(create: (_) => StudentHomeViewModel()),
        ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => PlannerViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => NotesViewModel()),
        ChangeNotifierProvider(create: (_) => SelectAccountViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => NoticeViewModel()),
        ChangeNotifierProvider(create: (_) => Loader()),
        ChangeNotifierProvider(create: (_) => AdmissionViewModel()),
        ChangeNotifierProvider(create: (_) => BatchViewModel()),
      ],
      child: GetMaterialApp(
        title: 'arnhss',
        initialRoute: SplashView.routeName,
        theme: Theming(context: context).theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
