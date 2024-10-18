import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/color.dart';

class OtherScreenWidget extends StatelessWidget {
  final String name;
  const OtherScreenWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.xefa23d,
      body: Center(
        child: Text(
          name,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.x2b2b2b),
        ),
      ),
    );
  }
}
