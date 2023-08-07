import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<User>> searchUsers({required String name}) {
  final snapshots = FirebaseFirestore.instance.collection('users').snapshots();
  return snapshots.map((snapshot) {
    return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  });
}

class User {
  final String id;
  final String name;
  final String emailAddress;
  final int phoneNumber;
  final Map<String, String> socials;
  final Set<Map<String, dynamic>> experience;
  final Set<Map<String, dynamic>> education;
  final Map<String, dynamic> skills;

  User({
    this.id = '',
    this.name = '',
    this.emailAddress = '',
    this.phoneNumber = 0,
    this.socials = const {},
    this.experience = const {},
    this.education = const {},
    this.skills = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'socials': socials,
      'experience': experience,
      'education': education,
      'skills': skills,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
      socials: Map<String, String>.from(json['socials'] as Map),
      experience:
      Set<Map<String, dynamic>>.from(json['experience'] as Iterable),
      education: Set<Map<String, dynamic>>.from(json['education'] as Iterable),
      skills: json['skills'],
    );
  }
}

Stream<List<User>> readUsers() {
  final snapshots = FirebaseFirestore.instance.collection('users').snapshots();
  return snapshots.map((snapshot) {
    return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  });
}
