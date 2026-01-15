import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/config/carousel_config.dart';

void main() {
  group('Carousel behavior consistency', () {
    test('keeps autoplay settings without extra conversion', () {
      final config = CarouselConfig(
        autoPlay: true,
        autoPlayIntervalMs: 2500,
        autoPlayAnimationDurationMs: 650,
      );

      final options = config.build();

      expect(options.autoPlay, isTrue);
      expect(options.autoPlayInterval, equals(const Duration(milliseconds: 2500)));
      expect(options.autoPlayAnimationDuration,
          equals(const Duration(milliseconds: 650)));
    });

    test('keeps scroll settings without extra conversion', () {
      final config = CarouselConfig(
        enableInfiniteScroll: false,
        reverse: true,
        enlargeCenterPage: true,
      );

      final options = config.build();

      expect(options.enableInfiniteScroll, isFalse);
      expect(options.reverse, isTrue);
      expect(options.enlargeCenterPage, isTrue);
    });

    test('keeps layout settings without extra conversion', () {
      final config = CarouselConfig(
        initialPage: 3,
        viewportFraction: 1.25,
        aspectRatio: 2.2,
      );

      final options = config.build();

      expect(options.initialPage, equals(3));
      expect(options.viewportFraction, equals(1.25));
      expect(options.aspectRatio, equals(2.2));
    });

    test('passes onPageChanged/onScrolled callbacks through', () {
      int? receivedIndex;
      CarouselPageChangedReason? receivedReason;
      double? receivedScroll;

      final config = CarouselConfig(
        onPageChanged: (index, reason) {
          receivedIndex = index;
          receivedReason = reason;
        },
        onScrolled: (value) {
          receivedScroll = value;
        },
      );

      final options = config.build();
      options.onPageChanged?.call(2, CarouselPageChangedReason.manual);
      options.onScrolled?.call(3.5);

      expect(receivedIndex, equals(2));
      expect(receivedReason, equals(CarouselPageChangedReason.manual));
      expect(receivedScroll, equals(3.5));
    });
  });
}
