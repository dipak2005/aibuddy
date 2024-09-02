

import 'firebase_options.dart';
import 'model/export_libreary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      title: "AI Buddy",
      debugShowCheckedModeBanner: false,
      initialRoute: user == null ? '/' : "home",
      routes: {
        "/": (p0) => HelloSplash(),
        "home": (p0) => Homepage(),

      },
    );
  }
}
