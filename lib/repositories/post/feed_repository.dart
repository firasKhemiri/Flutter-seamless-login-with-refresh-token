import 'dart:async';
import 'dart:developer';
import 'package:flutter_login/common/graphql/graphql_config.dart';
import 'package:flutter_login/common/graphql/queries/bucket.dart';
import 'package:flutter_login/common/storage/secure_storage.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';

enum FeedStatus { loading, load, notloaded, loaded }

class FeedRepository {
  final _controller = StreamController<FeedStatus>();
  final _queryMutation = QueryMutation();
  final _userRepository = UserRepository();

  Stream<FeedStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // yield FeedStatus.notloaded;
    yield* _controller.stream;
  }

  Future<Post> getPost() async {
    try {
      final client = GraphQLService(await _userRepository.getToken());
      final result = await client.performQuery(_queryMutation.getPostsQuery());
      log(result.data.toString());
      if (result.data.toString() == 'null') {
        log('null post from endpoint');
        throw Exception();
      } else {
        log('all good from endpoint');
        _controller.add(FeedStatus.loaded);
        return const Post(id: 2);
      }
    } catch (e) {
      throw Exception('An issue occured');
    }
  }

  void dispose() => _controller.close();
}
