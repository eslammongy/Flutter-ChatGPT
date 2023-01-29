import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_gpt/models/models_model.dart';
import 'package:flutter_chat_gpt/services/api_services.dart';

class ModelsProvider extends ChangeNotifier {
  List<ModelsModel> _modelsList = [];
  List<ModelsModel> get modelsList => _modelsList;

  String _currentModelName = "text-davinci-003";
  String get currentModelName => _currentModelName;

  void setModelName(String newModel) {
    _currentModelName = newModel;
    notifyListeners();
  }

  Future<List<ModelsModel>> getChatModels() async {
    _modelsList = await ApiServices.getModels();
    return _modelsList;
  }
}
