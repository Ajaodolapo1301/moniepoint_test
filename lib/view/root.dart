import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moniepoint/view/map_page.dart';
import 'package:moniepoint/view/other_screen.dart';

import '../utils/color.dart';
import '../utils/enum.dart';
import 'dashboard.dart';


class HomeScreenRootWidget extends StatefulWidget {
  const HomeScreenRootWidget({super.key});

  @override
  State<HomeScreenRootWidget> createState() => _HomeScreenRootWidgetState();
}

class _HomeScreenRootWidgetState extends State<HomeScreenRootWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  int current = 2;
  PageController pageController = PageController(
    initialPage: 2,
  );


  @override
  void initState() {
    var animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController, curve: const Interval(.75, 1)));
    animationController.forward();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body:  Column(
        children: [
          Expanded(
            child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: getScreens()
                  
            ),
          ),
        ],
      ),





      bottomNavigationBar: SlideTransition(
        position: _animation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
          margin: EdgeInsets.only(left: 55.w, right: 55.w, bottom: 40.h),
          decoration: BoxDecoration(
            color: AppColors.x2b2b2b,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: BottomNavigationBarEnum.values
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                      
                        current = e.index;
                        pageController.jumpToPage(e.index);
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: e.index == current ? 25.w : 20.w,
                        backgroundColor: e.index == current
                            ? AppColors.xefa23d
                            : AppColors.x232220,
                        child: Center(child: SvgPicture.asset(e.icon)),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return [
      const MapPageRootWidget(),
      const OtherScreenWidget(name:"Messages" ),
      const DashboardScreenWidget(),
      const OtherScreenWidget(name:"Favorite"),
      const OtherScreenWidget(name:"Profile" ),
    ];
  }
}
