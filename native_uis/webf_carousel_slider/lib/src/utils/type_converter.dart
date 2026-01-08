import 'package:flutter/material.dart';

/// 统一的类型转换工具类
///
/// 提供安全的类型转换、默认值和输入验证
/// 用于消除重复的类型转换代码，提升类型安全
class TypeConverter {
  // 私有构造函数，防止实例化
  TypeConverter._();

  /// 安全地将 dynamic 转换为 bool
  ///
  /// 支持的输入格式:
  /// - bool 类型直接返回
  /// - 'true' 或空字符串 → true
  /// - 其他字符串 → false
  /// - 数值 → 非 0 为 true
  /// - null → defaultValue
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.toBool(true)              // true
  /// TypeConverter.toBool('true')            // true
  /// TypeConverter.toBool('')                // true
  /// TypeConverter.toBool('false')           // false
  /// TypeConverter.toBool(1)                 // true
  /// TypeConverter.toBool(0)                 // false
  /// TypeConverter.toBool(null)             // false
  /// TypeConverter.toBool(null, defaultValue: true) // true
  /// ```
  static bool toBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) return value == 'true' || value == '';
    if (value is int || value is double) return value != 0;
    return defaultValue;
  }

  /// 安全地将 dynamic 转换为 double
  ///
  /// 参数:
  /// - value: 要转换的值
  /// - defaultValue: 转换失败时的默认值
  /// - min: 最小值（可选）
  /// - max: 最大值（可选）
  ///
  /// 返回: 转换后的 double，保证在 [min, max] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.toDouble(3.14)                           // 3.14
  /// TypeConverter.toDouble(42)                             // 42.0
  /// TypeConverter.toDouble('3.14')                         // 3.14
  /// TypeConverter.toDouble('invalid')                      // 0.0
  /// TypeConverter.toDouble('invalid', defaultValue: 5.0)  // 5.0
  /// TypeConverter.toDouble(1.5, min: 0.0, max: 1.0)       // 1.0
  /// TypeConverter.toDouble(-0.5, min: 0.0, max: 1.0)      // 0.0
  /// ```
  static double toDouble(
    dynamic value, {
    double defaultValue = 0.0,
    double? min,
    double? max,
  }) {
    double? result;

    if (value == null) {
      result = defaultValue;
    } else if (value is double) {
      result = value;
    } else if (value is int) {
      result = value.toDouble();
    } else if (value is String) {
      result = double.tryParse(value);
    }

    // 如果转换失败，使用默认值
    result ??= defaultValue;

    // 应用范围限制
    if (min != null && result < min) result = min;
    if (max != null && result > max) result = max;

    return result;
  }

  /// 安全地将 dynamic 转换为 int
  ///
  /// 参数:
  /// - value: 要转换的值
  /// - defaultValue: 转换失败时的默认值
  /// - min: 最小值（可选）
  /// - max: 最大值（可选）
  ///
  /// 返回: 转换后的 int，保证在 [min, max] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.toInt(42)                           // 42
  /// TypeConverter.toInt(3.14)                         // 3
  /// TypeConverter.toInt('42')                         // 42
  /// TypeConverter.toInt('invalid')                    // 0
  /// TypeConverter.toInt('invalid', defaultValue: 10) // 10
  /// TypeConverter.toInt(15, min: 0, max: 10)         // 10
  /// TypeConverter.toInt(-5, min: 0, max: 10)         // 0
  /// ```
  static int toInt(
    dynamic value, {
    int defaultValue = 0,
    int? min,
    int? max,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue.toDouble(),
      min: min?.toDouble(),
      max: max?.toDouble(),
    ).toInt();
  }

  /// 安全地将 dynamic 转换为 String
  ///
  /// 参数:
  /// - value: 要转换的值
  /// - defaultValue: 转换失败时的默认值
  ///
  /// 返回: 转换后的 String
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.asString('hello')                   // 'hello'
  /// TypeConverter.asString(42)                        // '42'
  /// TypeConverter.asString(true)                      // 'true'
  /// TypeConverter.asString(null)                      // ''
  /// TypeConverter.asString(null, defaultValue: 'N/A') // 'N/A'
  /// ```
  static String asString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// 解析 autoPlayCurve 字符串为 Flutter Curve
  ///
  /// 使用 Map 查找替代 if-else 链，提升性能和可维护性
  ///
  /// 支持的格式:
  /// - Curve 类型直接返回
  /// - 完整枚举名（如 'Curves.ease'）
  /// - 简短名称（如 'ease'）
  /// - 不区分大小写
  ///
  /// 返回: 对应的 Curve，未找到返回 null
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.parseAutoPlayCurve(Curves.ease)           // Curves.ease
  /// TypeConverter.parseAutoPlayCurve('Curves.ease')         // Curves.ease
  /// TypeConverter.parseAutoPlayCurve('ease')               // Curves.ease
  /// TypeConverter.parseAutoPlayCurve('EASE')               // Curves.ease
  /// TypeConverter.parseAutoPlayCurve('Curves.easeInOut')   // Curves.easeInOut
  /// TypeConverter.parseAutoPlayCurve('invalid')            // null
  /// TypeConverter.parseAutoPlayCurve(null)                // null
  /// ```
  static Curve? parseAutoPlayCurve(dynamic value) {
    if (value == null) return null;
    if (value is Curve) return value;

    final strValue = value.toString().toLowerCase();

    // 使用 Map 替代 if-else 链
    const curveMap = <String, Curve>{
      'curves.ease': Curves.ease,
      'ease': Curves.ease,
      'curves.easein': Curves.easeIn,
      'easein': Curves.easeIn,
      'curves.easeout': Curves.easeOut,
      'easeout': Curves.easeOut,
      'curves.easeinout': Curves.easeInOut,
      'easeinout': Curves.easeInOut,
      'curves.fastoutslowin': Curves.fastOutSlowIn,
      'fastoutslowin': Curves.fastOutSlowIn,
      'curves.linear': Curves.linear,
      'linear': Curves.linear,
    };

    return curveMap[strValue];
  }

  /// 解析 scrollDirection 字符串为 Axis
  ///
  /// 参数:
  /// - value: 要转换的值
  ///
  /// 返回: Axis.horizontal 或 Axis.vertical
  ///
  /// 支持的格式:
  /// - Axis 类型直接返回
  /// - 包含 'vertical' 的字符串（不区分大小写）→ Axis.vertical
  /// - 其他 → Axis.horizontal (默认)
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.parseScrollDirection(Axis.horizontal)  // Axis.horizontal
  /// TypeConverter.parseScrollDirection('Axis.horizontal') // Axis.horizontal
  /// TypeConverter.parseScrollDirection('horizontal')      // Axis.horizontal
  /// TypeConverter.parseScrollDirection('Axis.vertical')   // Axis.vertical
  /// TypeConverter.parseScrollDirection('vertical')        // Axis.vertical
  /// TypeConverter.parseScrollDirection('VERTICAL')        // Axis.vertical
  /// TypeConverter.parseScrollDirection('invalid')         // Axis.horizontal
  /// TypeConverter.parseScrollDirection(null)             // Axis.horizontal
  /// ```
  static Axis parseScrollDirection(dynamic value) {
    if (value == null) return Axis.horizontal;
    if (value is Axis) return value;

    final strValue = value.toString().toLowerCase();
    return strValue.contains('vertical') ? Axis.vertical : Axis.horizontal;
  }

  /// 验证并限制 viewportFraction 在有效范围内
  ///
  /// viewportFraction 表示每个页面占视口的分数，必须在 (0.0, 1.0] 范围内
  ///
  /// 参数:
  /// - value: 要验证的值
  /// - defaultValue: 转换失败时的默认值
  ///
  /// 返回: 验证后的 double，保证在 (0.0, 1.0] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.validateViewportFraction(0.8)   // 0.8
  /// TypeConverter.validateViewportFraction(1.0)   // 1.0
  /// TypeConverter.validateViewportFraction(0.0)   // 0.01 (最小值)
  /// TypeConverter.validateViewportFraction(1.5)   // 1.0 (最大值)
  /// TypeConverter.validateViewportFraction(null)  // 0.8 (默认值)
  /// ```
  static double validateViewportFraction(
    dynamic value, {
    double defaultValue = 0.8,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.01, // 最小 1% 可见
      max: 1.0, // 最大 100% 可见
    );
  }

  /// 验证并限制 aspectRatio 在合理范围内
  ///
  /// aspectRatio 表示宽度与高度的比值
  ///
  /// 参数:
  /// - value: 要验证的值
  /// - defaultValue: 转换失败时的默认值
  ///
  /// 返回: 验证后的 double，保证在 [0.1, 10.0] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.validateAspectRatio(16/9)    // 1.777...
  /// TypeConverter.validateAspectRatio(0.5)     // 0.5
  /// TypeConverter.validateAspectRatio(0.05)    // 0.1 (最小值)
  /// TypeConverter.validateAspectRatio(15.0)    // 10.0 (最大值)
  /// TypeConverter.validateAspectRatio(null)    // 1.777... (默认值 16/9)
  /// ```
  static double validateAspectRatio(dynamic value, {double defaultValue = 16 / 9}) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.1, // 最小比例 1:10
      max: 10.0, // 最大比例 10:1
    );
  }

  /// 验证并限制 autoplayInterval 在合理范围内
  ///
  /// autoplayInterval 表示自动播放间隔（秒）
  ///
  /// 参数:
  /// - value: 要验证的值
  /// - defaultValue: 转换失败时的默认值
  ///
  /// 返回: 验证后的 double，保证在 [0.5, 60.0] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.validateAutoplayInterval(3.0)   // 3.0
  /// TypeConverter.validateAutoplayInterval(0.3)   // 0.5 (最小值)
  /// TypeConverter.validateAutoplayInterval(120.0) // 60.0 (最大值)
  /// TypeConverter.validateAutoplayInterval(null)  // 4.0 (默认值)
  /// ```
  static double validateAutoplayInterval(
    dynamic value, {
    double defaultValue = 4.0,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.5, // 最小 0.5 秒
      max: 60.0, // 最大 60 秒
    );
  }

  /// 验证并限制 enlargeFactor 在有效范围内
  ///
  /// enlargeFactor 表示中心页面的放大因子
  ///
  /// 参数:
  /// - value: 要验证的值
  /// - defaultValue: 转换失败时的默认值
  ///
  /// 返回: 验证后的 double，保证在 [0.0, 1.0] 范围内
  ///
  /// 示例:
  /// ```dart
  /// TypeConverter.validateEnlargeFactor(0.3)   // 0.3
  /// TypeConverter.validateEnlargeFactor(-0.1)  // 0.0 (最小值)
  /// TypeConverter.validateEnlargeFactor(1.5)   // 1.0 (最大值)
  /// TypeConverter.validateEnlargeFactor(null)  // 0.3 (默认值)
  /// ```
  static double validateEnlargeFactor(dynamic value, {double defaultValue = 0.3}) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.0,
      max: 1.0,
    );
  }
}
