import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class DOtsIndicatorWIdget extends StatelessWidget {
  const DOtsIndicatorWIdget({
    Key? key,
    required this.scrollPosition,
  }) : super(key: key);

  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DotsIndicator(
              position: scrollPosition,
              dotsCount: 3,
              decorator: DotsDecorator(
                spacing: const EdgeInsets.all(2),
                size: const Size.square(8),
                activeSize: const Size(12, 6),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
