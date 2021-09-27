abstract class MissionsEvents {}

class MissionsEventsLoading extends MissionsEvents {
  final String searchStr;
  MissionsEventsLoading({required this.searchStr}) : assert(searchStr != null);
}

class MissionsEventsLoadingMore extends MissionsEvents {
  final int offset;

  MissionsEventsLoadingMore({required this.offset}) : assert(offset != null);
}

class MissionsEventsLoaded extends MissionsEvents {}

class MissionsEventsError extends MissionsEvents {}
