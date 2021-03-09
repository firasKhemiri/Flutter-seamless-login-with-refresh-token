import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

import 'feed_events.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvents, FeedState> {
  FeedBloc({
    @required AuthenticationRepository authenticationRepository,
    @required FeedRepository feedRepository,
  })  : assert(authenticationRepository != null),
        assert(feedRepository != null),
        _authenticationRepository = authenticationRepository,
        _feedRepository = feedRepository,
        super(const FeedState.loading()) {
    _feedStatusSubscription = _feedRepository.status.listen(
      (status) => add(FeedStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final FeedRepository _feedRepository;
  StreamSubscription<FeedStatus> _feedStatusSubscription;

  @override
  Stream<FeedState> mapEventToState(
    FeedEvents event,
  ) async* {
    if (event is FeedStatusChanged) {
      yield* _mapAuthenticationStatusChangedToState(event);
    }
  }

  @override
  Future<void> close() {
    _feedStatusSubscription?.cancel();
    _feedRepository.dispose();
    return super.close();
  }

  Stream<FeedState> _mapAuthenticationStatusChangedToState(
    FeedStatusChanged event,
  ) async* {
    if (event.status == FeedStatus.load) {
      yield* _fetchFeed(event);
    }

    if (event.status == FeedStatus.notloaded) {
      yield* _mapFeedNotLoadededToState(state.message);
    }

    if (event.status == FeedStatus.loading) {
      yield* _mapFeedLoadedingToState(event);
    }

    if (event.status == FeedStatus.loaded) {
      yield* _mapFeedLoadedToState(state.post);
    }
  }

  Stream<FeedState> _fetchFeed(FeedStatusChanged event,
      {int retries = 0}) async* {
    try {
      final feed = await _feedRepository.getPost();
      yield FeedState.loaded(feed);
    } catch (e) {
      log('fail num: $retries ${e.toString()}');
      retries++;

      if (retries < 2)
        try {
          await _authenticationRepository.signInWithRefreshToken();
          yield* _fetchFeed(event, retries: retries);
        } catch (e) {
          yield const FeedState.notLoaded('Failed to authenticate');
          log('Failed to authenticate');
        }
      else {
        yield const FeedState.notLoaded('Error: Max retries exceeded');
        // _authenticationRepository.logOut();
      }
    }
  }

  Stream<FeedState> _mapFeedLoadedToState(Post feed) async* {
    yield FeedState.loaded(feed);
  }

  Stream<FeedState> _mapFeedLoadedingToState(FeedStatusChanged event) async* {
    yield const FeedState.loading();
  }

  Stream<FeedState> _mapFeedNotLoadededToState(String message) async* {
    yield FeedState.notLoaded(message);
  }
}
