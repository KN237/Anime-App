import 'package:anime_app/models/anime.dart';
import 'package:anime_app/services/animes_services.dart';
import 'package:flutter/material.dart';

class AnimesProvider extends ChangeNotifier {
  List<Anime> topAnime = [];
  List<Anime> seasonAnime = [];
  List<Anime> searchAnime = [];
  bool isLoading = true;
  bool isSearchLoading = false;
  int top = 1;
  int season = 1;
  int search = 1;
  String searchText = '';

  void loadData() async {
    topAnime = await AnimeServices.fetchRankedAnimes(top);
    seasonAnime = await AnimeServices.fetchSeasonAnimes(season);
    isLoading = false;
    notifyListeners();
  }

  void searchData() async {
    isSearchLoading = true;
    notifyListeners();
    searchAnime = await AnimeServices.searchAnimes(searchText, search);
    isSearchLoading = false;
    notifyListeners();
  }
}
