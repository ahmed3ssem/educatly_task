import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/widgets/svg_image_widget.dart';
import 'package:educatly_task/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  String receiverId;
  ChatScreen({super.key , required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Dummy data for messages
  final List<Map<String, dynamic>> messages = [
    {'text': 'Hello!', 'isSender': true},
    {'text': 'Hi, how are you?', 'isSender': false},
    {'text': 'I\'m good, thanks!', 'isSender': true},
    {'text': 'Great to hear that!', 'isSender': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF8F47FE),
        elevation: 0,
        /*actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.,
            children: [
              SVGImageWidget(image: AssetsManager.backIcon, width: 11.w, height: 20.h),
              TextWidget(text: 'a7med@gmail.com', fontSize: 17.fSize , fontColor: AppColors.whiteColor, fontWeight: FontWeight.w700,),
              SVGImageWidget(image: AssetsManager.backIcon, width: 11.w, height: 20.h),
            ],
          )
        ],*/
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessageBubble(messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildInputField(),
          ),
        ],
      ),
    );
  }

  // Widget for message bubble
  Widget buildMessageBubble(Map<String, dynamic> message) {
    bool isSender = message['isSender'];
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
          message['text'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Widget for input field at the bottom
  Widget buildInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.sentiment_satisfied_alt),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
