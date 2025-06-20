import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';

class ApiService {
  static Future<List<Game>> fetchGames({
    String platform = 'all',
    String category = '',
    String sortBy = '',
  }) async {
    String url = 'https://www.mmobomb.com/api1/games?platform=$platform';

    if (category.isNotEmpty) url += '&category=$category';
    if (sortBy.isNotEmpty) url += '&sort-by=$sortBy';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }
}
