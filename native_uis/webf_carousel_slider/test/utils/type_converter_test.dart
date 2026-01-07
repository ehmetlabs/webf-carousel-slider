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
      expect(TypeConverter.toBool(42), true);
      expect(TypeConverter.toBool(3.14), true);
      expect(TypeConverter.toBool(0.0), false);
    });

    test('should handle null with default value', () {
      expect(TypeConverter.toBool(null), false);
      expect(TypeConverter.toBool(null, defaultValue: true), true);
      expect(TypeConverter.toBool(null, defaultValue: false), false);
    });

    test('should handle invalid types with default value', () {
      expect(TypeConverter.toBool([]), false);
      expect(TypeConverter.toBool({}), false);
      expect(TypeConverter.toBool([], defaultValue: true), true);
    });
  });

  group('TypeConverter.toDouble', () {
    test('should convert double types correctly', () {
      expect(TypeConverter.toDouble(3.14), 3.14);
      expect(TypeConverter.toDouble(0.0), 0.0);
      expect(TypeConverter.toDouble(-5.5), -5.5);
    });

    test('should convert int types correctly', () {
      expect(TypeConverter.toDouble(42), 42.0);
      expect(TypeConverter.toDouble(0), 0.0);
      expect(TypeConverter.toDouble(-10), -10.0);
    });

    test('should convert string types correctly', () {
      expect(TypeConverter.toDouble('3.14'), 3.14);
      expect(TypeConverter.toDouble('42'), 42.0);
      expect(TypeConverter.toDouble('-5.5'), -5.5);
      expect(TypeConverter.toDouble('invalid'), 0.0);
      expect(TypeConverter.toDouble(''), 0.0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.toDouble(null), 0.0);
      expect(TypeConverter.toDouble(null, defaultValue: 5.0), 5.0);
    });

    test('should use default value for invalid strings', () {
      expect(TypeConverter.toDouble('invalid'), 0.0);
      expect(TypeConverter.toDouble('invalid', defaultValue: 10.0), 10.0);
    });

    test('should enforce min constraint', () {
      expect(TypeConverter.toDouble(-0.5, min: 0.0), 0.0);
      expect(TypeConverter.toDouble(0.5, min: 0.0), 0.5);
      expect(TypeConverter.toDouble(1.5, min: 1.0), 1.5);
      expect(TypeConverter.toDouble(0.5, min: 1.0), 1.0);
    });

    test('should enforce max constraint', () {
      expect(TypeConverter.toDouble(1.5, max: 1.0), 1.0);
      expect(TypeConverter.toDouble(0.5, max: 1.0), 0.5);
      expect(TypeConverter.toDouble(0.5, max: 1.0), 0.5);
      expect(TypeConverter.toDouble(2.0, max: 1.0), 1.0);
    });

    test('should enforce both min and max constraints', () {
      expect(TypeConverter.toDouble(0.5, min: 0.0, max: 1.0), 0.5);
      expect(TypeConverter.toDouble(-0.5, min: 0.0, max: 1.0), 0.0);
      expect(TypeConverter.toDouble(1.5, min: 0.0, max: 1.0), 1.0);
    });
  });

  group('TypeConverter.toInt', () {
    test('should convert int types correctly', () {
      expect(TypeConverter.toInt(42), 42);
      expect(TypeConverter.toInt(0), 0);
      expect(TypeConverter.toInt(-10), -10);
    });

    test('should convert double types correctly', () {
      expect(TypeConverter.toInt(3.14), 3);
      expect(TypeConverter.toInt(0.0), 0);
      expect(TypeConverter.toInt(-5.9), -5);
      expect(TypeConverter.toInt(5.9), 5);
    });

    test('should convert string types correctly', () {
      expect(TypeConverter.toInt('42'), 42);
      expect(TypeConverter.toInt('3.14'), 3);
      expect(TypeConverter.toInt('-5'), -5);
      expect(TypeConverter.toInt('invalid'), 0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.toInt(null), 0);
      expect(TypeConverter.toInt(null, defaultValue: 10), 10);
    });

    test('should enforce min and max constraints', () {
      expect(TypeConverter.toInt(5, min: 0, max: 10), 5);
      expect(TypeConverter.toInt(-5, min: 0, max: 10), 0);
      expect(TypeConverter.toInt(15, min: 0, max: 10), 10);
    });
  });

  group('TypeConverter.asString', () {
    test('should convert various types to string', () {
      expect(TypeConverter.asString('hello'), 'hello');
      expect(TypeConverter.asString(42), '42');
      expect(TypeConverter.asString(3.14), '3.14');
      expect(TypeConverter.asString(true), 'true');
      expect(TypeConverter.asString(false), 'false');
    });

    test('should use default value for null', () {
      expect(TypeConverter.asString(null), '');
      expect(TypeConverter.asString(null, defaultValue: 'N/A'), 'N/A');
    });
  });

  group('TypeConverter.parseAutoPlayCurve', () {
    test('should return Curve if value is already a Curve', () {
      expect(TypeConverter.parseAutoPlayCurve(Curves.ease), Curves.ease);
      expect(TypeConverter.parseAutoPlayCurve(Curves.easeIn), Curves.easeIn);
    });

    test('should parse full curve names', () {
      expect(TypeConverter.parseAutoPlayCurve('Curves.ease'), Curves.ease);
      expect(TypeConverter.parseAutoPlayCurve('Curves.easeIn'), Curves.easeIn);
      expect(TypeConverter.parseAutoPlayCurve('Curves.easeOut'), Curves.easeOut);
      expect(TypeConverter.parseAutoPlayCurve('Curves.easeInOut'), Curves.easeInOut);
      expect(TypeConverter.parseAutoPlayCurve('Curves.fastOutSlowIn'), Curves.fastOutSlowIn);
    });

    test('should parse short curve names', () {
      expect(TypeConverter.parseAutoPlayCurve('ease'), Curves.ease);
      expect(TypeConverter.parseAutoPlayCurve('easeIn'), Curves.easeIn);
      expect(TypeConverter.parseAutoPlayCurve('easeOut'), Curves.easeOut);
      expect(TypeConverter.parseAutoPlayCurve('easeInOut'), Curves.easeInOut);
      expect(TypeConverter.parseAutoPlayCurve('fastOutSlowIn'), Curves.fastOutSlowIn);
    });

    test('should be case-insensitive', () {
      expect(TypeConverter.parseAutoPlayCurve('EASE'), Curves.ease);
      expect(TypeConverter.parseAutoPlayCurve('EaseIn'), Curves.easeIn);
      expect(TypeConverter.parseAutoPlayCurve('CURVES.EASE'), Curves.ease);
    });

    test('should return null for invalid values', () {
      expect(TypeConverter.parseAutoPlayCurve('invalid'), null);
      expect(TypeConverter.parseAutoPlayCurve(''), null);
      expect(TypeConverter.parseAutoPlayCurve(null), null);
    });
  });

  group('TypeConverter.parseScrollDirection', () {
    test('should return Axis if value is already an Axis', () {
      expect(TypeConverter.parseScrollDirection(Axis.horizontal), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection(Axis.vertical), Axis.vertical);
    });

    test('should parse horizontal direction', () {
      expect(TypeConverter.parseScrollDirection('Axis.horizontal'), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection('horizontal'), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection('HORIZONTAL'), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection('Horizontal'), Axis.horizontal);
    });

    test('should parse vertical direction', () {
      expect(TypeConverter.parseScrollDirection('Axis.vertical'), Axis.vertical);
      expect(TypeConverter.parseScrollDirection('vertical'), Axis.vertical);
      expect(TypeConverter.parseScrollDirection('VERTICAL'), Axis.vertical);
      expect(TypeConverter.parseScrollDirection('Vertical'), Axis.vertical);
    });

    test('should default to horizontal for invalid values', () {
      expect(TypeConverter.parseScrollDirection('invalid'), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection(''), Axis.horizontal);
      expect(TypeConverter.parseScrollDirection(null), Axis.horizontal);
    });
  });

  group('TypeConverter.validateViewportFraction', () {
    test('should accept valid values', () {
      expect(TypeConverter.validateViewportFraction(0.8), 0.8);
      expect(TypeConverter.validateViewportFraction(1.0), 1.0);
      expect(TypeConverter.validateViewportFraction(0.5), 0.5);
    });

    test('should enforce minimum value', () {
      expect(TypeConverter.validateViewportFraction(0.0), 0.01);
      expect(TypeConverter.validateViewportFraction(0.01), 0.01);
      expect(TypeConverter.validateViewportFraction(-0.5), 0.01);
    });

    test('should enforce maximum value', () {
      expect(TypeConverter.validateViewportFraction(1.0), 1.0);
      expect(TypeConverter.validateViewportFraction(1.5), 1.0);
      expect(TypeConverter.validateViewportFraction(2.0), 1.0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.validateViewportFraction(null), 1.0);
      expect(TypeConverter.validateViewportFraction(null, defaultValue: 0.8), 0.8);
    });

    test('should use default value for invalid strings', () {
      expect(TypeConverter.validateViewportFraction('invalid'), 1.0);
      expect(TypeConverter.validateViewportFraction('0.8'), 0.8);
    });
  });

  group('TypeConverter.validateAspectRatio', () {
    test('should accept valid values', () {
      expect(TypeConverter.validateAspectRatio(16 / 9), closeTo(1.777, 0.001));
      expect(TypeConverter.validateAspectRatio(0.5), 0.5);
      expect(TypeConverter.validateAspectRatio(2.0), 2.0);
    });

    test('should enforce minimum value', () {
      expect(TypeConverter.validateAspectRatio(0.05), 0.1);
      expect(TypeConverter.validateAspectRatio(0.1), 0.1);
      expect(TypeConverter.validateAspectRatio(-1.0), 0.1);
    });

    test('should enforce maximum value', () {
      expect(TypeConverter.validateAspectRatio(10.0), 10.0);
      expect(TypeConverter.validateAspectRatio(15.0), 10.0);
      expect(TypeConverter.validateAspectRatio(20.0), 10.0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.validateAspectRatio(null), closeTo(1.777, 0.001));
      expect(TypeConverter.validateAspectRatio(null, defaultValue: 2.0), 2.0);
    });
  });

  group('TypeConverter.validateAutoplayInterval', () {
    test('should accept valid values', () {
      expect(TypeConverter.validateAutoplayInterval(3.0), 3.0);
      expect(TypeConverter.validateAutoplayInterval(5.0), 5.0);
      expect(TypeConverter.validateAutoplayInterval(10.0), 10.0);
    });

    test('should enforce minimum value', () {
      expect(TypeConverter.validateAutoplayInterval(0.3), 0.5);
      expect(TypeConverter.validateAutoplayInterval(0.5), 0.5);
      expect(TypeConverter.validateAutoplayInterval(0.0), 0.5);
    });

    test('should enforce maximum value', () {
      expect(TypeConverter.validateAutoplayInterval(60.0), 60.0);
      expect(TypeConverter.validateAutoplayInterval(120.0), 60.0);
      expect(TypeConverter.validateAutoplayInterval(200.0), 60.0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.validateAutoplayInterval(null), 3.0);
      expect(TypeConverter.validateAutoplayInterval(null, defaultValue: 5.0), 5.0);
    });
  });

  group('TypeConverter.validateEnlargeFactor', () {
    test('should accept valid values', () {
      expect(TypeConverter.validateEnlargeFactor(0.3), 0.3);
      expect(TypeConverter.validateEnlargeFactor(0.0), 0.0);
      expect(TypeConverter.validateEnlargeFactor(1.0), 1.0);
      expect(TypeConverter.validateEnlargeFactor(0.5), 0.5);
    });

    test('should enforce minimum value', () {
      expect(TypeConverter.validateEnlargeFactor(-0.1), 0.0);
      expect(TypeConverter.validateEnlargeFactor(0.0), 0.0);
      expect(TypeConverter.validateEnlargeFactor(-1.0), 0.0);
    });

    test('should enforce maximum value', () {
      expect(TypeConverter.validateEnlargeFactor(1.0), 1.0);
      expect(TypeConverter.validateEnlargeFactor(1.5), 1.0);
      expect(TypeConverter.validateEnlargeFactor(2.0), 1.0);
    });

    test('should use default value for null', () {
      expect(TypeConverter.validateEnlargeFactor(null), 0.3);
      expect(TypeConverter.validateEnlargeFactor(null, defaultValue: 0.5), 0.5);
    });
  });
}
