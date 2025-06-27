import 'package:flutter/material.dart';
import 'package:school_lab/screens/new_detail_screen.dart';
import '../apis/api_service.dart';
import '../models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest News')),
      body: FutureBuilder<List<News>>(
        future: ApiService.fetchLatestNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return ListTile(
                  leading: Image.network(news.thumbnail, width: 60),
                  title: Text(news.title),
                  subtitle: Text(news.shortDescription),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading news'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
