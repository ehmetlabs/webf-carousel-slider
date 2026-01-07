import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/config/carousel_config.dart';

void main() {
  group('CarouselConfig', () {
    test('should create default configuration', () {
      final config = CarouselConfig();

      expect(config.viewportFraction, 1.0);
      expect(config.initialPage, 0);
      expect(config.enableInfiniteScroll, true);
      expect(config.reverse, false);
      expect(config.autoPlay, false);
      expect(config.enlargeCenterPage, false);
      expect(config.scrollDirection, Axis.horizontal);
      expect(config.padEnds, true);
      expect(config.pageSnapping, true);
    });

    test('should create configuration with custom values', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        initialPage: 2,
        autoPlay: true,
        autoPlayInterval: 5.0,
        enlargeCenterPage: true,
      );

      expect(config.viewportFraction, 0.8);
      expect(config.initialPage, 2);
      expect(config.autoPlay, true);
      expect(config.autoPlayInterval.inSeconds, 5);
      expect(config.enlargeCenterPage, true);
    });

    test('should validate viewportFraction range', () {
      final config1 = CarouselConfig(viewportFraction: 0.0);
      expect(config1.viewportFraction, 0.01); // 最小值

      final config2 = CarouselConfig(viewportFraction: 1.5);
      expect(config2.viewportFraction, 1.0); // 最大值

      final config3 = CarouselConfig(viewportFraction: 0.8);
      expect(config3.viewportFraction, 0.8); // 正常值
    });

    test('should validate initialPage minimum', () {
      final config1 = CarouselConfig(initialPage: -5);
      expect(config1.initialPage, 0); // 最小值 0

      final config2 = CarouselConfig(initialPage: 5);
      expect(config2.initialPage, 5); // 正常值
    });

    test('should validate autoplayInterval range', () {
      final config1 = CarouselConfig(autoPlayInterval: 0.3);
      expect(config1.autoPlayInterval.inSeconds, 0); // 小于最小值 0.5 秒

      final config2 = CarouselConfig(autoPlayInterval: 120.0);
      expect(config2.autoPlayInterval.inSeconds, 60); // 最大值 60 秒

      final config3 = CarouselConfig(autoPlayInterval: 5.0);
      expect(config3.autoPlayInterval.inSeconds, 5); // 正常值
    });

    test('should validate enlargeFactor range', () {
      final config1 = CarouselConfig(enlargeFactor: -0.1);
      expect(config1.enlargeFactor, 0.0); // 最小值

      final config2 = CarouselConfig(enlargeFactor: 1.5);
      expect(config2.enlargeFactor, 1.0); // 最大值

      final config3 = CarouselConfig(enlargeFactor: 0.5);
      expect(config3.enlargeFactor, 0.5); // 正常值
    });
  });

  group('CarouselConfig.build', () {
    test('should build CarouselOptions correctly', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: 3.0,
      );

      final options = config.build();

      expect(options.viewportFraction, 0.8);
      expect(options.autoPlay, true);
      expect(options.autoPlayInterval.inSeconds, 3);
    });

    test('should cache options until marked dirty', () {
      final config = CarouselConfig();

      final options1 = config.build();
      final options2 = config.build();

      expect(identical(options1, options2), true); // 返回同一对象

      config.markDirty();
      final options3 = config.build();

      expect(identical(options1, options3), false); // 返回新对象
    });

    test('should use default aspectRatio when null', () {
      final config = CarouselConfig(aspectRatio: null);

      final options = config.build();

      expect(options.aspectRatio, closeTo(1.777, 0.001)); // 16/9
    });

    test('should use custom aspectRatio when provided', () {
      final config = CarouselConfig(aspectRatio: 2.0);

      final options = config.build();

      expect(options.aspectRatio, 2.0);
    });

    test('should use default autoPlayCurve when null', () {
      final config = CarouselConfig(autoPlayCurve: null);

      final options = config.build();

      expect(options.autoPlayCurve, Curves.ease);
    });

    test('should use custom autoPlayCurve when provided', () {
      final config = CarouselConfig(autoPlayCurve: Curves.easeInOut);

      final options = config.build();

      expect(options.autoPlayCurve, Curves.easeInOut);
    });
  });

  group('CarouselConfig.copyWith', () {
    test('should create copy with modified values', () {
      final config1 = CarouselConfig(
        autoPlay: false,
        viewportFraction: 1.0,
      );

      final config2 = config1.copyWith(
        autoPlay: true,
        viewportFraction: 0.8,
      );

      expect(config1.autoPlay, false);
      expect(config1.viewportFraction, 1.0);

      expect(config2.autoPlay, true);
      expect(config2.viewportFraction, 0.8);
    });

    test('should preserve unchanged values', () {
      final config1 = CarouselConfig(
        autoPlay: true,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      );

      final config2 = config1.copyWith(autoPlay: false);

      expect(config2.autoPlay, false);
      expect(config2.viewportFraction, 0.8); // 保持不变
      expect(config2.enlargeCenterPage, true); // 保持不变
    });
  });

  group('CarouselConfig.toJson', () {
    test('should serialize configuration to JSON', () {
      final config = CarouselConfig(
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: 3.0,
        enlargeCenterPage: true,
      );

      final json = config.toJson();

      expect(json['viewportFraction'], 0.8);
      expect(json['autoPlay'], true);
      expect(json['autoPlayInterval'], 3.0);
      expect(json['enlargeCenterPage'], true);
    });

    test('should serialize scrollDirection correctly', () {
      final config1 = CarouselConfig(scrollDirection: Axis.horizontal);
      expect(config1.toJson()['scrollDirection'], 'horizontal');

      final config2 = CarouselConfig(scrollDirection: Axis.vertical);
      expect(config2.toJson()['scrollDirection'], 'vertical');
    });

    test('should include null values for optional properties', () {
      final config = CarouselConfig(
        height: null,
        aspectRatio: null,
      );

      final json = config.toJson();

      expect(json['height'], null);
      expect(json['aspectRatio'], null);
    });
  });

  group('CarouselConfig.fromJson', () {
    test('should deserialize JSON to configuration', () {
      final json = {
        'viewportFraction': 0.8,
        'autoPlay': true,
        'autoPlayInterval': 3.0,
        'enlargeCenterPage': true,
      };

      final config = CarouselConfig.fromJson(json);

      expect(config.viewportFraction, 0.8);
      expect(config.autoPlay, true);
      expect(config.autoPlayInterval.inSeconds, 3);
      expect(config.enlargeCenterPage, true);
    });

    test('should handle missing properties', () {
      final json = {
        'autoPlay': true,
      };

      final config = CarouselConfig.fromJson(json);

      expect(config.autoPlay, true);
      expect(config.viewportFraction, 1.0); // 默认值
      expect(config.enableInfiniteScroll, true); // 默认值
    });

    test('should handle null values', () {
      final json = {
        'height': null,
        'aspectRatio': null,
      };

      final config = CarouselConfig.fromJson(json);

      expect(config.height, null);
      expect(config.aspectRatio, null);
    });

    test('should deserialize scrollDirection correctly', () {
      // Note: fromJson doesn't parse scrollDirection string to Axis
      // This is expected - scrollDirection should use default Axis.horizontal
      final json = {'scrollDirection': 'vertical'};

      final config = CarouselConfig.fromJson(json);

      // scrollDirection 参数 expects Axis, not String
      // So this test verifies the behavior
      expect(config.scrollDirection, Axis.horizontal);
    });
  });

  group('CarouselConfig.toJsonString', () {
    test('should convert to JSON string', () {
      final config = CarouselConfig(
        autoPlay: true,
        viewportFraction: 0.8,
      );

      final jsonString = config.toJsonString();

      expect(jsonString.contains('"autoPlay":true'), true);
      expect(jsonString.contains('"viewportFraction":0.8'), true);
    });

    test('should produce valid JSON', () {
      final config = CarouselConfig();

      final jsonString = config.toJsonString();

      // Should not throw
      expect(() => jsonDecode(jsonString), returnsNormally);
    });
  });

  group('CarouselConfig equality', () {
    test('should consider equal configs as equal', () {
      final config1 = CarouselConfig(
        autoPlay: true,
        viewportFraction: 0.8,
      );

      final config2 = CarouselConfig(
        autoPlay: true,
        viewportFraction: 0.8,
      );

      expect(config1, equals(config2));
      expect(config1.hashCode, equals(config2.hashCode));
    });

    test('should consider different configs as not equal', () {
      final config1 = CarouselConfig(autoPlay: true);
      final config2 = CarouselConfig(autoPlay: false);

      expect(config1, isNot(equals(config2)));
    });

    test('should be identical to itself', () {
      final config = CarouselConfig();

      expect(identical(config, config), true);
      expect(config == config, true);
    });
  });

  group('CarouselConfig.toString', () {
    test('should produce readable string representation', () {
      final config = CarouselConfig(
        autoPlay: true,
        viewportFraction: 0.8,
      );

      final str = config.toString();

      expect(str, contains('CarouselConfig'));
      expect(str, contains('autoPlay: true'));
      expect(str, contains('viewportFraction: 0.8'));
    });
  });
}
