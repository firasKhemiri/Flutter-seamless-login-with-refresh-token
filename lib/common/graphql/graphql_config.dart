import 'package:graphql/client.dart';
import '../../env.dart';

class GraphQLService {
  GraphQLService(String token) {
    Link _link;
    final _httpLink = HttpLink(
      Env.uri,
    );

    if (token != null) {
      final authLink = AuthLink(
        getToken: () => 'JWT $token',
      );

      _link = authLink.concat(_httpLink);
    } else {
      _link = _httpLink;
    }

    _client = GraphQLClient(
      link: _link,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  GraphQLClient _client;

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    var options = QueryOptions(document: gql(query));
    final result = await _client.query(options);
    return result;
  }

  Future<QueryResult> performMutation(String query) async {
    var options = MutationOptions(document: gql(query));
    final result = await _client.mutate(options);
    return result;
  }
}
