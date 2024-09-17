import 'dart:math';

import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:anime_app/providers/animes_provider.dart';
import 'package:anime_app/widgets/custom_carousel_dots.dart';
import 'package:anime_app/widgets/custom_carousel_item.dart';
import 'package:anime_app/widgets/horizontal_list.dart';
import 'package:anime_app/widgets/section_title.dart';
import 'package:anime_app/widgets/spacer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final random = Random();
int number = random.nextInt(23);

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  int currentIndex = 0;
  List<Anime> list = [];
  List<Anime> myList = [];
  late List<AnimationController> _animationControllers;
  late CarouselSliderController _carouselController;

  @override
  void initState() {
    _animationControllers = List.generate(
        4,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 300),
            ));

    _carouselController = CarouselSliderController();
    context.read<AnimesProvider>().loadData();

    super.initState();
  }

  @override
  void dispose() {
    _animationControllers.map((elt) => elt.dispose());
    super.dispose();
  }

  void pageChange(int index) {
    if ((index - 1) >= 0) {
      _animationControllers[index].reset();
      _animationControllers[index].forward();
      _animationControllers[index - 1].reverse();
      _carouselController.animateToPage(index);
    } else {
      _animationControllers[index].reset();
      _animationControllers[index].forward();
      _carouselController.animateToPage(index);
    }

    setState(() {
      currentIndex = index;
    });
  }

  void populate() {
    if (!context.read<AnimesProvider>().isLoading) {
      list =
          context.read<AnimesProvider>().topAnime.sublist(number, number + 3);
      myList = List.of(context.watch<AnimesProvider>().topAnime);
      myList.sort((a, b) => a.popularity!.compareTo(b.popularity!));
    }
  }

  @override
  Widget build(BuildContext context) {
    populate();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anime World',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: CustomColor.white, fontSize: 23),
        ),
        actions: const [Icon(Icons.search)],
      ),
      body: context.watch<AnimesProvider>().isLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: LottieBuilder.asset(
                  'assets/images/loader.json',
                  width: 250,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      viewportFraction: 0.85,
                      height: 220.0,
                      onPageChanged: (index, reason) {
                        pageChange(index);
                      },
                    ),
                    items: list.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return CustomCarouselItem(i);
                        },
                      );
                    }).toList(),
                  ),
                  addVerticalSpace(10),
                  CustomCarouselDots(
                      list: list,
                      animationControllers: _animationControllers,
                      currentIndex: currentIndex),
                  addVerticalSpace(30),
                  SectionTitle(
                    title: 'Top Ranked',
                    animes: context.watch<AnimesProvider>().topAnime,
                  ),
                  SizedBox(
                    height: 250,
                    child: HorizontalList(
                      animes: context.watch<AnimesProvider>().topAnime,
                    ),
                  ),
                  addVerticalSpace(30),
                  SectionTitle(
                    title: 'Top Popular',
                    animes: myList,
                  ),
                  SizedBox(
                    height: 250,
                    child: HorizontalList(
                      animes: myList,
                    ),
                  ),
                  addVerticalSpace(30),
                  SectionTitle(
                    title: 'Top Movie Animes',
                    animes: context
                        .watch<AnimesProvider>()
                        .topAnime
                        .where((elt) => elt.type!.toLowerCase() == 'movie')
                        .toList(),
                  ),
                  SizedBox(
                    height: 250,
                    child: HorizontalList(
                      animes: context
                          .watch<AnimesProvider>()
                          .topAnime
                          .where((elt) => elt.type!.toLowerCase() == 'movie')
                          .toList(),
                    ),
                  ),
                  addVerticalSpace(30),
                  SectionTitle(
                    title: 'Top Of This Season',
                    animes: context.watch<AnimesProvider>().seasonAnime,
                  ),
                  SizedBox(
                    height: 250,
                    child: HorizontalList(
                      animes: context.watch<AnimesProvider>().seasonAnime,
                    ),
                  ),
                  addVerticalSpace(50),
                ],
              ),
            ),
    );
  }
}
