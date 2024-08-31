import 'package:ai_chatboat/controller/home_controller.dart';
import 'package:ai_chatboat/view/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/export_libreary.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
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
                          : null,
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
                              child: Text(
                            "${user?.email}",
                            style: const TextStyle(color: Colors.white),
                          ));
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
                              chat;
                              return Align(
                                alignment: chat["user"] == 0
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Container(
                                  width: chat["user"] == 0
                                      ? MediaQuery.sizeOf(context).width / 2
                                      : MediaQuery.sizeOf(context).width,
                                  padding: chat["user"] == 0
                                      ? const EdgeInsets.only(
                                          left: 10, right: 10)
                                      : null,
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.sizeOf(context)
                                        .width, // Limit max width
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          chat["user"] == 0
                                              ? Align(
                                                  alignment: Alignment.topRight,
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
                                                )
                                              : const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: CircleAvatar(
                                                      radius: 13,
                                                    ),
                                                  )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: chat["user"] == 0
                                                    ? Colors.white
                                                    : Colors.transparent,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(30),
                                                        bottomLeft:
                                                            Radius.circular(30),
                                                        topLeft:
                                                            Radius.circular(
                                                                30))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18,
                                                  top: 10,
                                                  bottom: 10),
                                              child: SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                child: InkWell(
                                                  onLongPress: chat["user"] == 0
                                                      ? () {
                                                          controller
                                                                  .chatController
                                                                  .text =
                                                              chat["text"];
                                                        }
                                                      : null,
                                                  child: Text(
                                                    "${chat["text"]}",
                                                    style: TextStyle(
                                                        color: chat["user"] == 0
                                                            ? const Color(
                                                                0xffFF50FB)
                                                            : Colors.white,
                                                        fontSize:
                                                            chat["user"] == 0
                                                                ? 18
                                                                : 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      chat["user"] == 1
                                          ? Row(
                                              children: [
                                                Obx(
                                                  () => IconButton(
                                                    onPressed: () {
                                                      controller.isLike?.value =
                                                          !controller
                                                              .isLike!.value;
                                                      // controller.like.add(element)
                                                      // controller.index=index;
                                                      // controller.like[index] =
                                                      //     !controller
                                                      //         .like[index];
                                                    },
                                                    icon: Icon(
                                                        controller.isLike!.value
                                                            ? Icons
                                                                .thumb_up_alt_outlined
                                                            : Icons.thumb_up,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Obx(
                                                  () => IconButton(
                                                    onPressed: () {
                                                      controller
                                                              .isdIsLike.value =
                                                          !controller
                                                              .isdIsLike.value;
                                                      chat["isDisLike"] = true;
                                                    },
                                                    icon: Icon(
                                                        controller
                                                                .isdIsLike.value
                                                            ? Icons
                                                                .thumb_down_alt_outlined
                                                            : Icons.thumb_down,
                                                        color: Colors.white),
                                                  ),
                                                ),
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
                                                      controller
                                                          .copy(chat["text"]);
                                                    },
                                                    icon: const Icon(
                                                      Icons.copy,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 70,
                                      )
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
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: controller.chatController,
                          textInputAction: TextInputAction.newline,
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                try {
                                  controller
                                      .getQuery(controller.chatController.text);


                                  controller.chatController.clear();
                                  controller.queryResult();
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
                        ),
                      ),
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
