import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/widgets/drop_downmenu.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';

import '../constants/constant.dart';

class Helper {
  static Future<void> showBottomSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        backgroundColor: cardItemBKColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                    child: TextWidget(
                  label: "Choose Model",
                  fontSize: 16,
                )),
                SizedBox(
                  width: 20,
                ),
                Flexible(flex: 2, child: ModelsDropDownMenu()),
              ],
            ),
          );
        });
  }
}
