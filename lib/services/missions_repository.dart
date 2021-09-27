import 'package:app_01/app_config.dart';
import 'package:app_01/models/mission_model.dart';
import 'package:app_01/services/missions_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MissionsRepository {
  GraphQLClient? _client;
  QueryOptions? qFetchOptions;
  QueryResult? qFetchResult;

  MissionsRepository() {
    final HttpLink link = HttpLink(AppConfig.graphqlEndpoint);

    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  //
  Future<List<MissionModel>> fetchMissions({required searchStr}) async {
    qFetchOptions = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
      document: gql(MissionsQueries().qFetchMissions),
      variables: <String, dynamic>{'offset': 0, "mission_name": searchStr, 'limit': AppConfig.limitPerPage},
    );

    qFetchResult = await _client!.query(qFetchOptions!);
    if (qFetchResult!.hasException) {
      throw Exception();
    }

    List<MissionModel> missions =
        qFetchResult!.data!['launches'].map<MissionModel>((missionJsonData) => MissionModel.fromJson(missionJsonData)).toList();

    return missions;
  }

  //
  Future<List<MissionModel>> fetchMoreMissions(int offset) async {
    FetchMoreOptions qFetchMoreOptions = FetchMoreOptions(
      variables: {'offset': offset},
      updateQuery: (previousResultData, fetchMoreResultData) {
        final List<dynamic> repos = [...previousResultData!['launches'] as List<dynamic>, ...fetchMoreResultData!['launches'] as List<dynamic>];
        fetchMoreResultData['launches'] = repos;
        return fetchMoreResultData;
      },
    );

    final qResult = await _client!.fetchMore(qFetchMoreOptions, originalOptions: qFetchOptions!, previousResult: qFetchResult!);
    if (qResult.hasException) {
      throw Exception();
    }

    List<MissionModel> missions = qResult.data!['launches'].map<MissionModel>((missionJsonData) => MissionModel.fromJson(missionJsonData)).toList();

    return missions;
  }
}
