import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    // this.stories = const <Story>[],
  });
  static const empty = User(id: 2, name: '', imageUrl: '');

  final int id;
  final String name;

  final String imageUrl;
  // final List<Story> stories;

  @override
  List<Object> get props => [id];

  static User fromJsonMin(dynamic json) {
    return User(
      id: int.parse(json["id"].toString()),
      name: "${json["firstName"]} ${json["lastName"]}",
      imageUrl: json["picture"].toString(),
    );
  }

  User _getUserfromData(dynamic data, String type) {
    dynamic user = data[type]['payload'];
    return User(id: 1, name: user['username'].toString(), imageUrl: null);
  }
}
