// ignore_for_file: prefer_const_constructors

import 'package:ai_chatboat/controller/home_controller.dart';
import 'package:ai_chatboat/controller/settingsController.dart';
import 'package:ai_chatboat/model/export_libreary.dart';
import 'package:ai_chatboat/model/util.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.96),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.76,
              child: ListView()),
          Text(
            "----------- Follow on -----------",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: DataClass().dataList.length,
          //     itemBuilder: (context, index) {
          //       var data = DataClass().dataList[index];
          //       return InkWell(
          //         onTap: ()async {
          //           Uri url=Uri.parse(data["link"]);
          //          await launchUrl(url);
          //         },
          //         child: Container(
          //           margin: EdgeInsets.all(30),
          //           // height: MediaQuery.sizeOf(context).height/14,
          //           width: MediaQuery.sizeOf(context).width / 11,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(3),
          //             image: DecorationImage(
          //               image: AssetImage(
          //                 data["image"],
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
