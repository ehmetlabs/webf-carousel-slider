import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/utils/carousel_items_parser.dart';

void main() {
  group('parseCarouselItems', () {
    test('parses list input', () {
      final items = parseCarouselItems([
        {'id': 1, 'url': 'https://example.com/a.png'},
        {'id': 'b', 'url': 'https://example.com/b.png'},
      ]);

      expect(items.length, 2);
      expect(items[0].id, 1);
      expect(items[0].url, 'https://example.com/a.png');
      expect(items[1].id, 'b');
      expect(items[1].url, 'https://example.com/b.png');
    });

    test('parses json string input', () {
      final items = parseCarouselItems(
        '[{"id":2,"url":"https://example.com/c.png"}]',
      );

      expect(items.length, 1);
      expect(items[0].id, 2);
      expect(items[0].url, 'https://example.com/c.png');
    });

    test('filters invalid entries', () {
      final items = parseCarouselItems([
        {'id': 1, 'url': ''},
        {'id': null, 'url': 'https://example.com/a.png'},
        {'id': 2, 'url': 'https://example.com/b.png'},
      ]);

      expect(items.length, 1);
      expect(items[0].id, 2);
      expect(items[0].url, 'https://example.com/b.png');
    });

    test('returns empty list for invalid input', () {
      expect(parseCarouselItems(null), isEmpty);
      expect(parseCarouselItems('not-json'), isEmpty);
      expect(parseCarouselItems({'id': 1, 'url': 'a'}), isEmpty);
    });
  });
}
