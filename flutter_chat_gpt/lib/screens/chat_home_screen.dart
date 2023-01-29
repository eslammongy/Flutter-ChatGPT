import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool userIsTyping = true;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBKColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(AssetsManager.chatBotImage1),
        ),
        title: Text(
          "ChatGPT",
          style: TextStyle(
              color: cardItemBKColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: cardItemBKColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(children: [
        Flexible(
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Text("data");
              }),
        ),
        if (userIsTyping) ...[
          const SpinKitThreeBounce(
            color: Colors.indigo,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: cardItemBKColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      onSubmitted: (value) {},
                      style: TextStyle(color: cardTextColor),
                      decoration: const InputDecoration.collapsed(
                          hintText: "How can i help you ?",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image_search_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ]
      ])),
    );
  }
}
