import 'dart:async';
import 'dart:io';

import 'package:ai_chatboat/model/singleton_class/user_query.dart';
import 'package:ai_chatboat/view/hello_splash.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';

import '../model/helper_class/api_helper.dart';
import '../model/singleton_class/query_model.dart';

class HomeController extends GetxController {
  TextEditingController chatController = TextEditingController();

  // model classes objects
  QnaModel? qnaModel = QnaModel();
  UserQuery? userQuery = UserQuery();

  // for settings page
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get gKey => scaffoldKey;

  // connectivity result of network
  // ConnectivityResult result = ConnectivityResult.none;
  RxBool isConnected = false.obs;
  List<QueryDocumentSnapshot>? trData;
  RxBool isLike = false.obs;
  RxBool isdIsLike = false.obs;
  RxBool isSound = false.obs;
  RxBool isPlay = false.obs;
  RxBool isCopy = false.obs;

  // RxList<UserQuery> likeList = <UserQuery>[UserQuery(isLike: false,isDisLike: false)].obs;
  // RxList<UserQuery> dislikeList = <UserQuery>[].obs;

  List<ListItem> likeList = [];
  List<ListItem> dislikeList = [];

  // this is the init state function the when the homepage is initialize then the function is executed for only one time

  @override
  void onInit() async {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (index > 1) {
          itemScrollController.scrollTo(
              index: index - 1,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceInOut);
        }
      },
    );
    FirebaseFirestore.instance.collection("User").doc(user?.email).get().then(
      (value) {
        print("calling");
      },
    );
    super.onInit();
  }

  void toggleLike(int index) {
    likeList[index].isLike.value = !(likeList[index].isLike.value);
    update();
  }

  void shareContent(String text) async {
    if (Platform.isAndroid) {
      ShareResult result = await Share.share(text);
      if (result.status == ShareResultStatus.success) {
        print("success");
      }
    }
  }

  void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(() => HelloSplash());
    update();
    // }
  }

  // controllers for manage the scrolling of lift while the qna list is not empty
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  RxBool isEmpty = true.obs;

  // this is the objet of api helper singleton class
  ApiHelper apiHelper = ApiHelper();

  String query = "";
  User? user = FirebaseAuth.instance.currentUser;
  RxBool isSign = false.obs;
  int index = 0;

  // call the function while entered using chat controller
  Future<void> queryResult() async {
    if (query.isNotEmpty) {
      print("hiiimessage : $query");
      // call the api
      qnaModel = await apiHelper.getApiData(query);

      var docRef =
          FirebaseFirestore.instance.collection("User").doc(user?.email);

      await docRef
          .collection("userQuery")
          .doc(DateTime.now().toString())
          .set(UserQuery(
            text: qnaModel?.bodyModel?[0].content?.parts?[0].text,
            datetime:
                "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
            user: 1,
            email: user?.email,
          ).toJson());
    } else {
      qnaModel = QnaModel();
      var docRef = FirebaseFirestore.instance.collection("User").doc();

      await docRef
          .collection("userQuery")
          .doc(DateTime.now().toString())
          .set(UserQuery(
            text: "something went wrong",
            datetime: "${DateTime.now().hour}:${DateTime.now().minute}",
            user: 1,
            email: user?.email,
          ).toJson());
    }
  }

  Future<void> getQuery(String queries) async {
    query = queries;
    isCopy = false.obs;
    print("message:$query");
    qnaModel = null;
    if (user?.email != null) {
      var uQuery = await FirebaseFirestore.instance
          .collection("User")
          .doc(user?.email)
          .get();
      if (uQuery.exists) {
        uQuery.reference
            .collection("userQuery")
            .doc(DateTime.now().toString())
            .set(UserQuery(
              text: queries,
              datetime:
                  "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
              user: 0,
              email: user?.email,
            ).toJson());
      }
    }
  }
}
