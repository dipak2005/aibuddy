import '../../model/export_libreary.dart';

class SignInPage extends StatelessWidget {
  final SignupController controller = Get.find();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030315),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.96),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Drawer(
          backgroundColor: Colors.black.withOpacity(0.96),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: controller.gsKey,
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 48.0),
                          child: Text(
                            "Welcome back",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.2,
                          child: TextFormField(
                            controller: controller.loginEmail,
                            focusNode: FocusScopeNode(canRequestFocus: true),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "*Plz Enter E-Mail";
                              } else if (value?.contains("@") ?? false) {
                                return null;
                              } else {
                                return "*Plz Enter valid E-mail";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            canRequestFocus: true,
                            showCursor: true,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffix: Icon(
                                Icons.mail_outline,
                                color: Color(0xff9A87EC),
                              ),
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: Color(0xff9A87EC),
                              ),
                              labelText: "E-mail*",
                              focusColor: Color(0xff9A87EC),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff9A87EC),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.2,
                          child: Obx(
                            () => TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "Plz Enter password*";
                                } else if (value?.contains("#")??false) {
                                  return null;
                                } else {
                                  return "Enter valid password*";
                                }
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              controller: controller.loginPassword,
                              style: const TextStyle(color: Colors.white),
                              obscureText: controller.LisShow.value,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                  onPressed: () {
                                    controller.LisShow.value =
                                        !controller.LisShow.value;
                                  },
                                  icon: Icon(
                                    controller.LisShow.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xff9A87EC),
                                  ),
                                ),
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                  color: Color(0xff9A87EC),
                                ),
                                labelText: "Password*",
                                focusColor: const Color(0xff9A87EC),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff9A87EC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xff9C58E9)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              fixedSize: WidgetStatePropertyAll(
                                Size(MediaQuery.sizeOf(context).width / 1.2,
                                    MediaQuery.sizeOf(context).height / 15),
                              ),
                            ),
                            onPressed: () {
                              controller.login(controller.loginEmail.text,
                                  controller.loginPassword.text);
                            },
                            child: Text(
                              "Continue",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "you don't  have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                  side: WidgetStatePropertyAll(
                                      BorderSide(color: Colors.transparent))),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "sign up",
                                style: TextStyle(color: Color(0xff9C58E9)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            "----------------------- OR --------------------------",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                side: const WidgetStatePropertyAll(
                                    BorderSide(color: Color(0xff9A87EC))),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                fixedSize: WidgetStatePropertyAll(
                                  Size(MediaQuery.sizeOf(context).width / 1.2,
                                      MediaQuery.sizeOf(context).height / 15),
                                ),
                              ),
                              onPressed: () {
                                controller.signInWithGoogle();
                              },
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/google.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(
                                      "Continue with Google",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                side: const WidgetStatePropertyAll(
                                    BorderSide(color: Color(0xff9A87EC))),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                fixedSize: WidgetStatePropertyAll(
                                  Size(MediaQuery.sizeOf(context).width / 1.2,
                                      MediaQuery.sizeOf(context).height / 15),
                                ),
                              ),
                              onPressed: () {},
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/face.jpg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Continue with FaceBook",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
