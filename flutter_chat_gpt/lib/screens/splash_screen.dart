import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBKColor,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                color: appBarBKColor, borderRadius: BorderRadius.circular(100)),
            padding: const EdgeInsets.all(25),
            child: Image.asset(
              AssetsManager.chatBotImage1,
              width: 128,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
