import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdapter  implements HttpClient {
  final Client client;

  const HttpAdapter(this.client);

  @override
  Future<Map> request({
    @required String url,
    @required HttpMethod method,
    Map body
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;

    switch (method) {
      case HttpMethod.post:
        final response = await client.post(url, headers: headers, body: jsonBody);

        if(response.statusCode == 200){
          return response.body.isEmpty ? null : jsonDecode(response.body);
        } else {
          return null;
        }

        break;
      case HttpMethod.get:
        break;
      case HttpMethod.put:
        break;
      case HttpMethod.delete:
        break;
    }
  }

}