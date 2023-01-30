import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

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
                      ) :DefaultTextStyle(
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
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
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
}
