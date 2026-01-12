import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/config/carousel_config.dart';

void main() {
  group('CarouselConfig', () {
    test('should create default configuration', () {
      final config = CarouselConfig();

      expect(config.viewportFraction, 1.0);
      expect(config.initialIndex, 0);
      expect(config.loop, false);
      expect(config.autoplay, false);
      expect(config.centeredSlides, false);
      expect(config.direction, Axis.horizontal);
      expect(config.allowTouchMove, true);
      expect(config.autoplayDisableOnInteraction, false);
    });

    test('should create configuration with custom values', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        initialIndex: 2,
        autoplay: true,
        autoplayDelayMs: 5000,
        speedMs: 400,
        centeredSlides: true,
        allowTouchMove: false,
        autoplayDisableOnInteraction: true,
      );

      expect(config.viewportFraction, 0.8);
      expect(config.initialIndex, 2);
      expect(config.autoplay, true);
      expect(config.autoplayDelay.inMilliseconds, 5000);
      expect(config.speed.inMilliseconds, 400);
      expect(config.centeredSlides, true);
      expect(config.allowTouchMove, false);
      expect(config.autoplayDisableOnInteraction, true);
    });

    test('should validate viewportFraction range', () {
      final config1 = CarouselConfig(viewportFraction: 0.0);
      expect(config1.viewportFraction, 0.01);

      final config2 = CarouselConfig(viewportFraction: 1.5);
      expect(config2.viewportFraction, 1.0);
    });

    test('should validate initialIndex minimum', () {
      final config1 = CarouselConfig(initialIndex: -5);
      expect(config1.initialIndex, 0);
    });

    test('should validate autoplay delay range', () {
      final config1 = CarouselConfig(autoplayDelayMs: 100);
      expect(config1.autoplayDelay.inMilliseconds, 500);

      final config2 = CarouselConfig(autoplayDelayMs: 70000);
      expect(config2.autoplayDelay.inMilliseconds, 60000);
    });

    test('should validate speed range', () {
      final config1 = CarouselConfig(speedMs: -10);
      expect(config1.speed.inMilliseconds, 0);

      final config2 = CarouselConfig(speedMs: 6000);
      expect(config2.speed.inMilliseconds, 5000);
    });
  });

  group('CarouselConfig.build', () {
    test('should build CarouselOptions correctly', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        autoplay: true,
        autoplayDelayMs: 3000,
        speedMs: 400,
        centeredSlides: true,
        autoplayDisableOnInteraction: true,
      );

      final options = config.build();

      expect(options.viewportFraction, 0.8);
      expect(options.autoPlay, true);
      expect(options.autoPlayInterval.inMilliseconds, 3000);
      expect(options.autoPlayAnimationDuration.inMilliseconds, 400);
      expect(options.padEnds, true);
      expect(options.pauseAutoPlayOnTouch, true);
    });

    test('should use default aspectRatio when null', () {
      final config = CarouselConfig(aspectRatio: null);

      final options = config.build();

      expect(options.aspectRatio, closeTo(1.777, 0.001));
    });

    test('should use custom aspectRatio when provided', () {
      final config = CarouselConfig(aspectRatio: 2.0);

      final options = config.build();

      expect(options.aspectRatio, 2.0);
    });

    test('should use default autoPlay curve', () {
      final config = CarouselConfig();

      final options = config.build();

      expect(options.autoPlayCurve, Curves.ease);
    });
  });
}
