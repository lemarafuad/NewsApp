import 'dart:convert';

List<NewsArticle> newsArticleFromJson(String str) {
  final jsonData = json.decode(str);
  // التحقق من وجود المقالات في الاستجابة
  if (jsonData['articles'] == null) {
    return [];
  }
  return List<NewsArticle>.from(
    jsonData['articles'].map(
      (x) => NewsArticle.fromJson(Map<String, dynamic>.from(x)),
    ),
  );
}

class NewsArticle {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  NewsArticle({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
    source: Source.fromJson(json["source"]),
    author: json["author"] ?? "Unknown", // تعيين قيمة افتراضية في حال كانت null
    title: json["title"] ?? "No title available", // تعيين قيمة افتراضية
    description:
        json["description"] ??
        "No description available", // تعيين قيمة افتراضية
    url: json["url"] ?? "", // تعيين قيمة فارغة إذا كانت null
    urlToImage: json["urlToImage"], // هذا يمكن أن يكون null بدون مشكلة
    publishedAt:
        DateTime.tryParse(json["publishedAt"] ?? DateTime.now().toString()) ??
        DateTime.now(), // استخدام tryParse للتأكد من تاريخ صالح
    content: json["content"] ?? "", // تعيين قيمة فارغة إذا كانت null
  );
}

class Source {
  dynamic id;
  String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"] ?? "No source name", // تعيين قيمة افتراضية إذا كانت null
  );
}
