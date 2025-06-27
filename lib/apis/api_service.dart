import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';
import '../models/news.dart';

class ApiService {
  static Future<List<Game>> fetchGames({
    String? platform,
    String? category,
    String? sortBy,
  }) async {
    String baseUrl = 'https://www.mmobomb.com/api1/games';
    List<String> params = [];

    if (platform != null && platform != 'all') {
      params.add('platform=$platform');
    }
    if (category != null && category != 'all') {
      params.add('category=$category');
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params.add('sort-by=$sortBy');
    }

    final url = '$baseUrl${params.isNotEmpty ? '?' + params.join('&') : ''}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }

  static Future<Game> fetchGameDetail(int id) async {
    final response = await http.get(
      Uri.parse('https://www.mmobomb.com/api1/game?id=$id'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Game.fromJson(data);
    } else {
      throw Exception('Failed to load game detail');
    }
  }

  static Future<List<News>> fetchLatestNews() async {
    final url = 'https://www.mmobomb.com/api1/latestnews';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
