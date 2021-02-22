import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  const AuthenticationParams({
    @required this.email,
    @required this.secret,
  });

  Map toMap() => {'email': this.email, 'password': this.secret};
}
