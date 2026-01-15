import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/config/carousel_config.dart';

void main() {
  group('CarouselConfig', () {
    test('should create default configuration', () {
      final config = CarouselConfig();

      expect(config.height, isNull);
      expect(config.aspectRatio, equals(16 / 9));
      expect(config.viewportFraction, equals(0.8));
      expect(config.initialPage, equals(0));
      expect(config.enableInfiniteScroll, isTrue);
      expect(config.animateToClosest, isTrue);
      expect(config.reverse, isFalse);
      expect(config.autoPlay, isFalse);
      expect(config.autoPlayInterval, equals(const Duration(milliseconds: 4000)));
      expect(config.autoPlayAnimationDuration,
          equals(const Duration(milliseconds: 800)));
      expect(config.autoPlayCurve, equals(Curves.fastOutSlowIn));
      expect(config.enlargeCenterPage, isFalse);
      expect(config.pageSnapping, isTrue);
      expect(config.scrollDirection, equals(Axis.horizontal));
      expect(config.pauseAutoPlayOnTouch, isTrue);
      expect(config.pauseAutoPlayOnManualNavigate, isTrue);
      expect(config.pauseAutoPlayInFiniteScroll, isFalse);
      expect(config.enlargeStrategy, equals(CenterPageEnlargeStrategy.scale));
      expect(config.enlargeFactor, equals(0.3));
      expect(config.disableCenter, isFalse);
      expect(config.padEnds, isTrue);
      expect(config.clipBehavior, equals(Clip.hardEdge));
    });

    test('should create configuration with custom values', () {
      final config = CarouselConfig(
        height: 240,
        aspectRatio: 2.0,
        viewportFraction: 1.2,
        initialPage: 2,
        enableInfiniteScroll: false,
        animateToClosest: false,
        reverse: true,
        autoPlay: true,
        autoPlayIntervalMs: 5000,
        autoPlayAnimationDurationMs: 1000,
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: true,
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        pauseAutoPlayOnTouch: false,
        pauseAutoPlayOnManualNavigate: false,
        pauseAutoPlayInFiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        enlargeFactor: 0.6,
        disableCenter: true,
        padEnds: false,
        clipBehavior: Clip.none,
      );

      expect(config.height, equals(240));
      expect(config.aspectRatio, equals(2.0));
      expect(config.viewportFraction, equals(1.2));
      expect(config.initialPage, equals(2));
      expect(config.enableInfiniteScroll, isFalse);
      expect(config.animateToClosest, isFalse);
      expect(config.reverse, isTrue);
      expect(config.autoPlay, isTrue);
      expect(config.autoPlayInterval,
          equals(const Duration(milliseconds: 5000)));
      expect(config.autoPlayAnimationDuration,
          equals(const Duration(milliseconds: 1000)));
      expect(config.autoPlayCurve, equals(Curves.linear));
      expect(config.enlargeCenterPage, isTrue);
      expect(config.pageSnapping, isFalse);
      expect(config.scrollDirection, equals(Axis.vertical));
      expect(config.pauseAutoPlayOnTouch, isFalse);
      expect(config.pauseAutoPlayOnManualNavigate, isFalse);
      expect(config.pauseAutoPlayInFiniteScroll, isTrue);
      expect(config.enlargeStrategy, equals(CenterPageEnlargeStrategy.zoom));
      expect(config.enlargeFactor, equals(0.6));
      expect(config.disableCenter, isTrue);
      expect(config.padEnds, isFalse);
      expect(config.clipBehavior, equals(Clip.none));
    });

    test('should keep values without clamping', () {
      final config = CarouselConfig(
        viewportFraction: 1.5,
        autoPlayIntervalMs: 100,
        autoPlayAnimationDurationMs: -10,
        enlargeFactor: -0.2,
      );

      expect(config.viewportFraction, equals(1.5));
      expect(config.autoPlayInterval, equals(const Duration(milliseconds: 100)));
      expect(config.autoPlayAnimationDuration,
          equals(const Duration(milliseconds: -10)));
      expect(config.enlargeFactor, equals(-0.2));
    });
  });

  group('CarouselConfig.build', () {
    test('should build CarouselOptions correctly', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayIntervalMs: 3000,
        autoPlayAnimationDurationMs: 400,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        pauseAutoPlayOnTouch: false,
        pauseAutoPlayOnManualNavigate: false,
        pauseAutoPlayInFiniteScroll: true,
      );

      final options = config.build();

      expect(options.viewportFraction, equals(0.8));
      expect(options.autoPlay, isTrue);
      expect(options.autoPlayInterval, equals(const Duration(milliseconds: 3000)));
      expect(options.autoPlayAnimationDuration,
          equals(const Duration(milliseconds: 400)));
      expect(options.enlargeCenterPage, isTrue);
      expect(options.scrollDirection, equals(Axis.vertical));
      expect(options.pauseAutoPlayOnTouch, isFalse);
      expect(options.pauseAutoPlayOnManualNavigate, isFalse);
      expect(options.pauseAutoPlayInFiniteScroll, isTrue);
    });
  });
}
