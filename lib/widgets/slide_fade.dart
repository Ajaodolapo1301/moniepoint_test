import 'package:flutter/material.dart';

class SlideFadeTransistionWidget extends StatelessWidget {
  final double height;
  final double minWidth;
  final double maxWidth;
  final Widget childWidget;
  final Widget parentWidget;
  final Alignment alignment;
  final Animation<double> animation;
  const SlideFadeTransistionWidget({
    super.key,
    required this.height,
    required this.minWidth,
    required this.maxWidth,
    required this.animation,
    required this.childWidget,
    required this.parentWidget,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Stack(
          alignment: alignment,
          children: [
            SizedBox(
                height: height,
                width: minWidth +
                    (animation.value * (maxWidth - minWidth)),
                child: parentWidget),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: animation.value < 1
                  ? 0
                  : animation.value,
              child: childWidget,
            ),
          ],
        );
      },
    );
  }
}
