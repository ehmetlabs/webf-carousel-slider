import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/utils/type_converter.dart';

void main() {
  group('TypeConverter.toBool', () {
    test('should convert bool types correctly', () {
      expect(TypeConverter.toBool(true), true);
      expect(TypeConverter.toBool(false), false);
    });

    test('should convert string types correctly', () {
      expect(TypeConverter.toBool('true'), true);
      expect(TypeConverter.toBool('false'), false);
      expect(TypeConverter.toBool(''), true);
      expect(TypeConverter.toBool('random'), false);
    });

    test('should convert numeric types correctly', () {
      expect(TypeConverter.toBool(1), true);
      expect(TypeConverter.toBool(0), false);
      expect(TypeConverter.toBool(3.14), true);
      expect(TypeConverter.toBool(0.0), false);
    });
  });

  group('TypeConverter.toDouble', () {
    test('should convert numeric and string values', () {
      expect(TypeConverter.toDouble(3.14), 3.14);
      expect(TypeConverter.toDouble(42), 42.0);
      expect(TypeConverter.toDouble('3.14'), 3.14);
      expect(TypeConverter.toDouble('invalid'), 0.0);
    });

    test('should enforce min/max constraints', () {
      expect(TypeConverter.toDouble(-1, min: 0), 0.0);
      expect(TypeConverter.toDouble(10, max: 5), 5.0);
    });
  });

  group('TypeConverter.toInt', () {
    test('should convert numeric and string values', () {
      expect(TypeConverter.toInt(3.14), 3);
      expect(TypeConverter.toInt('42'), 42);
      expect(TypeConverter.toInt('invalid', defaultValue: 7), 7);
    });

    test('should enforce min/max constraints', () {
      expect(TypeConverter.toInt(-1, min: 0), 0);
      expect(TypeConverter.toInt(20, max: 10), 10);
    });
  });

  group('TypeConverter.parseDirection', () {
    test('should parse horizontal values', () {
      expect(TypeConverter.parseDirection('horizontal'), Axis.horizontal);
      expect(TypeConverter.parseDirection('Axis.horizontal'), Axis.horizontal);
    });

    test('should parse vertical values', () {
      expect(TypeConverter.parseDirection('vertical'), Axis.vertical);
      expect(TypeConverter.parseDirection('Axis.vertical'), Axis.vertical);
    });
  });

  group('TypeConverter.clampViewportFraction', () {
    test('should clamp to valid range', () {
      expect(TypeConverter.clampViewportFraction(0.0), 0.01);
      expect(TypeConverter.clampViewportFraction(1.5), 1.0);
      expect(TypeConverter.clampViewportFraction(0.5), 0.5);
    });
  });

  group('TypeConverter.clampSlidesPerView', () {
    test('should clamp to valid range', () {
      expect(TypeConverter.clampSlidesPerView(0), 1.0);
      expect(TypeConverter.clampSlidesPerView(12), 10.0);
      expect(TypeConverter.clampSlidesPerView(2.5), 2.5);
      expect(TypeConverter.clampSlidesPerView('auto'), 1.0);
    });
  });

  group('TypeConverter.slidesPerViewToViewportFraction', () {
    test('should map slidesPerView to viewportFraction', () {
      expect(TypeConverter.slidesPerViewToViewportFraction(2), 0.5);
      expect(TypeConverter.slidesPerViewToViewportFraction(1), 1.0);
    });
  });

  group('TypeConverter.clampAutoplayDelayMs', () {
    test('should clamp to valid range', () {
      expect(TypeConverter.clampAutoplayDelayMs(100), 500);
      expect(TypeConverter.clampAutoplayDelayMs(70000), 60000);
      expect(TypeConverter.clampAutoplayDelayMs(3000), 3000);
    });
  });

  group('TypeConverter.clampSpeedMs', () {
    test('should clamp to valid range', () {
      expect(TypeConverter.clampSpeedMs(-10), 0);
      expect(TypeConverter.clampSpeedMs(6000), 5000);
      expect(TypeConverter.clampSpeedMs(300), 300);
    });
  });
}
