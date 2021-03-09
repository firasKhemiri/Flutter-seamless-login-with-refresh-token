import 'package:flutter/cupertino.dart';
import 'package:flutter_login/models/user/user.dart';

import 'like.dart';

class Comment {
  final String content;
  final User user;
  final DateTime commentedAt;
  List<Reaction> reactions;

  bool isLikedBy(User user) {
    return reactions.any((like) => like.user.name == user.name);
  }

  void toggleLikeFor(User user) {
    if (isLikedBy(user)) {
      reactions.removeWhere((like) => like.user.name == user.name);
    } else {
      reactions.add(Reaction(user: user));
    }
  }

  Comment({
    @required this.user,
    @required this.content,
    @required this.commentedAt,
    this.reactions,
  });

  // static Comment fromJson(dynamic json) {
  //   User jsonUser = User.fromJsonMin(json["user"]);
  //   return Comment(
  //     user: jsonUser,
  //     content: json["content"],
  //     commentedAt: DateTime(2019, 5, 23, 14, 35, 0),
  //   );
  // }
}
