import 'package:http/http.dart' as http;
import 'dart:convert';

class SendData {
  SendData();
  Future<http.Response> goData(String url, Object object) async {
    return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(object),
    );
  }
}
