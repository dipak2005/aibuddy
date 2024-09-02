




import '../model/export_libreary.dart';

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
  @override
  void dispose() {

    super.dispose();
  }
}
