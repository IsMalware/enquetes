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

        return _hendleResponse(response);

        break;
      case HttpMethod.get:
        break;
      case HttpMethod.put:
        break;
      case HttpMethod.delete:
        break;
    }
  }

  Map _hendleResponse(Response response) {
    if(response.statusCode == 200){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    }
    
    const httpError = <int, HttpError> {
      204: null,
      400: HttpError.badRequest,
      401: HttpError.unauthorized,
      403: HttpError.forbidden,
      404: HttpError.notFound,
      500: HttpError.serverError,
    };

    throw httpError.containsKey(response.statusCode)
      ? httpError[response.statusCode]
      : httpError[500];
  }

}