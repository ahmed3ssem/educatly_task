import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  Map<String, dynamic> message;
  bool isSender;
  ChatBubble({super.key , required this.message , required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0.h),
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFF8F47FE) : const Color(0xFF31252B),
          borderRadius: BorderRadius.only(
            topLeft: isSender ? const Radius.circular(20) : Radius.zero,
            topRight: isSender ? Radius.zero : const Radius.circular(20),
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          ),
        ),
        child: Text(
          message['message'], // Fetch the actual message text
          style: TextStyle(color: Colors.white , fontWeight: FontWeight.w400 , fontSize: 16.fSize),
        ),
      ),
    );
  }
}
