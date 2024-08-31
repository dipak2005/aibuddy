import 'dart:async';

import 'package:ai_chatboat/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get key => scaffoldKey;
  RxBool isHover = false.obs;

  @override
  void onInit() {
    // Timer(const Duration(seconds: 5), goto);
    super.onInit();
  }

  void goto() {
    Get.off(() => Homepage());
  }
}
