
import '../export_libreary.dart';

class AddUserModel {
  static final instance = AddUserModel._();

  AddUserModel._();

  factory AddUserModel() {
    return instance;
  }

  void addUser(User? user) async {
    AddUser addUser =
        AddUser(email: user?.email, dateTime: DateTime.now(),);

    FirebaseFirestore.instance
        .collection("User")
        .doc(user?.email)
        .set(addUser.toJson());
  }
}
