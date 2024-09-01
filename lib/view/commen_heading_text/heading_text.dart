import 'package:ai_chatboat/controller/heading_text_controller.dart';
import 'package:ai_chatboat/model/theme/gradiant_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterenceText extends StatelessWidget {
  static final HeadingTextController controller =
      Get.put(HeadingTextController());

  const EnterenceText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(children: [
        GradientText(
          text: "Ai Buddy",
          style: TextStyle(fontSize: 70),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff217BFE),
              Color(0xff1584FD),
              Color(0xff568AF3),
              Color(0xff9A87EC),
              Color(0xffBA7BCD),
              Color(0xffFF50FB),
              Color(0xffD90FFF)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(),
          child: Text(
            "Boost Your Creativity",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(),
          child: Text("Let's Chat With Ai Buddy",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        SizedBox(
          height: 10,
        ),
      ],
      ),
    );
  }
}
