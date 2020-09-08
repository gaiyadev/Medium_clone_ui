import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:medium_app/services/url_formater.dart';

class NetworkHelper {
  var logger = Logger();

  Future<dynamic> getData(String url) async {
    url = UrlFormater.urlFormater(url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        logger.i(response.body);
        return decodeData;
      } else {
        logger.d(response.statusCode);
        print(response.body);
      }
    } catch (err) {
      throw err;
    }
  }

  //User registration
  Future<dynamic> userAuth(String url, Map<String, String> body) async {
    url = UrlFormater.urlFormater(url);
    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var decodeData = data;
        return decodeData;
      } else {
        logger.d(response.statusCode);
        logger.d(response.body);
      }
    } catch (err) {
      throw err;
    }
  }
}
