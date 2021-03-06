import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecase/usecase.dart';

import '../http/http.dart';
import '../models/models.dart';

class RemoteAuthentication  implements Authentication {
  final HttpClient httpClient;
  final String url;

  const RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final response = await httpClient.request(
        url: url,
        method: HttpMethod.post,
        body: RemoteAuthenticationParams.fromDomain(params).toMap(),
      );

      return RemoteAccountModel.fromJson(response).toEntity();
    } on HttpError catch(error) {
      throw error == HttpError.unauthorized
        ? DomainError.invalidCredentials
        : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  const RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toMap() => {'email': this.email, 'password': this.password};
}