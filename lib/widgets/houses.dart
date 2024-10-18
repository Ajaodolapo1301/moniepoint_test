import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/assets.dart';
import 'house_item_widget.dart';

class HousesWidget extends StatefulWidget {
  final Animation<Offset> animation;
  final ScrollController scrollController;
  const HousesWidget({super.key, required this.animation, required this.scrollController});

  @override
  State<HousesWidget> createState() => _HousesWidgetState();
}

class _HousesWidgetState extends State<HousesWidget>
    with SingleTickerProviderStateMixin {
  List<Animation<double>> _animations = [];
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _animations = List.generate(4, (index) {
      double begin = (index * .3) - (index * .1);
      double end = (index * .25) + .3;
      if (end > 1) end = 1;

      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(begin, end)));
    });
    widget.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.animation,
      child: Container(

        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HouseItemWidget(
                width: 375.w,
                height: 150.h,
                addressMargin: 20.w,
                image: Assets.house1,
                animation: _animations[0],
                address: 'Gladkova St., 25',
                addressTextAlign: Alignment.center,
              ),
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: HouseItemWidget(
                      width: 175.w,
                      height: 305.h,
                      addressMargin: 10.w,
                      image: Assets.house2,
                      animation: _animations[1],
                      address: 'Gubina St., 11',
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      children: [
                        HouseItemWidget(
                          width: 175.w,
                          height: 147.h,
                          addressMargin: 10.w,
                          image: Assets.house3,
                          animation: _animations[2],
                          address: 'Trevoleva St., 43',
                        ),
                        11.verticalSpace,
                        HouseItemWidget(
                          width: 175.w,
                          height: 147.h,
                          addressMargin: 10.w,
                          image: Assets.house4,
                          animation: _animations[3],
                          address: 'Sedova St., 22',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
