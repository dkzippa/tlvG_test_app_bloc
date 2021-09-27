import 'package:app_01/bloc/missions_events.dart';
import 'package:app_01/bloc/missions_state.dart';
import 'package:app_01/models/mission_model.dart';
import 'package:app_01/services/missions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionsBloc extends Bloc<MissionsEvents, MissionsState> {
  final MissionsRepository repository;

  MissionsBloc({required this.repository})
      : assert(repository != null),
        super(MissionsStateEmpty());

  @override
  Stream<MissionsState> mapEventToState(MissionsEvents event) async* {
    print('mapEventToState: ' + event.toString());

    if (event is MissionsEventsLoading) {
      //
      yield MissionsStateLoading();

      try {
        final List<MissionModel> missions = await repository.fetchMissions(searchStr: event.searchStr);

        yield MissionsStateLoaded(missions: missions);

        //
      } on Exception catch (error) {
        print('ERROR MissionsBloc-> repository.fetchMissions(): ' + error.toString());
        yield MissionsStateError(error: error);
      }
    } else if (event is MissionsEventsLoadingMore) {
      //
      // yield MissionsStateLoading();

      try {
        final List<MissionModel> missions = await repository.fetchMoreMissions(event.offset);
        yield MissionsStateLoaded(missions: missions);
      } on Exception catch (error) {
        print('ERROR MissionsBloc-> repository.fetchMoreMissions(): ' + error.toString());
        yield MissionsStateError(error: error);
      }
    } else {
      yield MissionsStateEmpty();
    }
  }
}
