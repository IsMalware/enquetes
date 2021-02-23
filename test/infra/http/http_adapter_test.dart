import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_forDev/data/http/http.dart';

class HttpAdapter {
  final Client client;

  const HttpAdapter(this.client);

  Future<void> request({
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
        client.post(
          url,
          headers: headers,
          body: jsonBody,
        );
        break;
      default:
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('Deve chamar post com os valores corretos', () async {
      await sut.request(
        url: url,
        method: HttpMethod.post,
        body: {'any_key': 'any_value'}
      );

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: '{"any_key":"any_value"}',
      ));
    });

    test('Deve chamar post sem o body', () async {
      await sut.request(
        url: url,
        method: HttpMethod.post,
      );

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });
  });
}