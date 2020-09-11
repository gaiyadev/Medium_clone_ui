import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:medium_app/services/url_formater.dart';

final storage = new FlutterSecureStorage();

class NetworkHelper {
  var logger = Logger();

  Future<dynamic> getData(String url) async {
    url = UrlFormater.urlFormater(url);
    String token = await storage.read(key: 'token');
    try {
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        logger.i(response.body);
        return decodeData;
      } else {
        logger.d(response.statusCode);
      }
    } catch (err) {
      throw err;
    }
  }

  //User registration
  Future<http.Response> postData(String url, Map<String, String> body) async {
    url = UrlFormater.urlFormater(url);
    String token = await storage.read(key: 'token');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (err) {
      throw err;
    }
  }

  Future<http.StreamedResponse> patchImge(String url, String filePath) async {
    url = UrlFormater.urlFormater(url);
    String token = await storage.read(key: 'token');
    var request = http.MultipartRequest('PATCH ', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('img', filePath));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    var response = request.send();
    return response;
  }
}
