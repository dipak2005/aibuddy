import '../../model/export_libreary.dart';

class Signup extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.black.withOpacity(0.96),
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
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: controller.globalKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 48.0),
                            child: Text(
                              "Welcome to ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 48.0),
                              child: GradientText(
                                text: "AI Buddy",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      child: TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          suffix: Icon(
                            Icons.mail_outline,
                            color: Color(0xff9A87EC),
                          ),
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
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "*Plz Enter E-Mail";
                          } else if (value?.contains("@") ?? false) {
                            return null;
                          } else {
                            return "*Plz Enter valid E-mail";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        focusNode: FocusScopeNode(canRequestFocus: true),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      child: Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return "*Plz Enter password";
                            } else if (value?.contains("#") ?? false) {
                              return null;
                            } else {
                              return "Enter valid password";
                            }
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: controller.password,
                          onEditingComplete: () {
                            if (controller.globalKey.currentState?.validate() ??
                                false) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          canRequestFocus: true,
                          obscureText: controller.isShow.value,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            suffix: IconButton(
                                onPressed: () {
                                  controller.isShow.value =
                                      !controller.isShow.value;
                                },
                                icon: Icon(
                                  controller.isShow.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff9A87EC),
                                )),
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
                          overlayColor:
                              const WidgetStatePropertyAll(Color(0xffA981FF)),
                          backgroundColor:
                              const WidgetStatePropertyAll(Color(0xff9C58E9)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          fixedSize: WidgetStatePropertyAll(
                            Size(MediaQuery.sizeOf(context).width / 1.2,
                                MediaQuery.sizeOf(context).height / 15),
                          ),
                        ),
                        onPressed: () {
                          Future.delayed(const Duration(seconds: 2)).then(
                            (value) {
                              controller.signUp();
                            },
                          );
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Do you have an account? ",
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
                              controller.scaffoldKey.currentState?.openDrawer();
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(color: Color(0xff9C58E9)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const FittedBox(
                      fit: BoxFit.cover,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "----------------------- OR --------------------------",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                          side: const WidgetStatePropertyAll(
                              BorderSide(color: Color(0xff9A87EC))),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
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
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                          side: const WidgetStatePropertyAll(
                              BorderSide(color: Color(0xff9A87EC))),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          fixedSize: WidgetStatePropertyAll(
                            Size(MediaQuery.sizeOf(context).width / 1.2,
                                MediaQuery.sizeOf(context).height / 15),
                          ),
                        ),
                        onPressed: () {
                          // controller.signInWithFaceBook();
                        },
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: SignInPage(),
    );
  }
}
