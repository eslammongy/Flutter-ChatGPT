// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_chat_gpt/services/helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.msg,
    required this.msgIndex,
    required this.isImage,
  }) : super(key: key);
  final String msg;
  final int msgIndex;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: Material(
            color: msgIndex == 0 ? cardItemBKColor2 : cardItemBKColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    msgIndex == 0
                        ? AssetsManager.developerImage
                        : AssetsManager.chatGptLogo,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: msgIndex == 0
                          ? TextWidget(
                              label: msg,
                              color: cardTextInColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )
                          : isImage
                              ? AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      msg,
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : const SpinKitThreeBounce(
                                                      color: Colors.indigo,
                                                      size: 18,
                                                    ),
                                    ),
                                  ),
                                )
                              : DefaultTextStyle(
                                  style: TextStyle(
                                    color: cardTextInColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: false,
                                    repeatForever: false,
                                    displayFullTextOnTap: true,
                                    totalRepeatCount: 1,
                                    animatedTexts: [
                                      TyperAnimatedText(msg.trim())
                                    ],
                                  ),
                                )),
                  msgIndex == 0
                      ? const SizedBox.shrink()
                      : isImage
                          ? IconButton(
                              onPressed: () async {
                               // downloadImage(imageUrl: msg, context: context);
                              },
                              icon: Icon(
                                Icons.download_rounded,
                                color: cardTextColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                final textValue = ClipboardData(text: msg);
                                Clipboard.setData(textValue).whenComplete(() =>
                                    Helper.showMsg(
                                        text: "Text Copied Successfully",
                                        color: Colors.indigo,
                                        context: context));
                              },
                              icon: Icon(
                                Icons.copy,
                                color: cardTextColor,
                              ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

/*  downloadImage(
      {required String imageUrl, required BuildContext context}) async {
    try {
      var imageId =
          await ImageDownloader.downloadImage(imageUrl).catchError((error) {
        if (error is PlatformException) {
          var path = "";
          if (error.code == "404") {
            Helper.showMsg(
                text: "Not Found Error.", color: Colors.red, context: context);
          } else if (error.code == "unsupported_file") {
            Helper.showMsg(
                text: "UnSupported FIle Error.",
                color: Colors.red,
                context: context);
          } else {
            Helper.showMsg(
                text: "UnSupported FIle Error.",
                color: Colors.red,
                context: context);
          }
        }
      });
      if (imageId == null) {
        return;
      }

      Helper.showMsg(
          text: "Text Copied Successfully",
          color: Colors.indigo,
          context: context);
    } on PlatformException catch (error) {
      Helper.showMsg(
          text: error.toString().substring(1, 40),
          color: Colors.indigo,
          context: context);
    }
  }*/
}
