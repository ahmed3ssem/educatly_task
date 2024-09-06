import 'package:educatly_task/config/PrefHelper/prefs.dart';
import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/feature/chat/data/models/message_model.dart';
import 'package:educatly_task/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:educatly_task/widgets/empty_data_widget.dart';
import 'package:educatly_task/widgets/svg_image_widget.dart';
import 'package:educatly_task/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {

  String receiverId;
  String receiverEmail;
  ChatScreen({super.key , required this.receiverId , required this.receiverEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _sendMessageController = TextEditingController();
  String uid = '' , email = '';
  List<Map<String, dynamic>> chatHistory = [];

  @override
  void initState() {
    super.initState();
    getUserData();
    getData();
  }

  getUserData(){
    uid = Prefs.getString(AppStrings.userId);
    email = Prefs.getString(AppStrings.email);
  }

  getData()=>context.read<ChatCubit>().getChatHistory(widget.receiverId);

  Widget checkState(ChatState state){
    if(state is ChatIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is ChatError){
      return const EmptyDataWidget();
    } else if(state is ChatHistoryLoaded) {
      chatHistory = state.chatHistory;
      return chatWidget();
    } else {
      return chatWidget();
    }
  }

  Widget chatWidget(){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: chatHistory.length,
            itemBuilder: (context, index) {
              bool isSender = chatHistory[index]['senderId'] == uid;
              return ChatBubble(message: chatHistory[index], isSender: isSender,);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildInputField(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ChatCubit , ChatState>(builder: (context , state){
      return Scaffold(
        backgroundColor: const Color(0xFF000000), // Background color
        appBar: AppBar(
          backgroundColor: const Color(0xFF8F47FE),
          elevation: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: SvgPicture.asset(
                    AssetsManager.backIcon,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain, // Ensures the icon scales proportionally
                  ),
              )
            ],
          ),
          title: TextWidget(text: widget.receiverEmail,fontSize: 17.fSize,fontWeight: FontWeight.w600,),
          automaticallyImplyLeading: false,
          actions: [
            CircleAvatar(
              backgroundImage: const AssetImage(AssetsManager.logo),
              radius: 20.adaptSize,
            ),
            SizedBox(width: 16.w),
          ],
        ),
        body: checkState(state),
      );
    });
  }

  Widget buildInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              decoration: InputDecoration(
                hintText: 'Type a message'.tr,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if(_sendMessageController.value.text.isNotEmpty){
                Message message = Message(senderId: uid, messageId: '', message: _sendMessageController.value.text.toString(), timestamp: 0);
                chatHistory.add(message.toMap());
                context.read<ChatCubit>().sendMessage(uid, widget.receiverId, _sendMessageController.value.text.toString());
                _sendMessageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
