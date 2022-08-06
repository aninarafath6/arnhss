import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.getWidth(0)),
        child: Stack(
          children: [
            Container(
              height: context.getHeight(70),
              child: Image.asset(
                "assets/images/pngs/uni_dr_4x.jpg.webp",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: context.getHeight(35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      context.spacing(height: 1),
                      const Spacer(flex: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing   ",
                          style: TextStyle(
                            color: Color(0xff45314d),
                            fontSize: context.getHeight(2.5),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      context.spacing(height: 2),
                      Text(
                        " is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(.8),
                            fontSize: context.getHeight(1.7),
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(flex: 2),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color(0xffac769d).withOpacity(.1)),
                        ),
                        onPressed: () {},
                        child: Container(
                          width: context.getWidth(100),
                          height: context.getHeight(5),
                          decoration: BoxDecoration(
                            color: const Color(0xff855f95),
                            borderRadius: BorderRadius.circular(
                              context.getHeight(1),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
