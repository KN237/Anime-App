import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart' as m;
import 'package:anime_app/screens/anime_details.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key, required this.animes});
  final List<m.Anime> animes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 10, top: 10),
      itemCount: animes.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => AnimeDetails(anime: animes[index])),
            );
          },
          child: Column(
            children: [
              Container(
                width: 160,
                height: 200,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: CustomColor.dark,
                  image: DecorationImage(
                      image: NetworkImage(
                        animes[index].images!.values.last.largeImageUrl!,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 160,
                child: Center(
                  child: Text(
                    animes[index].title!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
