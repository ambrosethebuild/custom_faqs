class Faq {
  Faq({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedDate,
    required this.formattedUpdatedDate,
  });

  int id;
  String title;
  String body;
  dynamic type;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String formattedUpdatedDate;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"],
        formattedUpdatedDate: json["formatted_updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "formatted_updated_date": formattedUpdatedDate,
      };
}
