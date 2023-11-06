//ignore: unused_import
import 'package:flutter/material.dart';
import 'package:scholar_chat/widgets/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(jsonData[kTextMessage] as String? ?? '',
        jsonData['id'] as String? ?? '');
  }
}
