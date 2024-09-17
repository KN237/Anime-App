import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:anime_app/screens/anime_details.dart';
import 'package:flutter/material.dart';

class CustomCarouselItem extends StatelessWidget {
  const CustomCarouselItem(
    this.anime, {
    super.key,
  });
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AnimeDetails(anime: anime),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: CustomColor.dark,
          image: DecorationImage(
              image: NetworkImage(
                anime.images!.values.last.largeImageUrl!,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
