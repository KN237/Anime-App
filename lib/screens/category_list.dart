import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:anime_app/widgets/spacer.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.title, required this.animes});
  final String title;
  final List<Anime> animes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: CustomColor.white, fontSize: 23),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 10, top: 10),
        itemCount: animes.length,
        itemBuilder: (_, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 140,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: CustomColor.dark,
                  image: DecorationImage(
                      image: NetworkImage(
                          animes[index].images!.values.first.largeImageUrl!),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    color: WidgetStateProperty.resolveWith<Color>(
                        (_) => CustomColor.blue),
                    label: Text(
                      animes[index].rank!.toString(),
                      style: const TextStyle(
                          fontSize: 12, color: CustomColor.white),
                    ),
                    side: BorderSide.none,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  addVerticalSpace(15),
                  SizedBox(
                    width: 160,
                    child: Text(
                      animes[index].title!,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  addVerticalSpace(10),
                  SizedBox(
                    width: 160,
                    height: 60,
                    child: Text(
                      animes[index].synopsis!,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
