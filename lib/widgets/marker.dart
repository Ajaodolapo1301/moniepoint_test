import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../utils/color.dart';


class MapMarkerWidget extends StatelessWidget {
  final LatLng latLng;
  final double opacity;
  const MapMarkerWidget(
      {super.key, required this.latLng, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.xefa23d,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Text(
            '${latLng.longitude.toStringAsFixed(2)}, ${latLng.latitude.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
