import 'package:flutter/material.dart';
import '../models/game.dart';
import '../apis/api_service.dart';
import 'game_detail_screen.dart';
import 'news_screen.dart';

class GameFilterScreen extends StatefulWidget {
  const GameFilterScreen({super.key});

  @override
  _GameFilterScreenState createState() => _GameFilterScreenState();
}

class _GameFilterScreenState extends State<GameFilterScreen> {
  String selectedPlatform = 'all';
  String selectedCategory = 'all';
  String selectedSort = '';
  List<Game> games = [];

  final platforms = ['all', 'pc', 'browser'];
  final categories = [
    'all',
    'mmorpg',
    'shooter',
    'strategy',
    'moba',
    'zombie',
    'pvp',
  ];
  final sorts = ['release-date', 'alphabetical', 'relevance'];

  @override
  void initState() {
    super.initState();
    loadGames();
  }

void loadGames() async {
  try {
    final result = await ApiService.fetchGames(
      platform: selectedPlatform == 'all' ? null : selectedPlatform,
      category: selectedCategory == 'all' ? null : selectedCategory,
      sortBy: selectedSort,
    );
    setState(() {
      games = result;
    });
  } catch (e) {
    print('Error loading games: $e');
  }
}


  Widget dropdown<T>(
    String label,
    T value,
    List<T> items,
    Function(T?) onChanged,
  ) {
    return DropdownButton<T>(
      value: value,
      hint: Text(label),
      items:
          items
              .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
              .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MMOBomb Games'),
        actions: [
          IconButton(
            icon: const Icon(Icons.article),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewsScreen()),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              dropdown('Platform', selectedPlatform, platforms, (val) {
                setState(() => selectedPlatform = val!);
                loadGames();
              }),
              dropdown(
                'Category',
                selectedCategory.isEmpty ? null : selectedCategory,
                categories,
                (val) {
                  setState(() => selectedCategory = val ?? '');
                  loadGames();
                },
              ),
              dropdown(
                'Sort By',
                selectedSort.isEmpty ? null : selectedSort,
                sorts,
                (val) {
                  setState(() => selectedSort = val ?? '');
                  loadGames();
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  leading: Image.network(
                    game.thumbnail,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(game.title),
                  subtitle: Text('${game.genre} • ${game.platform}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameDetailScreen(gameId: game.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
