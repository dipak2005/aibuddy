import 'dart:async';
import 'dart:io';
import '../model/export_libreary.dart';

class HomeController extends GetxController {
  TextEditingController chatController = TextEditingController();

  // model classes objects
  QnaModel? qnaModel = QnaModel();
  UserQuery? userQuery = UserQuery(like: false, disLike: false);

  // for settings page
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get gKey => scaffoldKey;

  // connectivity result of network
  // ConnectivityResult result = ConnectivityResult.none;
  RxBool isConnected = false.obs;

  RxBool isLike = false.obs;
  RxBool isdIsLike = false.obs;
  RxBool isSignout = false.obs;
  RxBool isQ = false.obs;

  // RxList<UserQuery> likeList = <UserQuery>[UserQuery(isLike: false,isDisLike: false)].obs;
  // RxList<UserQuery> dislikeList = <UserQuery>[].obs;

  List<UserQuery> likeList = [];
  List<UserQuery> dislikeList = [];

  RxBool showScrollButton = false.obs;
  final ScrollController controller = ScrollController();
  RxList<QueryDocumentSnapshot<Object?>> data =
      <QueryDocumentSnapshot<Object?>>[].obs;

  // this is the init state function the when the homepage is initialize then the function is executed for only one time

  void scrollListener() {
    if (controller.offset < controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      showScrollButton = true.obs;
      update();
    } else {
      showScrollButton = false.obs;
      update();
    }
  }

  void scrollToBottom() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }

  @override
  void onInit() {
    // if (index > 1) {
    //   itemScrollController?.scrollTo(
    //       index: index,
    //       duration: const Duration(milliseconds: 50),
    //       curve: Curves.bounceInOut);
    // }

    controller.addListener(scrollListener);
    FirebaseFirestore.instance.collection("User").doc(user?.email).get().then(
      (value) {
        print("calling");
      },
    );
    super.onInit();
  }

  void toggleLike(int index) {
    likeList.add(UserQuery(like: !isLike.value, disLike: isdIsLike.value));
    // likeList[index].like = !(likeList[index].like);

    update();
  }

  void toggleDisLike(int index) {
    likeList.add(UserQuery(like: isLike.value, disLike: !isdIsLike.value));
    // likeList[index].like = !(likeList[index].like);
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
    Future.delayed(
      const Duration(microseconds: 300),
      () {
        Get.off(()=>HelloSplash());
      },
    );
    Get.off(() => HelloSplash());

    update();
  }

  // controllers for manage the scrolling of lift while the qna list is not empty
  final ItemScrollController? itemScrollController = ItemScrollController();
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

      await docRef.collection("userQuery").doc(DateTime.now().toString()).set(
          UserQuery(
                  text: qnaModel?.bodyModel?[0].content?.parts?[0].text,
                  datetime:
                      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                  user: 1,
                  email: user?.email,
                  like: false,
                  disLike: false)
              .toJson());
    } else {
      qnaModel = QnaModel();
      var docRef = FirebaseFirestore.instance.collection("User").doc();

      await docRef.collection("userQuery").doc(DateTime.now().toString()).set(
          UserQuery(
                  text: "something went wrong",
                  datetime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  user: 1,
                  email: user?.email,
                  like: false,
                  disLike: false)
              .toJson());
    }
  }

  Future<void> getQuery(String queries) async {
    query = queries;

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
              like: false,
              disLike: false,
            ).toJson());
      }
    }
  }
}
