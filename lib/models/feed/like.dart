import 'package:flutter/cupertino.dart';
import 'package:flutter_login/models/user/user.dart';

class Reaction {
  final User user;
  final String reactionType;

  Reaction({
    @required this.user,
    @required this.reactionType,
  });

  // static Reaction fromJson(dynamic json) {
  //   User jsonUser = User.fromJsonMin(json["user"]);
  //   return Reaction(
  //     user: jsonUser,
  //     reactionType: json["reactionType"],
  //   );
  // }
}
