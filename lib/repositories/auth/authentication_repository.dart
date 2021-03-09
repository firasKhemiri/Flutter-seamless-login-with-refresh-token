import 'dart:async';
import 'dart:developer';

import 'package:flutter_login/common/graphql/graphql_config.dart';
import 'package:flutter_login/common/graphql/queries/bucket.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _queryMutation = LoginQueries();
  final _userRepository = UserRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    try {
      final client = GraphQLService(null);
      final result = await client.performQuery(
          _queryMutation.getTokenByUsername("firas", "delln5110"));

      _getUserfromData(result.data, 'tokenAuth');
      _controller.add(AuthenticationStatus.authenticated);
      log('logging rep ${result.data.toString()}');

      // Env.jwtToken = '''
      // ignore: lines_longer_than_80_chars
      //   eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImZpcmFzIiwiZXhwIjoxNjA4MjExNzYwLCJvcmlnSWF0IjoxNjA4MjExNzAwfQ.YQh4kfCPRANEh8di126NqtOiF3wsb7wxCQEfDwMnimg''';
      // Env.refreshToken = '213f398d5988a6b1dbf6af33c616af8d032667512';

      final token = result.data['tokenAuth']['token'].toString();
      final refreshToken = result.data['tokenAuth']['refreshToken'].toString();
      final credentials = {
        'email': username,
        'password': password,
        'token': token,
        'refreshToken': refreshToken,
      };
      await _userRepository.persistUserCredentials(credentials);
    } catch (e) {
      log(e.toString());
      throw Exception('Wrong username or password');
    }
  }

  Future<void> signInWithRefreshToken() async {
    try {
      final client = GraphQLService(null);
      final result = await client
          .performMutation(await _queryMutation.getTokenFromRefreshToken());
      _getUserfromData(result.data, 'refreshToken');

      final token = result.data['refreshToken']['token'].toString();
      final refreshToken =
          result.data['refreshToken']['refreshToken'].toString();
      final credentials = {
        'token': token,
        'refreshToken': refreshToken,
      };
      await _userRepository.persistUserCredentials(credentials);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception('Invalid refresh token');
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  User _getUserfromData(dynamic data, String type) {
    final dynamic user = data[type]['payload'];
    return User(name: user['username'].toString(), id: 1, imageUrl: null);
  }
}
