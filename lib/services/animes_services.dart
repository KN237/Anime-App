import 'dart:convert';
import 'package:anime_app/models/anime.dart';
import 'package:http/http.dart';

class AnimeServices {
  static const topRankedUrl = 'https://api.jikan.moe/v4/top/anime?page=';
  static const topPopularUrl = 'https://api.jikan.moe/v4/top/anime/';
  static const topMoviesUrl = 'https://api.jikan.moe/v4/top/anime/';
  static const seasonUrl = 'https://api.jikan.moe/v4/seasons/now?page=';

  static Future<List<Anime>> fetchRankedAnimes(int page) async {
    List<Anime> temp = [];
    final response = await get(
      Uri.parse('$topRankedUrl$page'),
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> element in jsonDecode(response.body)['data']) {
        temp.add(
          Anime.fromJson(element),
        );
      }
    }

    return temp;
  }

  static Future<List<Anime>> fetchSeasonAnimes(int page) async {
    List<Anime> temp = [];
    final response = await get(
      Uri.parse('$seasonUrl$page'),
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> element in jsonDecode(response.body)['data']) {
        temp.add(
          Anime.fromJson(element),
        );
      }
    }

    return temp;
  }
}
