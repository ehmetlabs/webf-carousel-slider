import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/event/event_manager.dart';
import 'package:webf_carousel_slider/src/utils/enum_converter.dart';
import 'package:webf_carousel_slider/src/utils/type_converter.dart';

void main() {
  group('Carousel edge cases', () {
    test('falls back on unsupported enum values', () {
      expect(EnumConverter.parseScrollPhysics('unsupported'), isNull);
      expect(EnumConverter.parseEnlargeStrategy('unsupported'),
          equals(CenterPageEnlargeStrategy.scale));
    });

    test('falls back on unsupported clip behavior values', () {
      expect(TypeConverter.parseClipBehavior('unsupported'),
          equals(Clip.hardEdge));
      expect(TypeConverter.normalizeClipBehaviorName('unsupported'),
          equals('hardEdge'));
    });

    test('treats unknown scroll direction as horizontal', () {
      expect(TypeConverter.parseDirection('diagonal'), Axis.horizontal);
    });

    test('preserves event dispatch order and frequency', () {
      final events = <String>[];
      final manager = CarouselEventManager(
        onPageChanged: () => (int index, String reason) {
          events.add('page:$index:$reason');
        },
        onScrolled: () => (double? value) {
          events.add('scroll:$value');
        },
      );

      manager.dispatchPageChanged(1, CarouselPageChangedReason.manual);
      manager.dispatchScrolled(0.5);
      manager.dispatchPageChanged(2, CarouselPageChangedReason.controller);

      expect(
        events,
        equals(<String>[
          'page:1:manual',
          'scroll:0.5',
          'page:2:controller',
        ]),
      );
    });

    test('handles out-of-order dispatch without callbacks', () {
      final manager = CarouselEventManager(
        onPageChanged: () => null,
        onScrolled: () => null,
      );

      expect(() => manager.dispatchScrolled(1.0), returnsNormally);
      expect(
        () => manager.dispatchPageChanged(
          0,
          CarouselPageChangedReason.manual,
        ),
        returnsNormally,
      );
    });

    test('dispatches after callbacks become available', () {
      bool enableCallback = false;
      int? receivedIndex;
      final manager = CarouselEventManager(
        onPageChanged: () {
          if (!enableCallback) return null;
          return (int index, String reason) {
            receivedIndex = index;
          };
        },
        onScrolled: () => null,
      );

      manager.dispatchPageChanged(1, CarouselPageChangedReason.manual);
      enableCallback = true;
      manager.dispatchPageChanged(2, CarouselPageChangedReason.manual);

      expect(receivedIndex, equals(2));
    });
  });
}
