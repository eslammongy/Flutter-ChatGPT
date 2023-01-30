import 'dart:convert';
import 'dart:io';
import 'package:flutter_chat_gpt/constants/api_constant.dart';
import 'package:flutter_chat_gpt/models/chat_model.dart';
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
      }
      return ModelsModel.modelsFromSnapshot(modelsList);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ChatModel>> getChatResponse(
      {required String msg, required String modelID}) async {
    var parsedUrl = Uri.parse("$baseUrl/completions");

    try {
      var response = await http.post(
        parsedUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelID,
            "prompt": msg,
            "max_tokens": 120,
          },
        ),
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatResponse = [];
      if (jsonResponse['choices'].length > 0) {
        //log("Chat Response ${jsonResponse['choices'][0]['text']}");
        chatResponse = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                message: jsonResponse['choices'][index]['text'],
                msgIndex: 1,
                isImage: false));
      }

      return chatResponse;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getChatResponseAsImage({required String msg}) async {
    var parsedUrl = Uri.parse("$baseUrl/images/generations");
    String imageUrl = "";
    try {
      var response = await http.post(
        parsedUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {"prompt": msg, "n": 1, "size": "1024x1024"},
        ),
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      if (jsonResponse['data'].length > 0) {
        // log("Image Url ${jsonResponse['data'][0]['url']}");
        imageUrl = jsonResponse['data'][0]['url'];
      }

      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
