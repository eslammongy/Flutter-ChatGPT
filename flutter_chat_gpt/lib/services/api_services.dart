import 'dart:convert';
import 'dart:io';

import 'package:flutter_chat_gpt/constants/api_constant.dart';
import 'package:flutter_chat_gpt/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    var parsedUrl = Uri.parse("$baseUrl/models");
    try {
      var response = await http
          .get(parsedUrl, headers: {"Authorization": "Bearer $apiKey"});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List modelsList = [];
      for (var model in jsonResponse['data']) {
        modelsList.add(model);
        print(model['id']);
      }

      return ModelsModel.modelsFromSnapshot(modelsList);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
