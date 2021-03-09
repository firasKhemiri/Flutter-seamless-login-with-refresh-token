import 'package:equatable/equatable.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

abstract class FeedEvents extends Equatable {
  const FeedEvents();

  @override
  List<Object> get props => null;
}

class FeedStatusChanged extends FeedEvents {
  FeedStatusChanged(this.status);

  final FeedStatus status;

  @override
  List<Object> get props => [status];
}
