import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/screens/chat_home_screen.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ChatHome()));
      timer.cancel();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBKColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
                decoration: BoxDecoration(
                    color: appBarBKColor,
                    borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  AssetsManager.splashImage,
                  width: 128,
                  fit: BoxFit.contain,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextWidget(
            label: "ChatGPT..",
            fontSize: 25,
          )
        ],
      ),
    );
  }
}
