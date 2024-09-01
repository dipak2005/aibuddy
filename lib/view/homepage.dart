// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:ai_chatboat/controller/home_controller.dart';
import 'package:ai_chatboat/model/helper_class/api_helper.dart';
import 'package:ai_chatboat/model/util.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/export_libreary.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    int index;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.96),
        title: const GradientText(
          text: "Ai Buddy",
          style: TextStyle(fontSize: 20),
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
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          "Are you sure want to Logout??",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ),
                        icon: Image.asset(
                          "assets/warning.png",
                          height: 40,
                          width: 30,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              )),
                          TextButton(
                              onPressed: () {
                                controller.signOut();
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ))
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.1,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: user?.email != null
                          ? FirebaseFirestore.instance
                              .collection("User")
                              .doc(user?.email) // Handle null email
                              .collection("userQuery")
                              .snapshots()
                          : Stream.empty(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data = snapshot.data?.docs ?? [];
                        controller.trData = data;
                        if (data.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/f1.png",
                                  height: 170,
                                  width: 170,
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    itemCount: DataClass().queList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Map<String, dynamic> list =
                                          DataClass().queList[index];

                                      return InkWell(
                                        onTap: () {
                                          controller.chatController.text =
                                              list["text"];
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xff1E1F20),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                list["icon"],
                                                color: list["color"],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  list["label"],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ScrollablePositionedList.builder(
                            itemScrollController:
                                controller.itemScrollController,
                            scrollOffsetController:
                                controller.scrollOffsetController,
                            itemPositionsListener:
                                controller.itemPositionsListener,
                            scrollOffsetListener:
                                controller.scrollOffsetListener,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final uQuery = data[index];
                              final chat =
                                  uQuery.data() as Map<String, dynamic>;
                              controller.index = data.length;
                              final int userType = chat["user"] ?? -1;
                              return Align(
                                alignment: userType == 0
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Container(
                                  padding: userType == 0
                                      ? const EdgeInsets.only(
                                          left: 10, right: 10)
                                      : null,
                                  constraints: userType == 0
                                      ? BoxConstraints(
                                          minWidth:
                                              MediaQuery.sizeOf(context).width /
                                                  3,
                                          maxWidth:
                                              MediaQuery.sizeOf(context).width /
                                                  1.1)
                                      : null,
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          userType == 0
                                              ? Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return SizedBox(
                                                              height: 50,
                                                              child: Center(
                                                                  child: Text(
                                                                      user?.email ??
                                                                          "")));
                                                        },
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 13,
                                                      backgroundColor:
                                                          Colors.white,
                                                      backgroundImage: user
                                                                  ?.photoURL
                                                                  ?.isNotEmpty ??
                                                              false
                                                          ? NetworkImage(
                                                              user?.photoURL ??
                                                                  "")
                                                          : const AssetImage(
                                                              "assets/photo.jpg"),
                                                    ),
                                                  ),
                                                )
                                              : Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child: Image.asset(
                                                        "assets/f1.png",
                                                      ),
                                                    ),
                                                  )),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: userType == 0
                                                    ? Colors.white
                                                    : Colors.transparent,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(30),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(
                                                                20))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: InkWell(
                                                onLongPress: userType == 0
                                                    ? () {
                                                        controller
                                                                .chatController
                                                                .text =
                                                            chat["text"];
                                                      }
                                                    : null,
                                                child: Text(
                                                  softWrap: true,
                                                  "${chat["text"]}",
                                                  style: TextStyle(
                                                      color: userType == 0
                                                          ? const Color(
                                                              0xffFF50FB)
                                                          : Colors.white,
                                                      fontSize: userType == 0
                                                          ? 18
                                                          : 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (userType == 1)
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  controller.shareContent(
                                                      chat["text"]);
                                                },
                                                icon: const Icon(
                                                  Icons.share_outlined,
                                                  color: Colors.white,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  controller.copy(chat["text"]);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                              "Copied Successful ")));
                                                },
                                                icon: const Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )
                                      // else
                                      // const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: const Color(0xff1E1F20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 23, bottom: 3),
                        child: controller.userQuery != null
                            ? TextFormField(
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    controller.getQuery(value);
                                  }
                                },
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: controller.chatController,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.keyboard,
                                    color: Colors.white,
                                  ),
                                  suffix: IconButton(
                                    onPressed: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      try {
                                        controller.getQuery(
                                            controller.chatController.text);
                                        controller.itemScrollController.jumpTo(
                                            index: controller.index - 1);
                                        controller.chatController.clear();

                                        controller.queryResult();
                                        controller.itemScrollController.jumpTo(
                                            index: controller.index - 1);

                                      } catch (e, stackTrace) {
                                        print("error $e,$stackTrace");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  hintText: "Chat with Ai Buddy",
                                  hintStyle: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white),
                                  border: InputBorder.none,
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 290,
                    right: 20,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: IconButton(
                          onPressed: () {
                            if (controller.index > 0) {
                              controller.itemScrollController
                                  .jumpTo(index: controller.index - 1);
                              controller.itemScrollController.scrollTo(
                                  index: controller.index - 1,
                                  duration: Duration(milliseconds: 100));
                              print("index:${controller.index}");
                            }
                          },
                          icon: Icon(
                            Icons.arrow_downward_outlined,
                            color: Color(0xffFF50FB),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 10),
              child: Text(
                "Ai Buddy may be inaccurate info, including about people, so double-check its response.",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Developed by",
                  style: TextStyle(color: Colors.white),
                ),
                GradientText(
                  text: " Dipak Thakur",
                  style: TextStyle(fontSize: 13),
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
              ],
            ),
          ],
        ),
      ),
      // endDrawer: SettingPage(),
    );
  }
}
