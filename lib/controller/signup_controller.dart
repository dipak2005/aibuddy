import 'dart:async';

import '../model/export_libreary.dart';

class SignupController extends GetxController {
  // for first time users
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  // for our existing users
  GlobalKey<FormState> gsKey = GlobalKey<FormState>();

  // for signIn page
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get gKey => scaffoldKey;

  // for signUp page
  late TextEditingController email;

 late  TextEditingController password;

  // for signIn page
 late TextEditingController loginEmail;
  late TextEditingController loginPassword;

  // visibility on
  RxBool isShow = true.obs;
  RxBool LisShow = true.obs;
  RxBool isNext = false.obs;
  RegExp pattern =
      RegExp("r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}");

  @override
  void onInit() {
    email = TextEditingController();
   password=TextEditingController();
   loginEmail=TextEditingController();
   loginPassword=TextEditingController();

    super.onInit();
  }

  // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
  // String isStrong(String value) {
  //   if (!value.contains("?=.*[A-Z]") ?? false) {
  //     return "Enter at least one upper case*";
  //   } else if (!value.contains("?=.*[a-z]")) {
  //     return "Enter at least one lower case*";
  //   } else if (!value.contains("?=.*?[0-9]")) {
  //     return "Enter at least one digit*";
  //   } else if (!value.contains("?=.*?[!@#\$&*~]")) {
  //     return "Enter at least one special character*";
  //   } else if (!value.contains(".{8,} ")) {
  //     return "Enter at least Eight character password";
  //   } else {
  //     return "";
  //   }
  // }

  // for signUp page
  void signUp() async {
    try {
      if (globalKey.currentState?.validate() ?? false) {
        FocusScope.of(Get.context!).unfocus();

        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        AddUserModel().addUser(user.user);
        print("is calling or not");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text("User Added Successfully")));
        Timer(
          const Duration(milliseconds: 200),
          () {
            Get.off(() => Homepage());
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("hii loggined");
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text("User Already Login"),
          backgroundColor: Colors.red,
        ));
      } else {
        print('Failed to register: ${e.message}');
      }
    }
  }

  // for signIn page
  void login(String email, String password) async {
    try {
      if (gsKey.currentState?.validate() ?? false) {
        FocusScope.of(Get.context!).unfocus();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("User signIn Successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Timer(
          const Duration(milliseconds: 200),
          () {
            Get.off(() => Homepage());
          },
        );
      }
      print("calling or not");
    } on FirebaseAuthException catch (e) {
      print("error : ${e.code.toString()}");
    }
  }

  // sign in with social media
  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? signIn = await GoogleSignIn().signIn();
    var signInData = await signIn?.authentication;

    var credential = GoogleAuthProvider.credential(
        idToken: signInData?.idToken, accessToken: signInData?.accessToken);

    UserCredential data =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = data.user;
    AddUserModel.instance.addUser(user);
    Timer(
      const Duration(seconds: 2),
      () {
        Get.off(() => Homepage());
      },
    );
  }

  // Future<void> signInWithFaceBook() async {
  //   FacebookAuthProvider data = FacebookAuthProvider();
  //   Get.to(() => Homepage());
  // }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    loginPassword.dispose();
    loginEmail.dispose();
    update();
    super.dispose();
  }
}
