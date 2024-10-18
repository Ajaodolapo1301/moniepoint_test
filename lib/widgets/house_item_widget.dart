import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/widgets/slide_fade.dart';

import '../utils/color.dart';


class HouseItemWidget extends StatelessWidget {
  final double width;
  final String image;
  final double height;
  final String address;
  final double addressMargin;
  final Alignment addressTextAlign;
  final Animation<double> animation;
  const HouseItemWidget({
    super.key,
    required this.width,
    required this.image,
    required this.height,
    required this.address,
    required this.animation,
    required this.addressMargin,
    this.addressTextAlign = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final double minWidth = 40.w;
    final double maxWidth = width - (addressMargin * 2);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          Image.asset(
            image,
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Positioned(
            left: addressMargin,
            // right: addressMargin,
            bottom: addressMargin,
            child: SlideFadeTransistionWidget(
              height: minWidth,
              minWidth: minWidth,
              maxWidth: maxWidth,
              animation: animation,
              alignment: addressTextAlign,
              childWidget: Padding(
                padding: REdgeInsets.only(left: 10),
                child: Text(
                  address,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13.sp,
                    letterSpacing: 0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              parentWidget: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: minWidth,
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: REdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 20.h,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10.w,
                          color: AppColors.xa89d89,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
