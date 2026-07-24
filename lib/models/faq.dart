class Faq {
  Faq({
    required this.title,
    required this.body,
    this.link,
  });

  String title;
  String body;
  String? link;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        title: json["title"],
        body: json["body"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "link": link,
      };
}
