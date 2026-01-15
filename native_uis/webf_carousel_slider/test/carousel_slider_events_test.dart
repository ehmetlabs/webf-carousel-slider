import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/event/event_manager.dart';

void main() {
  group('WebFCarouselSlider events payloads', () {
    test('dispatches onPageChanged callback with index and reason', () {
      int? receivedIndex;
      String? receivedReason;
      final manager = CarouselEventManager(
        onPageChanged: () => (int index, String reason) {
          receivedIndex = index;
          receivedReason = reason;
        },
        onScrolled: () => null,
      );

      manager.dispatchPageChanged(2, CarouselPageChangedReason.manual);

      expect(receivedIndex, equals(2));
      expect(receivedReason, equals('manual'));
    });

    test('dispatches onScrolled callback with value', () {
      double? receivedValue;
      final manager = CarouselEventManager(
        onPageChanged: () => null,
        onScrolled: () => (double? value) {
          receivedValue = value;
        },
      );

      manager.dispatchScrolled(12.5);

      expect(receivedValue, equals(12.5));
    });
  });
}
