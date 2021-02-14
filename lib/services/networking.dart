import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    dynamic data;
    try {
      http.Response res = await http.get(url);
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        data = jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
    return data;
  }
}
