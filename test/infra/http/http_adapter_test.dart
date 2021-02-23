import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_forDev/data/http/http.dart';

class HttpAdapter {
  final Client client;

  const HttpAdapter(this.client);

  Future<void> request({String url, HttpMethod method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    switch (method) {
      case HttpMethod.post:
        client.post(url, headers: headers);
        break;
      default:
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    HttpAdapter sut;
    ClientSpy client;
    String url;

    setUp(() {
      client = ClientSpy();
      sut = HttpAdapter(client);
      url = faker.internet.httpUrl();
    });

    test('Deve chamar post com os valores corretos', () async {
      await sut.request(
        url: url,
        method: HttpMethod.post
      );

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));
    });
  });
}