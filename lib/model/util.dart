import 'package:ai_chatboat/model/export_libreary.dart';

class DataClass {
  List<Map<String, dynamic>> dataList = [
    {
      "image": "assets/git.png",
      "link": "https://github.com/dipak2005/",
    },
    {
      "image": "assets/link.png",
      "link": "https://www.linkedin.com/in/dipak-thakur05/",
    },
    {
      "image": "assets/insta.png",
      "link": "https://www.instagram.com/dipak_0.50/",
    },
    {
      "image": "assets/x.png",
      "link": "https://x.com/dipak_d74252835?t=CvprKlahdSyvmdLT1VHOFQ&s=09"
    }
  ];

  List<Map<String, dynamic>> queList = [
    {
      "icon": Icons.airplanemode_on_rounded,
      "color": Colors.blue,
      "label": "Experience seoul like a local",
      "text":
          "I'm planning a 4-day trip to Seoul. Can you suggest an itinerary that doesn't involve popular tourist attractions?",
    },
    {
      "icon": Icons.lightbulb_outline,
      "color": Colors.yellow,
      "label": "Morning routine for productivity",
      "text":
          "Can you help me create a personalized morning routine that would help increase my productivity throughout the day? Start by asking me about my current habits and what activities energize me in the morning.",
    },
    {
      "icon": Icons.edit_outlined,
      "color": Colors.deepPurpleAccent,
      "label": "Content calender for TickTok",
      "text":
          "Create a content calendar for a TikTok account on reviewing real estate listings.",
    },
    {
      "icon": Icons.edit_outlined,
      "color": Colors.deepPurpleAccent,
      "label": "Message to comfort friend",
      "text":
          "I want to cheer up my friend who's having a rough day. Can you suggest a couple short and sweet text messages to go with a kitten gif?",
    },
  ];
}
