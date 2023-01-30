import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_gpt/models/chat_model.dart';

import '../services/api_services.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> _chatModelList = [];
  List<ChatModel> get chatModelList => _chatModelList;

  void addingUserMsg({required String msg}) {
    _chatModelList.add(ChatModel(message: msg, msgIndex: 0, isImage: false));
    notifyListeners();
  }

  Future<void> getChatResponse(
      {required String msg, required String modelID}) async {
    _chatModelList
        .addAll(await ApiServices.getChatResponse(msg: msg, modelID: modelID));
    notifyListeners();
  }

  Future<void> getChatResponseAsImage({required String msg}) async {
    var imageUrl = await ApiServices.getChatResponseAsImage(msg: msg);
    _chatModelList
        .add(ChatModel(message: imageUrl, msgIndex: 2, isImage: true));
    notifyListeners();
  }
}
