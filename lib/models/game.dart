class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String? status;
  final String? shortDescription;
  final String? description;
  final String gameUrl;
  final String? genre;
  final String? platform;
  final String? publisher;
  final String? developer;
  final String? releaseDate;
  final String? profileUrl;
  final Map<String, String>? minimumSystemRequirements;
  final List<String> screenshots;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.status,
    this.shortDescription,
    this.description,
    required this.gameUrl,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.releaseDate,
    this.profileUrl,
    this.minimumSystemRequirements,
    required this.screenshots,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    try {
      return Game(
        id: json['id'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        status: json['status'],
        shortDescription: json['short_description'],
        description: json['description'],
        gameUrl: json['game_url'],
        genre: json['genre'],
        platform: json['platform'],
        publisher: json['publisher'],
        developer: json['developer'],
        releaseDate: json['release_date'],
        profileUrl: json['profile_url'],
        minimumSystemRequirements:
            json['minimum_system_requirements'] != null &&
                    json['minimum_system_requirements'] is Map<String, dynamic>
                ? (json['minimum_system_requirements'] as Map<String, dynamic>)
                    .map((key, value) => MapEntry(key, value.toString()))
                : null,
        screenshots: json['screenshots'] != null && json['screenshots'] is List
            ? (json['screenshots'] as List)
                .map((e) => e['image']?.toString() ?? '')
                .where((url) => url.isNotEmpty)
                .toList()
            : [],
      );
    } catch (e) {
      print('Error parsing Game JSON: $e\nData: $json');
      rethrow;
    }
  }
}
