class NoteModel {
  final String id;
  final String title;
  final String subTitle;
  final String description;
  final String userId;
  final DateTime date;

  NoteModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.userId,
    required this.date,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json["_id"],
    title: json["title"],
    subTitle: json["subTitle"],
    description: json["description"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
  );
}
