class MissionsQueries {
  final String qFetchMissions = """
      query Launches(\$mission_name: String!, \$limit: Int!, \$offset: Int!) {        
        launches(find: {mission_name:\$mission_name}, limit: \$limit, offset: \$offset, sort: "launch_year") {
          id
          mission_name
          details                              
          launch_success
          launch_year
        }        
      }
    """;
}
