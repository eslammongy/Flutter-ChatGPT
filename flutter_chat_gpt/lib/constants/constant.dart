import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';

Color scaffoldBKColor = const Color(0xFFFAF8F1);
Color cardItemBKColor = const Color(0xFFC3C3C3);
Color cardItemBKColor2 = const Color(0xFFDBDBDB);
Color cardTextColor = const Color(0xFFFFFBEB);
Color cardTextInColor = const Color(0xFF282828);

List<String> listOfModels = [
  "Model Test 1",
  "Model Test 2",
  "Model Test 3",
  "Model Test 4",
  "Model Test 5",
  "Model Test 6",
  "Model Test 7",
  "Model Test 8",
  "Model Test 9",
];

List<DropdownMenuItem<String>>? get getModelItems {
  List<DropdownMenuItem<String>>? modelItems =
      List<DropdownMenuItem<String>>.generate(
    listOfModels.length,
    (index) => DropdownMenuItem(
      value: listOfModels[index],
      child: TextWidget(
        label: listOfModels[index],
        fontSize: 15,
      ),
    ),
  );
  return modelItems;
}

final chatMessages = [
  {
    "msg": "Hello who are you?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
    "chatIndex": 1,
  },
  {
    "msg": "What is flutter?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
    "chatIndex": 1,
  },
  {
    "msg": "Okay thanks",
    "chatIndex": 0,
  },
  {
    "msg":
        "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
    "chatIndex": 1,
  },
];
