import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_forDev/data/http/http.dart';
import 'package:flutter_forDev/infra/http/http.dart';

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

  group('compartilhado', () {});

  group('post', () {

    PostExpectation mockRequest() => when(
      client.post(any, body: anyNamed('body'), headers: anyNamed('headers'))
    );

    void mockResponse(int statusCode, {String body: '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Deve chamar post com os valores corretos', () async {
      await sut.request(url: url, method: HttpMethod.post, body: {'any_key': 'any_value'});

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
      await sut.request(url: url, method: HttpMethod.post);

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });

    test('Deve chamar post e retornar 200 com dados', () async {
      final response = await sut.request(url: url, method: HttpMethod.post);

      expect(response, {'any_key': 'any_value'});
    });

    test('Deve chamar post e retornar nulo se 200 sem dados', () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: HttpMethod.post);

      expect(response, null);
    });

    test('Deve chamar post e retornar nulo se 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: HttpMethod.post);

      expect(response, null);
    });

    test('Deve chamar post e retornar nulo se 204 com dados', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: HttpMethod.post);

      expect(response, null);
    });

    test('Deve chamar post e retornar BadRequestError se 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Deve chamar post e retornar UnauthorizedError se 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Deve chamar post e retornar ForbiddenError se 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Deve chamar post e retornar NotFoundError se 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.notFound));
    });

    test('Deve chamar post e retornar ServerError se 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.serverError));
    });

    test('Deve chamar post e retornar ServerError para qualquer outro status', () async {
      mockResponse(604);

      final future = sut.request(url: url, method: HttpMethod.post);

      expect(future, throwsA(HttpError.serverError));
    });
  });
}