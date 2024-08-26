import 'dart:convert';

class UserModel {
  int? identifier;
  String? fullName;
  String? firstName;
  String? lastName;
  String? userName;
  String? country;
  String? contactEmail;
  UserModel({
    this.identifier,
    this.fullName,
    this.firstName,
    this.lastName,
    this.userName,
    this.country,
    this.contactEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifier': identifier,
      'full-name': fullName,
      'fname': firstName,
      'lname': lastName,
      'user-name': userName,
      'country': country,
      'contact-email': contactEmail,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      identifier: map['identifier'] as int,
      fullName: map['full-name'] as String,
      firstName: map['fname'] as String,
      lastName: map['lname'] as String,
      userName: map['user-name'] as String,
      country: map['country'] as String,
      contactEmail: map['contact-email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
