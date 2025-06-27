class News {
  final String title;
  final String shortDescription;
  final String thumbnail;
  final String url;
  final String articleContent;
  final String mainImage;

  News({
    required this.title,
    required this.shortDescription,
    required this.thumbnail,
    required this.url,
    required this.articleContent,
    required this.mainImage,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      shortDescription: json['short_description'],
      thumbnail: json['thumbnail'],
      url: json['article_url'],
      articleContent: json['article_content'],
      mainImage: json['main_image'],
    );
  }
}
