class MissionModel {
  final String? id;
  final String? name;
  final String? details;
  final String? launchYear;
  final bool? launchSuccess;

  MissionModel({this.id, this.name, this.details, this.launchYear, this.launchSuccess});

  factory MissionModel.fromJson(Map<String, dynamic> missionJson) {
    return MissionModel(
      id: missionJson['id'],
      name: missionJson['mission_name'],
      details: missionJson['details'] ?? '',
      launchYear: missionJson['launch_year'] ?? 'unknown',
      launchSuccess: missionJson['launch_success'] ?? true, // i believe in Elon)
    );
  }
}
