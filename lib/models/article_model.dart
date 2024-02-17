class Article {
  final int id;
  final String title;
  final String media;
  final String mediaType;
  final String mediaAppPath;
  final String content;
  final String blogType;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.media,
    required this.mediaType,
    required this.mediaAppPath,
    required this.content,
    required this.blogType,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['blog_title'],
      media: json['media'],
      mediaType: json['media_type'],
      mediaAppPath: json['media_app_path'],
      content: json['content'],
      blogType: json['blog_type'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
