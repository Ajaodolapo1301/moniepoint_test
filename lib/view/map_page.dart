import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import '../utils/assets.dart';
import '../utils/color.dart';
import '../utils/generate_latlng.dart';
import '../widgets/marker.dart';


class MapPageRootWidget extends StatefulWidget {
  const MapPageRootWidget({super.key});

  @override
  State<MapPageRootWidget> createState() => _MapPageRootWidgetState();
}

class _MapPageRootWidgetState extends State<MapPageRootWidget>
    with TickerProviderStateMixin {
  int selectedIndex = 1;
  OverlayEntry? _overlayEntry;
  List<LatLng> locations = [];
  MapController? mapController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _overlayScaleAnimation;
  late AnimationController _animationController;
  late AnimationController _overlayAnimationController;
  LatLng latLng = const LatLng(51.509364, -0.128928);

  final List<String> icons = [
    Assets.shield,
    Assets.wallet,
    Assets.infrastructure,
    Assets.layer2,
  ];
  final List<String> names = [
    'Cosy Areas',
    'Price',
    'Infrastructures',
    'Without any layer'
  ];

  @override
  void initState() {
    assert(icons.length == names.length);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _overlayAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _overlayScaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(_overlayAnimationController);

    _setScreen();

    super.initState();
  }

  _setScreen() {
    locations = generateLatLng(latLng, 5);
    mapController?.move(latLng, 13);

    _animationController.forward();
    setState(() {});
  }

  @override
  void dispose() {
    _closeOverlay();
    mapController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeOverlay,
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialZoom: 12,
              keepAlive: true,
              initialCenter: latLng,
              onMapReady: () {
                mapController = MapController();
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
                userAgentPackageName: 'com.example.travelApp',
                tileBuilder: (context, tileWidget, tile) => ColorFiltered(
                  colorFilter: const ColorFilter.matrix(
                    <double>[
                      -0.2126,
                      -0.7152,
                      -0.0722,
                      0,
                      255,
                      -0.2126,
                      -0.7152,
                      -0.0722,
                      0,
                      255,
                      -0.2126,
                      -0.7152,
                      -0.0722,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ],
                  ),
                  child: tileWidget,
                ),
              ),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution('OpenStreetMap contributors'),
                ],
              ),
              MarkerLayer(
                markers: locations
                    .map((e) => Marker(
                          point: e,
                          width: 100.w,
                          height: 45.h,
                          alignment: Alignment.center,
                          child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (_, __) {
                                return Transform.scale(
                                  scale: _animationController.value * 1,
                                  alignment: Alignment.bottomLeft,
                                  child: MapMarkerWidget(
                                      latLng: e,
                                      opacity: _animationController.value < 1
                                          ? 0
                                          : 1),
                                );
                              }),
                        ))
                    .toList(),
              )
            ],
          ),
          SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Padding(
                                padding: REdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.search_rounded),
                              ),
                              contentPadding:
                                  REdgeInsets.symmetric(vertical: 10),
                              constraints: BoxConstraints(
                                  minHeight: 46.w, maxHeight: 46.w),
                              hintText: 'Address',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: CircleAvatar(
                          radius: 23.w,
                          backgroundColor: Colors.white,
                          child: Image.asset(Assets.filter),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: GestureDetector(
                      onTap: _showOverlay,
                      behavior: HitTestBehavior.translucent,
                      child: CircleAvatar(
                        radius: 25.w,
                        backgroundColor: Colors.white.withOpacity(.4),
                        child: Image.asset(Assets.layer),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: CircleAvatar(
                          radius: 25.w,
                          backgroundColor: Colors.white.withOpacity(.4),
                          child: Image.asset(Assets.share),
                        ),
                      ),
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          height: 50.h,
                          padding: REdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.4),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.more),
                              10.horizontalSpace,
                              Text('List of variants',
                                  style: TextStyle(fontSize: 12.sp)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  _closeOverlay() {
    if (_overlayAnimationController.isCompleted) {
      _overlayAnimationController.reverse().whenCompleteOrCancel(() {
        _overlayEntry?.remove();
      });
    }
  }

  void _showOverlay() async {
    OverlayState overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 25.w,
        bottom: 180.h,
        child: Material(
          type: MaterialType.transparency,
          child: ScaleTransition(
            alignment: Alignment.bottomLeft,
            scale: _overlayScaleAnimation,
            child: Container(
              width: 150.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: const Color(0xFFeeebef),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  icons.length,
                  (index) => GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      _closeOverlay();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            icons[index],
                            width: 20.w,
                            height: 20.w,
                            colorFilter: ColorFilter.mode(
                                selectedIndex == index
                                    ? AppColors.xefa23d
                                    : AppColors.xa89d89,
                                BlendMode.srcIn),
                          ),
                          4.horizontalSpace,
                          Expanded(
                            child: Text(
                              names[index],
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: selectedIndex == index
                                    ? AppColors.xefa23d
                                    : AppColors.xa89d89,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(_overlayEntry!);
    if (_overlayAnimationController.isCompleted) {
      _overlayAnimationController.reset();
    }
    _overlayAnimationController.forward();
  }
}
