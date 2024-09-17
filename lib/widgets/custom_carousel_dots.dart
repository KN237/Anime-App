import 'package:anime_app/config/constant.dart';
import 'package:anime_app/models/anime.dart';
import 'package:flutter/material.dart';

class CustomCarouselDots extends StatelessWidget {
  const CustomCarouselDots({
    super.key,
    required this.list,
    required List<AnimationController> animationControllers,
    required this.currentIndex,
  }) : _animationControllers = animationControllers;

  final List<Anime> list;
  final List<AnimationController> _animationControllers;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...list.map(
          (i) {
            return RotationTransition(
              turns: Tween<double>(begin: 0, end: 1 / 2).animate(
                CurvedAnimation(
                    parent: _animationControllers[list.indexOf(i)],
                    curve: Curves.decelerate),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 27,
                height: 7,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: currentIndex == list.indexOf(i)
                      ? CustomColor.blue
                      : Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
