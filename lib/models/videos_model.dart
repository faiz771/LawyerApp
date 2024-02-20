class Video {
  final int id;
  final String title;
  final String media;
  final String mediaType;
  final String mediaAppPath;
  final String content;
  final String blogType;
  final String? status;
  final String thumbnail;
  final int is_favorite;
  final DateTime createdAt;
  final DateTime updatedAt;

  Video({
    required this.id,
    required this.title,
    required this.media,
    required this.mediaType,
    required this.mediaAppPath,
    required this.content,
    required this.blogType,
    required this.is_favorite,
    this.status,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['blog_title'],
      media: json['media'],
      mediaType: json['media_type'],
      mediaAppPath: json['media_app_path'],
      content: json['content'],
      blogType: json['blog_type'],
      status: json['status'],
      is_favorite: json['is_favorite'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
