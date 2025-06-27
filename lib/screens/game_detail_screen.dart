import 'package:flutter/material.dart';
import 'package:school_lab/models/game.dart';
import '../apis/api_service.dart';

class GameDetailScreen extends StatefulWidget {
  final int gameId;

  const GameDetailScreen({super.key, required this.gameId});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  Game? game;

  @override
  void initState() {
    super.initState();
    ApiService.fetchGameDetail(widget.gameId).then((value) {
      setState(() => game = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(game!.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(game!.thumbnail),
            SizedBox(height: 8),
            Text(
              game!.shortDescription ?? 'No description available',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),
            Text('Genre: ${game!.genre}'),
            Text('Platform: ${game!.platform}'),
            Text('Publisher: ${game!.publisher}'),
            Text('Developer: ${game!.developer}'),
            Text('Release: ${game!.releaseDate}'),
            SizedBox(height: 8),
            Text(
              'System Requirements:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...?game!.minimumSystemRequirements?.entries.map(
              (e) => Text('${e.key}: ${e.value}'),
            ),
            SizedBox(height: 16),
            Text('Screenshots:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    game!.screenshots
                        .map(
                          (url) => Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Image.network(url),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
