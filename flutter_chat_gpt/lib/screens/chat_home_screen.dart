import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/models/chat_model.dart';
import 'package:flutter_chat_gpt/provider/chat_provider.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_chat_gpt/services/helper.dart';
import 'package:flutter_chat_gpt/widgets/chat_widget.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';
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
  List<ChatModel> chatResList = [];
  late FocusNode focusNode;
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    _textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

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
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: chatProvider.chatModelList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  msg: chatProvider.chatModelList[index].message,
                  msgIndex: chatProvider.chatModelList[index].msgIndex,
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
                    focusNode: focusNode,
                    controller: _textEditingController,
                    onSubmitted: (value) {},
                    style: TextStyle(color: cardTextColor, fontSize: 18),
                    decoration: const InputDecoration.collapsed(
                        hintText: "How can i help you ?",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await sendMsgToGpt(
                          provider: modelsProvider, chatProvider: chatProvider);
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

  void scrollToEndOfList() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeIn);
  }

  Future<void> sendMsgToGpt(
      {required ModelsProvider provider,
      required ChatProvider chatProvider}) async {
    if (_textEditingController.text.isEmpty) {
      if (_textEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: TextWidget(
              label: "Please type a message",
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }
    try {
      setState(() {
        userIsTyping = true;
        chatProvider.addingUserMsg(msg: _textEditingController.text);
        _textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.getChatResponse(
          msg: _textEditingController.text, modelID: provider.currentModelName);
      setState(() {});
    } catch (e) {
      log('That Error Happened When Calling API $e');
    } finally {
      setState(() {
        scrollToEndOfList();
        userIsTyping = false;
      });
    }
  }
}
