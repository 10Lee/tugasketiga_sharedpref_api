class NewsModel {
  final String title;
  final String imageUrl;
  final String description;
  final String content;
  final String source;
  final DateTime publishedAt;

  NewsModel({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.content,
    required this.source,
    required this.publishedAt,
  });

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'],
      imageUrl: map['urlToImage'] ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
      description: map['description'],
      content: map['content'],
      publishedAt: DateTime.parse(map['publishedAt']),
      source: map['source']['name'] ?? 'Not Available',
    );
  }
}
