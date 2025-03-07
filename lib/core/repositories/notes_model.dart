import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String id;
  final String title;
  final String text;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  NotesModel({
    required this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    this.updatedAt,
  });

  factory NotesModel.fromMap(Map<String, dynamic> data) {
    final id = data['id'];
    final title = data['title'];
    final text = data['text'];
    final createdAt = data['createdAt'];
    final updatedAt = data['updatedAt'];

    return NotesModel(
      id: id,
      title: title,
      text: text,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
  factory NotesModel.fromJson(String source) =>
      NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // convert DocumentSnapshot<Map<String, dynamic>> to NotesModel
  factory NotesModel.fromDocument(Map<String, dynamic> data) {
    return NotesModel(
      id: data['id'],
      title: data['title'],
      text: data['text'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }
}
