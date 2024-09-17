import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:anime_app/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final format = DateFormat('yyyy-MM-dd');

class AnimeDetails extends StatefulWidget {
  const AnimeDetails({super.key, required this.anime});
  final Anime anime;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  int descriptionLength = 250;
  late TextTheme textTheme;
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.anime.trailer!.youtubeId ?? '6R5EqW4nOik',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 17,
                  )),
            ),
            leadingWidth: 60,
            expandedHeight: 300,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        widget.anime.images!.values.first.largeImageUrl!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(25),
                  Text(
                    widget.anime.title!,
                    style: textTheme.titleLarge!.copyWith(fontSize: 25),
                  ),
                  addVerticalSpace(20),
                  ReadMoreText(
                    widget.anime.synopsis!,
                    trimLength: descriptionLength,
                    textAlign: TextAlign.justify,
                    colorClickableText: CustomColor.blue,
                  ),
                  addVerticalSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Genres: ${widget.anime.genres?.map((elt) => '${elt.name}')} ',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Start date: ${widget.anime.aired!.from != null ? format.format(widget.anime.aired!.from!) : ''}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'End date: ${widget.anime.aired!.to != null ? format.format(widget.anime.aired!.to!) : ''}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Episodes: ${widget.anime.episodes}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Average Episode duration: ${widget.anime.duration} ',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Status: ${widget.anime.status}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Ratings: ${widget.anime.rating}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Studios: ${widget.anime.studios?.map((elt) => '${elt.name}')}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'English name: ${widget.anime.titleEnglish}',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Japanese name: ${widget.anime.titleJapanese}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (widget.anime.background!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.anime.background!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  addVerticalSpace(20),
                  Center(
                    child: Text(
                      'Image Gallery',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  addVerticalSpace(20),
                  Center(
                    child: Wrap(
                      spacing: 10,
                      children: [
                        TrailerImage(
                            image: widget.anime.images!.values.first.imageUrl!),
                        TrailerImage(
                            image: widget
                                .anime.images!.values.first.largeImageUrl!),
                        TrailerImage(
                            image: widget
                                .anime.images!.values.first.smallImageUrl!),
                      ],
                    ),
                  ),
                  addVerticalSpace(20),
                  Center(
                    child: Text(
                      'Video trailer',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  addVerticalSpace(20),
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: CustomColor.blue,
                    progressColors: const ProgressBarColors(
                      playedColor: CustomColor.blue,
                      handleColor: CustomColor.background,
                    ),
                  ),
                  addVerticalSpace(20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TrailerImage extends StatelessWidget {
  const TrailerImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
