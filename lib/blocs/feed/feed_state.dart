import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

class FeedState extends Equatable {
  const FeedState._({this.status, this.post, this.message});

  const FeedState.load() : this._(status: FeedStatus.load);

  const FeedState.loading() : this._(status: FeedStatus.loading);

  const FeedState.loaded(Post post)
      : this._(status: FeedStatus.loaded, post: post);

  const FeedState.notLoaded(String message)
      : this._(status: FeedStatus.notloaded, message: message);

  final FeedStatus status;
  final Post post;
  final String message;

  @override
  List<Object> get props => [status, post, message];
}
