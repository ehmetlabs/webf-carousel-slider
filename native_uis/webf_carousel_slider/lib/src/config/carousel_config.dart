import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

import '../utils/type_converter.dart';

/// 轮播配置管理类
///
/// 职责:
/// - 统一配置校验与默认值处理
/// - 构建 CarouselOptions
class CarouselConfig {
  final double? height;
  final double aspectRatio;
  final double viewportFraction;
  final int initialPage;
  final bool enableInfiniteScroll;
  final bool animateToClosest;
  final bool reverse;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final bool enlargeCenterPage;
  final ScrollPhysics? scrollPhysics;
  final bool pageSnapping;
  final Axis scrollDirection;
  final bool pauseAutoPlayOnTouch;
  final bool pauseAutoPlayOnManualNavigate;
  final bool pauseAutoPlayInFiniteScroll;
  final PageStorageKey<String>? pageViewKey;
  final CenterPageEnlargeStrategy enlargeStrategy;
  final double enlargeFactor;
  final bool disableCenter;
  final bool padEnds;
  final Clip clipBehavior;
  final void Function(int index, CarouselPageChangedReason reason)?
      onPageChanged;
  final ValueChanged<double?>? onScrolled;

  CarouselConfig({
    this.height,
    double? aspectRatio,
    double? viewportFraction,
    int? initialPage,
    bool? enableInfiniteScroll,
    bool? animateToClosest,
    bool? reverse,
    bool? autoPlay,
    double? autoPlayIntervalMs,
    double? autoPlayAnimationDurationMs,
    Curve? autoPlayCurve,
    bool? enlargeCenterPage,
    ScrollPhysics? scrollPhysics,
    bool? pageSnapping,
    Axis? scrollDirection,
    bool? pauseAutoPlayOnTouch,
    bool? pauseAutoPlayOnManualNavigate,
    bool? pauseAutoPlayInFiniteScroll,
    PageStorageKey<String>? pageViewKey,
    CenterPageEnlargeStrategy? enlargeStrategy,
    double? enlargeFactor,
    bool? disableCenter,
    bool? padEnds,
    Clip? clipBehavior,
    this.onPageChanged,
    this.onScrolled,
  })  : aspectRatio = aspectRatio ?? 16 / 9,
        viewportFraction = TypeConverter.clampViewportFraction(
          viewportFraction,
          defaultValue: 0.8,
        ),
        initialPage = TypeConverter.toInt(initialPage, min: 0),
        enableInfiniteScroll =
            TypeConverter.toBool(enableInfiniteScroll, defaultValue: true),
        animateToClosest =
            TypeConverter.toBool(animateToClosest, defaultValue: true),
        reverse = TypeConverter.toBool(reverse),
        autoPlay = TypeConverter.toBool(autoPlay),
        autoPlayInterval = Duration(
          milliseconds: TypeConverter.clampAutoPlayIntervalMs(
            autoPlayIntervalMs,
          ),
        ),
        autoPlayAnimationDuration = Duration(
          milliseconds: TypeConverter.clampAutoPlayAnimationDurationMs(
            autoPlayAnimationDurationMs,
          ),
        ),
        autoPlayCurve = autoPlayCurve ?? Curves.fastOutSlowIn,
        enlargeCenterPage = TypeConverter.toBool(enlargeCenterPage),
        scrollPhysics = scrollPhysics,
        pageSnapping = TypeConverter.toBool(pageSnapping, defaultValue: true),
        scrollDirection = scrollDirection ?? Axis.horizontal,
        pauseAutoPlayOnTouch =
            TypeConverter.toBool(pauseAutoPlayOnTouch, defaultValue: true),
        pauseAutoPlayOnManualNavigate = TypeConverter.toBool(
          pauseAutoPlayOnManualNavigate,
          defaultValue: true,
        ),
        pauseAutoPlayInFiniteScroll =
            TypeConverter.toBool(pauseAutoPlayInFiniteScroll),
        pageViewKey = pageViewKey,
        enlargeStrategy = enlargeStrategy ?? CenterPageEnlargeStrategy.scale,
        enlargeFactor = TypeConverter.clampEnlargeFactor(enlargeFactor),
        disableCenter = TypeConverter.toBool(disableCenter),
        padEnds = TypeConverter.toBool(padEnds, defaultValue: true),
        clipBehavior = clipBehavior ?? Clip.hardEdge;

  CarouselOptions build() {
    return CarouselOptions(
      height: height,
      aspectRatio: aspectRatio,
      viewportFraction: viewportFraction,
      initialPage: initialPage,
      enableInfiniteScroll: enableInfiniteScroll,
      animateToClosest: animateToClosest,
      reverse: reverse,
      autoPlay: autoPlay,
      autoPlayInterval: autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
      enlargeCenterPage: enlargeCenterPage,
      onPageChanged: onPageChanged,
      onScrolled: onScrolled,
      scrollPhysics: scrollPhysics,
      pageSnapping: pageSnapping,
      scrollDirection: scrollDirection,
      pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
      pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate,
      pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
      pageViewKey: pageViewKey,
      enlargeStrategy: enlargeStrategy,
      enlargeFactor: enlargeFactor,
      disableCenter: disableCenter,
      padEnds: padEnds,
      clipBehavior: clipBehavior,
    );
  }
}
