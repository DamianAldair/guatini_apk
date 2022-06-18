class ActivityModel {
  final int? id;
  final String? activity;

  const ActivityModel({
    required this.id,
    required this.activity,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> json) => ActivityModel(
        id: json["id"],
        activity: json["activity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "activity": activity,
      };
}
