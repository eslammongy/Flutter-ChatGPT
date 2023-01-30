import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/provider/chat_provider.dart';
import 'package:flutter_chat_gpt/provider/models_provider.dart';
import 'package:flutter_chat_gpt/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ModelsProvider())),
        ChangeNotifierProvider(create: ((context) => ChatProvider()))
      ],
      child: MaterialApp(
        title: 'Chat Gpt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBKColor,
            appBarTheme: AppBarTheme(
                color: appBarBKColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: appBarBKColor, // <-- SEE HERE
                  statusBarIconBrightness:
                      Brightness.dark, //<-- For Android SEE HERE (dark icons)
                  statusBarBrightness:
                      Brightness.light, //<-- For iOS SEE HERE (dark icons)
                ),
                elevation: 2.2,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: scaffoldBKColor,
                    letterSpacing: 1.2))),
        home: const SplashScreen(),
      ),
    );
  }
}
