import 'package:anime_app/config/constant.dart';
import 'package:anime_app/providers/animes_provider.dart';
import 'package:anime_app/screens/anime_details.dart';
import 'package:anime_app/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final animesProvider = context.watch<AnimesProvider>();
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          onChanged: (value) {
            animesProvider.searchText = value;
            animesProvider.searchData();
          },
          cursorColor: CustomColor.blue,
          decoration: const InputDecoration(
            hintText: 'Search an anime',
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: animesProvider.isSearchLoading
          ? SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height,
              child: const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.blue,
                ),
              ),
            )
          : animesProvider.searchAnime.isEmpty
              ? SizedBox(
                  width: mediaQuery.width,
                  height: mediaQuery.height,
                  child: Center(
                    child: Text(
                      'No Data Found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              : Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    itemCount: animesProvider.searchAnime.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AnimeDetails(
                                  anime: animesProvider.searchAnime[index]),
                            ),
                          );
                        },
                        child: Row(
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
                                    image: NetworkImage(animesProvider
                                            .searchAnime[index]
                                            .images
                                            ?.values
                                            .first
                                            .largeImageUrl! ??
                                        'https://placehold.co/600x400'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    animesProvider.searchAnime[index].title!,
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
                                  height: 80,
                                  child: Text(
                                    animesProvider
                                            .searchAnime[index].synopsis ??
                                        'No Synopsis',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
