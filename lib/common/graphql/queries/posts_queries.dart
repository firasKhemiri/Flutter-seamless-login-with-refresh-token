class QueryMutation {
  String getPostsQuery() {
    return """
    query {
      stories{
          id,
          image{id,path},
          creator{id, firstName, lastName, picture},
          dateCreated,
      },
      posts{
        id,
        description,
        creator{id, firstName, lastName, picture},
        dateCreated,
        images{
            id,
            path
        },

        reactions{
            reactionType,
            user{id, username}
        },

        comments{
            id,
            content,
            dateCreated,
            user{id, firstName, lastName, picture}
            reactions{reactionType, user{id, username}},
        }
      }
    }
    """;
  }
}
