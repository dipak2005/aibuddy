
import '../model/export_libreary.dart';

class HeadingTextController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get key => scaffoldKey;
  RxBool isHover = false.obs;
}