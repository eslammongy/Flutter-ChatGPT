import 'dart:convert';
import 'dart:io';

import 'package:flutter_chat_gpt/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<void> getModels() async {
    var parsedUrl = Uri.parse("$baseUrl/models");
    try {
      var response = await http
          .get(parsedUrl, headers: {"Authorization": "Bearer $apiKey"});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      print(jsonResponse);
    } catch (e) {
      print(e);
    }
  }
}
