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
  UserQuery userQuery = UserQuery();

  // for settings page
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get gKey => scaffoldKey;

  // connectivity result of network
  // ConnectivityResult result = ConnectivityResult.none;
  RxBool isConnected = false.obs;
  List<QueryDocumentSnapshot>? trData;
  RxBool? isLike;
  RxBool isdIsLike = false.obs;
  RxBool isSound = false.obs;
  RxBool isPlay = false.obs;

  RxList<bool> like = <bool>[].obs;

  // this is the init state function the when the homepage is initialize then the function is executed for only one time

  void onInit() async {
    var data = await FirebaseFirestore.instance
        .collection("User")
        .doc(user?.email)
        .collection("userQuery")
        .doc(DateTime.now().toString())
        .get();

    Map<String, dynamic>? userData = data.data();



    super.onInit();
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

      // store the data using firebase when current platform is web
      var docRef =
          FirebaseFirestore.instance.collection("User").doc(user?.email);

      await docRef.collection("userQuery").doc(DateTime.now().toString()).set(
          UserQuery(
                  text: qnaModel?.bodyModel?[0].content?.parts?[0].text,
                  datetime:
                      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                  user: 1,
                  email: user?.email,
                  isLike: like[index],
                  isDisLike: !isLike!.value)
              .toJson());

      // get the data from firebase
      var data = await FirebaseFirestore.instance.collection("User").get();
    } else {
      qnaModel = QnaModel();
      var docRef = FirebaseFirestore.instance.collection("User").doc();

      await docRef.collection("userQuery").doc(DateTime.now().toString()).set(
          UserQuery(
                  text: "something went wrong",
                  datetime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  user: 1,
                  email: user?.email,
                  isDisLike: !isLike!.value,
                  isLike: isLike?.value)
              .toJson());

      // get the data from firebase
      FirebaseFirestore.instance.collection("queryData").get();
    }
  }

  Future<void> getQuery(String queries) async {
    query = queries;
    isLike = false.obs;
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
                    isLike: isLike?.value,
                    isDisLike: !isLike!.value)
                .toJson());
      }
    }
  }

// void Sound() async {
//   await flutterTts.synthesizeToFile(
//       chatController.text, Platform.isAndroid ? "tts.wav" : "tts.caf");
//   flutterTts.setLanguage("en-US");
//   await flutterTts.setSpeechRate(1.0);
//   await flutterTts.setVolume(1.0);
//   await flutterTts.getDefaultVoice;
//
//   var result = await flutterTts.speak(chatController.text);
//   flutterTts.setCompletionHandler(
//     () {
//       isPlay.value = false;
//       update();
//     },
//   );
// }
}

// import 'package:ai_chatboat/model/singleton_class/user_query.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
//
// import '../model/helper_class/api_helper.dart';
// import '../model/singleton_class/query_model.dart';
//
// class HomeController extends GetxController {
//   TextEditingController chatController = TextEditingController();
//
//   // Model classes objects
//   QnaModel? qnaModel = QnaModel();
//   UserQuery userQuery = UserQuery();
//
//   // Connectivity result of network
//   RxBool isConnected = false.obs;
//
//   // Controllers for managing the scrolling of list
//   final ItemScrollController itemScrollController = ItemScrollController();
//   final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
//   final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
//   final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
//
//   RxBool isEmpty = true.obs;
//
//   // ApiHelper singleton class object
//   ApiHelper apiHelper = ApiHelper();
//
//   String query = "";
//   User? user = FirebaseAuth.instance.currentUser;
//
//   @override
//   void onInit() {
//     super.onInit();
//     FirebaseFirestore.instance.collection("queryData").get();
//   }
//
//   // Function to call when a query is entered using chat controller
//   Future<void> queryResult() async {
//     if (query.isNotEmpty) {
//       print("hiiimessage : $query");
//
//       // Call the API
//       qnaModel = await apiHelper.getApiData(query);
//
//       if (qnaModel != null && qnaModel!.bodyModel?.isNotEmpty == true) {
//         // Store the data using Firebase when the current platform is web
//         var docRef = FirebaseFirestore.instance.collection("queryData").doc(DateTime.now().toString());
//
//         await docRef.collection("userQuery").doc().set(
//           UserQuery(
//             text: qnaModel!.bodyModel?[0].content?.parts?[0].text ?? "No response",
//             datetime: "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second} : ${DateTime.now().millisecond}:${DateTime.now().millisecondsSinceEpoch}",
//             user: 1,
//             email: user?.email,
//           ).toJson(),
//         );
//
//         // Get the data from Firebase
//         await FirebaseFirestore.instance.collection("queryData").get();
//       }
//     } else {
//       qnaModel = QnaModel();
//       var docRef = FirebaseFirestore.instance.collection("queryData").doc(DateTime.now().toString());
//
//       await docRef.collection("userQuery").doc().set(
//         UserQuery(
//           text: "Something went wrong",
//           datetime: "${DateTime.now().hour}:${DateTime.now().minute}",
//           user: 1,
//           email: user?.email,
//         ).toJson(),
//       );
//
//       // Get the data from Firebase
//       await FirebaseFirestore.instance.collection("queryData").get();
//     }
//   }
//
//
// }
