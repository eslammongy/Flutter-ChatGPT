import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/screens/chat_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Gpt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBKColor,
          appBarTheme: AppBarTheme(
              color: Colors.deepPurple,
              elevation: 2.2,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: scaffoldBKColor,
                  letterSpacing: 1.2))),
      home: const ChatHome(),
    );
  }
}
