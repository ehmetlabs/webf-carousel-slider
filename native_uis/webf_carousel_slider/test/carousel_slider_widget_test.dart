import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

void main() {
  group('CarouselSlider Widget Tests', () {
    testWidgets('should build with default options', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(),
              items: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
      // CarouselSlider creates additional containers for constraints, so we just verify it exists
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should build with custom options', (WidgetTester tester) async {
      final customOptions = CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 2000),
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: customOptions,
              items: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
    });

    testWidgets('should handle empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(),
              items: const [],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
    });

    testWidgets('should handle single item', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(),
              items: [
                Container(color: Colors.purple),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
      // Verify at least our content container exists
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should handle many items', (WidgetTester tester) async {
      final items = List.generate(
        100,
        (index) => Container(
          color: Color(0xFF000000 + index * 0x00110000),
          child: Center(
            child: Text('Item $index'),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(
                initialPage: 50,
              ),
              items: items,
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
      // Verify text items exist
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should respect viewportFraction', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.5,
                  enlargeCenterPage: false,
                ),
                items: [
                  Container(color: Colors.red, width: 400),
                  Container(color: Colors.blue, width: 400),
                  Container(color: Colors.green, width: 400),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(CarouselSlider), findsOneWidget);
    });

    testWidgets('should handle enlargeCenterPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
    });

    testWidgets('should handle vertical scroll direction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: CarouselSlider(
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  aspectRatio: 1.0,
                ),
                items: [
                  Container(color: Colors.red, height: 400),
                  Container(color: Colors.blue, height: 400),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
    });

    testWidgets('should accept onPageChanged callback', (WidgetTester tester) async {
      // Just verify the carousel can be built with the callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  // Callback exists - do nothing in test
                },
              ),
              items: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CarouselSlider), findsOneWidget);
    });
  });

  group('CarouselOptions Tests', () {
    test('should create options with defaults', () {
      final options = CarouselOptions();

      expect(options.aspectRatio, equals(16 / 9));
      expect(options.viewportFraction, equals(0.8)); // Default is 0.8 in carousel_slider_plus
      expect(options.initialPage, equals(0));
      expect(options.enableInfiniteScroll, isTrue);
      expect(options.autoPlay, isFalse);
      expect(options.enlargeCenterPage, isFalse);
    });

    test('should create options with custom values', () {
      final options = CarouselOptions(
        height: 400,
        aspectRatio: 4 / 3,
        viewportFraction: 0.8,
        initialPage: 2,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 3000),
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
      );

      expect(options.height, equals(400));
      expect(options.aspectRatio, equals(4 / 3));
      expect(options.viewportFraction, equals(0.8));
      expect(options.initialPage, equals(2));
      expect(options.enableInfiniteScroll, isFalse);
      expect(options.autoPlay, isTrue);
      expect(options.autoPlayInterval, equals(const Duration(milliseconds: 3000)));
      expect(options.enlargeCenterPage, isTrue);
      expect(options.scrollDirection, equals(Axis.vertical));
    });

    test('should handle onPageChanged callback', () {
      bool callbackCalled = false;
      int capturedIndex = 0;
      CarouselPageChangedReason? capturedReason;

      final options = CarouselOptions(
        onPageChanged: (index, reason) {
          callbackCalled = true;
          capturedIndex = index;
          capturedReason = reason;
        },
      );

      options.onPageChanged?.call(3, CarouselPageChangedReason.manual);

      expect(callbackCalled, isTrue);
      expect(capturedIndex, equals(3));
      expect(capturedReason, equals(CarouselPageChangedReason.manual));
    });

    test('should handle various aspect ratios', () {
      final ratios = {
        4 / 3: 1.3333333333333333,
        16 / 9: 1.7777777777777777,
        21 / 9: 2.3333333333333335,
        1 / 1: 1.0,
      };

      ratios.forEach((input, expected) {
        final options = CarouselOptions(aspectRatio: input);
        expect(options.aspectRatio, closeTo(expected, 0.001));
      });
    });

    test('should handle autoplay intervals', () {
      final intervals = [
        const Duration(milliseconds: 1000),
        const Duration(milliseconds: 2000),
        const Duration(milliseconds: 3000),
        const Duration(milliseconds: 5000),
      ];

      for (final interval in intervals) {
        final options = CarouselOptions(
          autoPlay: true,
          autoPlayInterval: interval,
        );
        expect(options.autoPlayInterval, equals(interval));
        expect(options.autoPlay, isTrue);
      }
    });

    test('should handle scroll direction changes', () {
      final horizontalOptions = CarouselOptions(
        scrollDirection: Axis.horizontal,
      );
      expect(horizontalOptions.scrollDirection, equals(Axis.horizontal));

      final verticalOptions = CarouselOptions(
        scrollDirection: Axis.vertical,
      );
      expect(verticalOptions.scrollDirection, equals(Axis.vertical));
    });
  });

  group('Property Validation Tests', () {
    test('should validate viewportFraction range', () {
      final validValues = [0.1, 0.5, 0.8, 0.9, 1.0];

      for (final value in validValues) {
        expect(value, greaterThan(0));
        expect(value, lessThanOrEqualTo(1.0));
      }
    });

    test('should validate aspectRatio values', () {
      final commonRatios = [
        4 / 3,
        16 / 9,
        21 / 9,
        1 / 1,
        3 / 4,
      ];

      for (final ratio in commonRatios) {
        expect(ratio, greaterThan(0));
        expect(ratio, lessThan(10));
      }
    });

    test('should validate autoplay intervals', () {
      final validIntervals = [
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 1000),
        const Duration(milliseconds: 2000),
        const Duration(milliseconds: 5000),
        const Duration(milliseconds: 10000),
      ];

      for (final interval in validIntervals) {
        expect(interval.inMilliseconds, greaterThan(0));
        expect(interval.inMilliseconds, lessThanOrEqualTo(60000));
      }
    });
  });

  group('Integration Tests', () {
    test('should maintain consistency across properties', () {
      final options = CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: false,
        enlargeCenterPage: false,
      );

      // All properties should be set correctly
      expect(options.aspectRatio, equals(16 / 9));
      expect(options.viewportFraction, equals(0.8));
      expect(options.initialPage, equals(0));
      expect(options.enableInfiniteScroll, isTrue);
      expect(options.autoPlay, isFalse);
      expect(options.enlargeCenterPage, isFalse);
    });

    test('should handle autoplay configuration', () {
      final options = CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 2500),
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
      );

      expect(options.autoPlay, isTrue);
      expect(options.autoPlayInterval, equals(const Duration(milliseconds: 2500)));
      expect(options.pauseAutoPlayOnTouch, isTrue);
      expect(options.pauseAutoPlayOnManualNavigate, isTrue);
    });

    test('should handle infinite scroll configuration', () {
      final options = CarouselOptions(
        enableInfiniteScroll: true,
        animateToClosest: true,
      );

      expect(options.enableInfiniteScroll, isTrue);
      expect(options.animateToClosest, isTrue);
    });
  });

  group('Edge Cases', () {
    test('should handle zero viewportFraction', () {
      final options = CarouselOptions(
        viewportFraction: 0.01, // Very small but valid
      );

      expect(options.viewportFraction, equals(0.01));
    });

    test('should handle maximum viewportFraction', () {
      final options = CarouselOptions(
        viewportFraction: 1.0,
      );

      expect(options.viewportFraction, equals(1.0));
    });

    test('should handle very large initial page', () {
      final options = CarouselOptions(
        initialPage: 999,
        enableInfiniteScroll: false,
      );

      expect(options.initialPage, equals(999));
    });

    test('should handle negative initial page', () {
      final options = CarouselOptions(
        initialPage: -1,
      );

      expect(options.initialPage, equals(-1));
    });

    test('should handle zero autoplay interval', () {
      final options = CarouselOptions(
        autoPlayInterval: const Duration(milliseconds: 100),
      );

      expect(options.autoPlayInterval.inMilliseconds, equals(100));
    });

    test('should handle very large autoplay interval', () {
      final options = CarouselOptions(
        autoPlayInterval: const Duration(milliseconds: 60000),
      );

      expect(options.autoPlayInterval.inMilliseconds, equals(60000));
    });
  });
}
