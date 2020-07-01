import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  createUser(String id, Map<String,dynamic> value) {
    Firestore.instance
        .collection("users")
        .document(id)
        .setData(value);
  }
}
class UserProfile{
  String id;
  String username;
  String profilePicture;
  String gender;
  String email;
}