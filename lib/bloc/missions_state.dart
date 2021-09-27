import 'package:app_01/models/mission_model.dart';

abstract class MissionsState {}

class MissionsStateLoading extends MissionsState {
  MissionsStateLoading() : super();
}

class MissionsStateLoaded extends MissionsState {
  final List<MissionModel>? missions;

  MissionsStateLoaded({required this.missions}) : assert(missions != null);
}

class MissionsStateError extends MissionsState {
  final error;
  MissionsStateError({required this.error}) : assert(error != null);
}

class MissionsStateEmpty extends MissionsState {}
