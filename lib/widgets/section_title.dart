import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:anime_app/screens/category_list.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.animes});
  final String title;
  final List<Anime> animes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: CustomColor.white, fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CategoryList(
                    title: title,
                    animes: animes,
                  ),
                ),
              );
            },
            child: Text(
              'Voir tout',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: CustomColor.blue),
            ),
          )
        ],
      ),
    );
  }
}
