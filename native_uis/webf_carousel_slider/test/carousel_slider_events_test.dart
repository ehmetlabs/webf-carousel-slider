import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/event/event_manager.dart';

class _FakeElement implements WidgetElement {
  final List<CustomEvent> events = [];

  @override
  void dispatchEvent(Event event) {
    if (event is CustomEvent) {
      events.add(event);
    }
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('WebFCarouselSlider events payloads', () {
    test('dispatches change event with index, previousIndex, reason', () {
      final element = _FakeElement();
      final manager = CarouselEventManager(element);

      manager.dispatchChange(index: 2, previousIndex: 1, reason: 'manual');

      expect(element.events, hasLength(1));
      final event = element.events.first;
      expect(event.type, equals('change'));
      expect(event.detail, isA<Map<String, Object?>>());
      final detail = event.detail as Map<String, Object?>;
      expect(detail['index'], equals(2));
      expect(detail['previousIndex'], equals(1));
      expect(detail['reason'], equals('manual'));
    });
  });
}
