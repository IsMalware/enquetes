import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_forDev/data/http/http.dart';

class HttpAdapter {
  final Client client;

  const HttpAdapter(this.client);

  Future<void> request({String url, HttpMethod method, Map body}) async {
    switch (method) {
      case HttpMethod.post:
        client.post(url);
        break;
      default:
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    setUp(() {});

    test('Deve chamar post com os valores corretos', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut.request(
        url: url,
        method: HttpMethod.post
      );

      verify(client.post(url));
    });
  });
}