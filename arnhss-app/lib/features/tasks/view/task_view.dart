import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 28,
          icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark),
        ),
        title: const Text("Planner"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/pngs/under-dev-removebg-preview.png",
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text("Under Development"),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
