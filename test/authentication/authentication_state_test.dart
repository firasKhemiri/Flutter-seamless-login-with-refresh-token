// ignore_for_file: prefer_const_constructors
import 'package:flutter_login/blocs/authentication/bucket.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {}

void main() {
  group('AuthenticationState', () {
    group('AuthenticationState.unknown', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.unknown(),
          AuthenticationState.unknown(),
        );
      });
    });

    group('AuthenticationState.authenticated', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          AuthenticationState.authenticated(user),
          AuthenticationState.authenticated(user),
        );
      });
    });

    group('AuthenticationState.unauthenticated', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.unauthenticated(),
          AuthenticationState.unauthenticated(),
        );
      });
    });
  });
}
