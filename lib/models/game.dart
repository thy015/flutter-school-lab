class Game {
  final int id;
  final String title;
  final String genre;
  final String platform;

  Game({required this.id, required this.title, required this.genre, required this.platform});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      genre: json['genre'],
      platform: json['platform'],
    );
  }
}
