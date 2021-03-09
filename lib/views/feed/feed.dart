import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

import '../../repositories/post/feed_repository.dart';

class Feed extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Feed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: RepositoryProvider.value(
            value: FeedRepository,
            child: BlocProvider(
              create: (_) => FeedBloc(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                  feedRepository: FeedRepository())
                ..add(FeedStatusChanged(FeedStatus.load)),
              child: FeedView(),
            )),
      ),
    );
  }
}

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    final hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
              log('state status ${state.status}');
              if (state.status == FeedStatus.loading) {
                return const CircularProgressIndicator();
              }
              if (state.status == FeedStatus.loaded) {
                return Text('wazzupp ${state.post.id}', style: hugeStyle);
              }
              if (state.status == FeedStatus.notloaded) {
                return Text('${state.message}');
              }
              return const Text('Something went wrong');
            }),
          ],
        ),
      ),
    );
  }
}
