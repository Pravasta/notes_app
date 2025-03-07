import 'dart:convert';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;

  UserModel({this.uid, this.name, this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uid': uid, 'name': name, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
