import 'package:ai_chatboat/controller/splash_controller.dart';
import 'package:ai_chatboat/model/theme/gradiant_text.dart';
import 'package:ai_chatboat/view/animation/hello_animation.dart';
import 'package:ai_chatboat/view/auth/signup.dart';

import 'package:ai_chatboat/view/commen_heading_text/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelloSplash extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  HelloSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.black.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.96),
        title: Text(
          "Ai Buddy",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20,
                color: Colors.white,
                letterSpacing: -1,
                fontWeight: FontWeight.w400,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                controller.scaffoldKey.currentState?.openEndDrawer();
              },
              child: const Text(
                "SignUp",
                style: TextStyle(
                    letterSpacing: 1, color: Color(0xff9C58E9), fontSize: 17),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(child: HelloAi()),
            EnterenceText(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: OutlinedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    side: const WidgetStatePropertyAll(
                        BorderSide(color: Color(0xff9C58E9))),
                    // backgroundColor:
                    //     const WidgetStatePropertyAll(Color(0xff9C58E9)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.sizeOf(context).width / 2.5,
                          (MediaQuery.sizeOf(context).height / 17)),
                    ),
                  ),
                  onPressed: () {
                    controller.scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
      endDrawer: Signup(),
    );
  }
}
