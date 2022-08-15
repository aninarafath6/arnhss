import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class StudentAuthencation extends StatelessWidget {
  const StudentAuthencation({Key? key}) : super(key: key);
  static const routeName = "/studentAutentication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("student authentciation "),
      ),
    );
  }
}
