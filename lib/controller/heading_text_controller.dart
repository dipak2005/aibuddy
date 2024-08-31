import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadingTextController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get key => scaffoldKey;
  RxBool isHover = false.obs;
}