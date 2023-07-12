import 'package:chat/consts.dart';
import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: kComponentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
          bottomLeft: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          message.message,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xff4db4d7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          message.message,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    );
  }
}
//4db4d7