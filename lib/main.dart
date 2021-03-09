import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';
import 'package:flutter_login/blocs/simple_bloc_observer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  Bloc.observer = SimpleBlocObserver();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    feedRepository: FeedRepository(),
  ));
}
