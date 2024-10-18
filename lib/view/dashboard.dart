import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets.dart';
import '../utils/color.dart';
import '../widgets/houses.dart';
import '../widgets/slide_fade.dart';
import '../widgets/statistic.dart';


class DashboardScreenWidget extends StatefulWidget {
  const DashboardScreenWidget({super.key});

  @override
  State<DashboardScreenWidget> createState() => _DashboardScreenWidgetState();
}

class _DashboardScreenWidgetState extends State<DashboardScreenWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _statAnimation;
  late Animation<Offset> _housesAnimation;
  late Animation<double> _welcomeAnimation;
  late Animation<double> _addressAnimation;
  late Animation<Offset> _descriptionAnimation;
  late AnimationController _animationController;
  late Animation<double> _profilePictureAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _addressAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(.2, .5)));
    _profilePictureAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController, curve: const Interval(0, .25)));
    _welcomeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(0, .25)));
    _descriptionAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _animationController, curve: const Interval(.25, .5)));
    _statAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(.5, .75)));

    _housesAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _animationController, curve: const Interval(.75, 1)));

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: SlideFadeTransistionWidget(
          minWidth: 0,
          height: 50.h,
          maxWidth: 154.w,
          animation: _addressAnimation,
          alignment: Alignment.centerLeft,
          childWidget: Padding(
            padding: REdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.location,
                  width: 14.w,
                  colorFilter: const ColorFilter.mode(
                      AppColors.xa89d89, BlendMode.srcIn),
                ),
                4.horizontalSpace,
                Flexible(
                  child: Text(
                    'Saint Petersburg',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.xa89d89,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          parentWidget: Container(
            width: 154.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 20),
            child: ScaleTransition(
              scale: _profilePictureAnimation,
              child: CircleAvatar(
                radius: 20.w,
                backgroundImage: const AssetImage(Assets.profile),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  AppColors.xefa23d.withOpacity(.3),
                ],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: REdgeInsets.only(top: 35),
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeTransition(
                          opacity: _welcomeAnimation,
                          child: Text(
                            'Hi, Marina',
                            style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 1,
                              color: AppColors.xa89d89,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        18.verticalSpace,
                        ClipRect(
                          child: SlideTransition(
                            position: _descriptionAnimation,
                            child: Text(
                              'Let\'s select your',
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        ClipRect(
                          child: SlideTransition(
                            position: _descriptionAnimation,
                            child: Text(
                              'perfect place',
                              style: TextStyle(
                                fontSize: 30.sp,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        40.verticalSpace,
                        StatisticWidget(animation: _statAnimation),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize:
                0.5,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            builder:
                (BuildContext context, ScrollController scrollController) {
              return HousesWidget(animation: _housesAnimation, scrollController: scrollController,);
            },
          ),
        ],
      ),
    );
  }
}
