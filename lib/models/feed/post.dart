import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/models/user/user.dart';

import 'like.dart';
import 'comment.dart';

import 'package:timeago/timeago.dart' as timeago;

class Post extends Equatable {
  const Post({
    @required this.id,
    // this.imageUrls,
    // this.user,
    // this.postedAt,
    // this.reactions,
    // this.comments,
    // this.location,
  });

  static const empty = Post(id: 2);

  final int id;
  // List<String> imageUrls;
  // User user;
  // DateTime postedAt;

  // List<Reaction> reactions;
  // List<Comment> comments;
  // String location;

  @override
  List<Object> get props => [id];

  // String timeAgo() {
  //   final now = DateTime.now();
  //   return timeago.format(now.subtract(now.difference(postedAt)));
  // }

  // bool isReactedBy(User user) {
  //   return reactions.any((like) => like.user.name == user.name);
  // }

  // void addLikeIfUnlikedFor(User user) {
  //   if (!isReactedBy(user)) {
  //     reactions.add(Reaction(user: user));
  //   }
  // }

  // void toggleLikeFor(User user) {
  //   if (isReactedBy(user)) {
  //     reactions.removeWhere((like) => like.user.name == user.name);
  //   } else {
  //     addLikeIfUnlikedFor(user);
  //   }
  // }

  // static List<Post> postsFromJson(dynamic json ) {
  //   List<Post> posts = List<Post>();
  //   for (var i = 0; i < json.length; i++) {
  //     posts.add(Post.fromJson(json[i]));
  //   }
  //   return posts;
  // }

  // static Post fromJson(dynamic json) {
  //   User jsonUser = User.fromJsonMin(json["creator"]);

  //   final images = <String>[];
  //   for (var i = 0; i < json["images"].length; i++) {
  //     images.add(json["images"][i]["path"]);
  //   }

  //   final reactions = <Reaction>[];
  //   for (var i = 0; i < json["reactions"].length; i++) {
  //     reactions.add(Reaction.fromJson(json["reactions"][i]));
  //   }
  //   final comments = <Comment>[];
  //   for (var i = 0; i < json["comments"].length; i++) {
  //     comments.add(Comment.fromJson(json["comments"][i]));
  //   }

  //   return Post(
  //     id: int.parse(json["id"]),
  //     user: jsonUser,
  //     imageUrls: images,
  //     reactions: reactions,
  //     comments: comments,
  //     location: 'Earth',
  //     postedAt: DateTime(2019, 5, 23, 12, 35, 0),
  //   );
  // }
}
