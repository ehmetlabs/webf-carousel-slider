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
  final int initialIndex;
  final bool loop;
  final bool autoplay;
  final Duration autoplayDelay;
  final Duration speed;
  final Axis direction;
  final bool centeredSlides;
  final bool allowTouchMove;
  final bool autoplayDisableOnInteraction;
  final void Function(int index, CarouselPageChangedReason reason)?
      onPageChanged;

  CarouselConfig({
    this.height,
    double? aspectRatio,
    double? viewportFraction,
    int? initialIndex,
    bool? loop,
    bool? autoplay,
    double? autoplayDelayMs,
    double? speedMs,
    Axis? direction,
    bool? centeredSlides,
    bool? allowTouchMove,
    bool? autoplayDisableOnInteraction,
    this.onPageChanged,
  })  : aspectRatio = aspectRatio ?? 16 / 9,
        viewportFraction =
            TypeConverter.clampViewportFraction(viewportFraction),
        initialIndex = TypeConverter.toInt(initialIndex, min: 0),
        loop = TypeConverter.toBool(loop),
        autoplay = TypeConverter.toBool(autoplay, defaultValue: false),
        autoplayDelay = Duration(
          milliseconds: TypeConverter.clampAutoplayDelayMs(
            autoplayDelayMs,
          ),
        ),
        speed = Duration(
          milliseconds: TypeConverter.clampSpeedMs(
            speedMs,
          ),
        ),
        direction = direction ?? Axis.horizontal,
        centeredSlides = TypeConverter.toBool(centeredSlides),
        allowTouchMove =
            TypeConverter.toBool(allowTouchMove, defaultValue: true),
        autoplayDisableOnInteraction =
            TypeConverter.toBool(autoplayDisableOnInteraction);

  CarouselOptions build() {
    return CarouselOptions(
      height: height,
      aspectRatio: aspectRatio,
      viewportFraction: viewportFraction,
      initialPage: initialIndex,
      enableInfiniteScroll: loop,
      autoPlay: autoplay,
      autoPlayInterval: autoplayDelay,
      autoPlayAnimationDuration: speed,
      autoPlayCurve: Curves.ease,
      scrollDirection: direction,
      enlargeCenterPage: false,
      pageSnapping: true,
      pauseAutoPlayOnTouch: allowTouchMove,
      pauseAutoPlayOnManualNavigate: autoplayDisableOnInteraction,
      padEnds: centeredSlides,
      scrollPhysics:
          allowTouchMove ? null : const NeverScrollableScrollPhysics(),
      onPageChanged: onPageChanged,
    );
  }
}
