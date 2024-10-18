import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberItemWidget extends StatefulWidget {
  final String name;
  final int value;
  final Color textColor;
  final BoxDecoration decoration;
  final Animation<double> animation;
  const NumberItemWidget({
    super.key,
    required this.name,
    required this.value,
    required this.textColor,
    required this.animation,
    required this.decoration,
  });

  @override
  State<NumberItemWidget> createState() => _NumberItemWidgetState();
}

class _NumberItemWidgetState extends State<NumberItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _counterAnimationController;

  @override
  void initState() {
    _counterAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    _counterAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _counterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.animation,
      child: Container(
        decoration: widget.decoration,
        padding: REdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              widget.name.toUpperCase(),
              style: TextStyle(
                fontSize: 14.sp,
                color: widget.textColor,
                letterSpacing: .9,
                fontWeight: FontWeight.w400,
              ),
            ),
            30.verticalSpace,
            AnimatedBuilder(
                animation: widget.animation,
                builder: (_, __) {
                  String value =
                      (widget.animation.value * widget.value)
                          .toInt()
                          .toString();
                  if (value.length >= 4) {
                    value = '${value.substring(0, 1)} ${value.substring(1)}';
                  }
                  return Text(
                    value,
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
            10.verticalSpace,
            Text(
              'offers',
              style: TextStyle(
                fontSize: 12.sp,
                color: widget.textColor,
                letterSpacing: .9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
