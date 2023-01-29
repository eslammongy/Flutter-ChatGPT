import 'package:flutter/material.dart';

import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.msg,
    required this.msgIndex,
  }) : super(key: key);
  final String msg;
  final int msgIndex;

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
                    child: TextWidget(
                      label: msg,
                      color: cardTextInColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  msgIndex == 0
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.thumb_up_alt_rounded,
                              color: cardTextColor,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.thumb_down_alt_rounded,
                              color: cardTextColor,
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
