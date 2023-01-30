import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/api_services.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_chat_gpt/services/helper.dart';
import 'package:flutter_chat_gpt/widgets/chat_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider/models_provider.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool userIsTyping = false;
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
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);

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
              color: cardTextInColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Helper.showBottomSheet(context: context);
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: cardTextInColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(children: [
        Flexible(
          child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  msg: chatMessages[index]['msg'].toString(),
                  msgIndex:
                      int.parse(chatMessages[index]['chatIndex'].toString()),
                );
              }),
        ),
        if (userIsTyping) ...[
          const SpinKitThreeBounce(
            color: Colors.indigo,
            size: 18,
          ),
        ],
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: cardItemBKColor,
                borderRadius: BorderRadius.circular(50)),
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
                    onPressed: () async {
                      try {
                        setState(() {
                          userIsTyping = true;
                        });
                        await ApiServices.getChatResponse(
                            msg: _textEditingController.text,
                            modelID: modelsProvider.currentModelName);
                      } catch (e) {
                        log('That Error Happened When Calling API $e');
                      } finally {
                        setState(() {
                          userIsTyping = false;
                        });
                      }
                    },
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
      ])),
    );
  }
}
