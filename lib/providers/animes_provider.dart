import 'package:anime_app/models/anime.dart';
import 'package:anime_app/services/animes_services.dart';
import 'package:flutter/material.dart';

class AnimesProvider extends ChangeNotifier {
  List<Anime> topAnime = [];
  List<Anime> seasonAnime = [];
  bool isLoading = true;
  int page = 1;

  void loadData() async {
    topAnime = await AnimeServices.fetchRankedAnimes(page);
    seasonAnime = await AnimeServices.fetchSeasonAnimes(page);
    print(seasonAnime.first.title);
    isLoading = false;
    notifyListeners();
  }
}
