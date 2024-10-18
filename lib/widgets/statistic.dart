import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color.dart';
import 'num_widget.dart';

class StatisticWidget extends StatelessWidget {
  final Animation<double> animation;
  const StatisticWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: NumberItemWidget(
            name: 'Buy',
            value: 1034,
            animation: animation,
            textColor: Colors.white,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.xefa23d),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: NumberItemWidget(
            name: 'Rent',
            value: 2212,
            animation: animation,
            textColor: AppColors.xa89d89,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
