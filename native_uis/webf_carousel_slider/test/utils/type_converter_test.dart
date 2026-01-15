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

  group('TypeConverter.parseEasing', () {
    test('should parse easing aliases', () {
      expect(TypeConverter.parseEasing('ease'), Curves.ease);
      expect(TypeConverter.parseEasing('ease-in'), Curves.easeIn);
      expect(TypeConverter.parseEasing('ease-out'), Curves.easeOut);
      expect(TypeConverter.parseEasing('ease-in-out'), Curves.easeInOut);
      expect(TypeConverter.parseEasing('linear'), Curves.linear);
      expect(TypeConverter.parseEasing('fast-out-slow-in'),
          Curves.fastOutSlowIn);
    });

    test('should parse cubic-bezier', () {
      final curve = TypeConverter.parseEasing('cubic-bezier(0.1, 0.2, 0.3, 0.4)');
      expect(curve, isA<Cubic>());
    });

    test('should fallback on invalid easing', () {
      expect(TypeConverter.parseEasing('invalid'), Curves.ease);
    });
  });

  group('TypeConverter.normalizeEasingName', () {
    test('should normalize easing names', () {
      expect(TypeConverter.normalizeEasingName('easeIn'), 'ease-in');
      expect(TypeConverter.normalizeEasingName('fastOutSlowIn'),
          'fast-out-slow-in');
    });

    test('should normalize cubic-bezier', () {
      final name = TypeConverter.normalizeEasingName(
        'cubic-bezier(0.1, 0.2, 0.3, 0.4)',
      );
      expect(name.startsWith('cubic-bezier('), isTrue);
    });
  });

  group('TypeConverter.clampViewportFraction', () {
    test('should keep values without clamping', () {
      expect(TypeConverter.clampViewportFraction(0.0), 0.0);
      expect(TypeConverter.clampViewportFraction(1.5), 1.5);
      expect(TypeConverter.clampViewportFraction(0.5), 0.5);
    });
  });

  group('TypeConverter.clampAutoPlayIntervalMs', () {
    test('should keep values without clamping', () {
      expect(TypeConverter.clampAutoPlayIntervalMs(100), 100);
      expect(TypeConverter.clampAutoPlayIntervalMs(70000), 70000);
      expect(TypeConverter.clampAutoPlayIntervalMs(3000), 3000);
    });
  });

  group('TypeConverter.clampAutoPlayAnimationDurationMs', () {
    test('should keep values without clamping', () {
      expect(TypeConverter.clampAutoPlayAnimationDurationMs(-10), -10);
      expect(TypeConverter.clampAutoPlayAnimationDurationMs(6000), 6000);
      expect(TypeConverter.clampAutoPlayAnimationDurationMs(300), 300);
    });
  });
}
