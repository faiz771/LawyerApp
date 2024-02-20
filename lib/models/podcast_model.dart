class PodcastItem {
  final int id;
  final String title;
  final String media;
  final String mediaType;
  final String mediaAppPath;
  final String? thumbnail; // Change type to nullable String
  final String content;
  final String blogType;
  final String? status; // Change type to nullable String
  final int is_favorite;
  final String createdAt;
  final String updatedAt;

  PodcastItem({
    required this.id,
    required this.title,
    required this.media,
    required this.mediaType,
    required this.mediaAppPath,
    required this.is_favorite,
    this.thumbnail, // Update type to nullable String
    required this.content,
    required this.blogType,
    this.status, // Update type to nullable String
    required this.createdAt,
    required this.updatedAt,
  });

  factory PodcastItem.fromJson(Map<String, dynamic> json) {
    return PodcastItem(
      id: json['id'],
      title: json['blog_title'],
      media: json['media'],
      mediaType: json['media_type'],
      mediaAppPath: json['media_app_path'],
      thumbnail: json['thumbnail'], // No need for null check here
      content: json['content'],
      blogType: json['blog_type'],
      status: json['status'], // No need for null check here
      is_favorite: json['is_favorite'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
