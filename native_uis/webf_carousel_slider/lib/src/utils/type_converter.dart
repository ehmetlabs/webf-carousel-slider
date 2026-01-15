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
  static bool toBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) return value == 'true' || value == '';
    if (value is int || value is double) return value != 0;
    return defaultValue;
  }

  /// 安全地将 dynamic 转换为 double
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

    result ??= defaultValue;

    if (min != null && result < min) result = min;
    if (max != null && result > max) result = max;

    return result;
  }

  /// 安全地将 dynamic 转换为 int
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

  /// 解析方向字符串为 Axis
  static Axis parseDirection(dynamic value) {
    if (value == null) return Axis.horizontal;
    if (value is Axis) return value;

    final strValue = value.toString().toLowerCase();
    return strValue.contains('vertical') ? Axis.vertical : Axis.horizontal;
  }

  /// 解析 clipBehavior 字符串为 Clip
  static Clip parseClipBehavior(
    dynamic value, {
    Clip fallback = Clip.hardEdge,
  }) {
    if (value == null) return fallback;
    if (value is Clip) return value;

    final strValue = value.toString().trim().toLowerCase();
    if (strValue.isEmpty) return fallback;

    switch (strValue) {
      case 'none':
        return Clip.none;
      case 'anti-alias':
      case 'antialias':
        return Clip.antiAlias;
      case 'anti-alias-with-save-layer':
      case 'antialiaswithsavelayer':
        return Clip.antiAliasWithSaveLayer;
      case 'hard-edge':
      case 'hardedge':
      default:
        return Clip.hardEdge;
    }
  }

  /// 标准化 clipBehavior 名称
  static String normalizeClipBehaviorName(
    dynamic value, {
    String fallback = 'hardEdge',
  }) {
    if (value == null) return fallback;
    if (value is Clip) return fallback;

    final strValue = value.toString().trim().toLowerCase();
    if (strValue.isEmpty) return fallback;

    switch (strValue) {
      case 'none':
        return 'none';
      case 'anti-alias':
      case 'antialias':
        return 'antiAlias';
      case 'anti-alias-with-save-layer':
      case 'antialiaswithsavelayer':
        return 'antiAliasWithSaveLayer';
      case 'hard-edge':
      case 'hardedge':
      default:
        return 'hardEdge';
    }
  }

  static List<double>? _parseCubicBezier(String value) {
    final match = RegExp(r'cubic-bezier\s*\(([^)]+)\)').firstMatch(value);
    if (match == null) return null;
    final parts = match.group(1)!.split(RegExp(r'\s*,\s*'));
    if (parts.length != 4) return null;

    final values = <double>[];
    for (final part in parts) {
      final parsed = double.tryParse(part.trim());
      if (parsed == null) return null;
      values.add(parsed);
    }

    final x1 = values[0].clamp(0.0, 1.0).toDouble();
    final y1 = values[1];
    final x2 = values[2].clamp(0.0, 1.0).toDouble();
    final y2 = values[3];
    return [x1, y1, x2, y2];
  }

  /// 解析 easing 字符串为 Flutter Curve
  static Curve parseEasing(
    dynamic value, {
    Curve fallback = Curves.ease,
  }) {
    if (value == null) return fallback;
    if (value is Curve) return value;

    final strValue = value.toString().trim().toLowerCase();
    if (strValue.isEmpty) return fallback;

    final cubicValues = _parseCubicBezier(strValue);
    if (cubicValues != null) {
      return Cubic(
        cubicValues[0],
        cubicValues[1],
        cubicValues[2],
        cubicValues[3],
      );
    }

    const curveMap = <String, Curve>{
      'curves.ease': Curves.ease,
      'ease': Curves.ease,
      'ease-in': Curves.easeIn,
      'easein': Curves.easeIn,
      'curves.easein': Curves.easeIn,
      'ease-out': Curves.easeOut,
      'easeout': Curves.easeOut,
      'curves.easeout': Curves.easeOut,
      'ease-in-out': Curves.easeInOut,
      'easeinout': Curves.easeInOut,
      'curves.easeinout': Curves.easeInOut,
      'linear': Curves.linear,
      'curves.linear': Curves.linear,
      'fast-out-slow-in': Curves.fastOutSlowIn,
      'fastoutslowin': Curves.fastOutSlowIn,
      'curves.fastoutslowin': Curves.fastOutSlowIn,
    };

    return curveMap[strValue] ?? fallback;
  }

  /// 标准化 easing 名称
  static String normalizeEasingName(
    dynamic value, {
    String fallback = 'ease',
  }) {
    if (value == null) return fallback;
    if (value is Curve) return fallback;

    final strValue = value.toString().trim();
    if (strValue.isEmpty) return fallback;

    final lower = strValue.toLowerCase();
    final cubicValues = _parseCubicBezier(lower);
    if (cubicValues != null) {
      return 'cubic-bezier('
          '${cubicValues[0]}, ${cubicValues[1]}, ${cubicValues[2]}, ${cubicValues[3]})';
    }

    const aliasMap = <String, String>{
      'curves.ease': 'ease',
      'ease': 'ease',
      'ease-in': 'ease-in',
      'easein': 'ease-in',
      'curves.easein': 'ease-in',
      'ease-out': 'ease-out',
      'easeout': 'ease-out',
      'curves.easeout': 'ease-out',
      'ease-in-out': 'ease-in-out',
      'easeinout': 'ease-in-out',
      'curves.easeinout': 'ease-in-out',
      'linear': 'linear',
      'curves.linear': 'linear',
      'fast-out-slow-in': 'fast-out-slow-in',
      'fastoutslowin': 'fast-out-slow-in',
      'curves.fastoutslowin': 'fast-out-slow-in',
    };

    return aliasMap[lower] ?? fallback;
  }

  /// 验证并限制 viewportFraction 在有效范围内
  static double clampViewportFraction(
    dynamic value, {
    double defaultValue = 1.0,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.01,
      max: 1.0,
    );
  }

  /// 验证并限制 slidesPerView 在合理范围内
  static double clampSlidesPerView(
    dynamic value, {
    double defaultValue = 1.0,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 1.0,
      max: 10.0,
    );
  }

  /// 将 slidesPerView 转为 viewportFraction
  static double slidesPerViewToViewportFraction(
    dynamic value, {
    double defaultSlidesPerView = 1.0,
  }) {
    final slidesPerView =
        clampSlidesPerView(value, defaultValue: defaultSlidesPerView);
    return clampViewportFraction(1 / slidesPerView);
  }

  /// 验证并限制 autoPlayInterval（毫秒）在合理范围内
  static int clampAutoPlayIntervalMs(
    dynamic value, {
    int defaultValue = 4000,
  }) {
    return toInt(
      value,
      defaultValue: defaultValue,
      min: 500,
      max: 60000,
    );
  }

  /// 验证并限制 autoPlayAnimationDuration（毫秒）在合理范围内
  static int clampAutoPlayAnimationDurationMs(
    dynamic value, {
    int defaultValue = 800,
  }) {
    return toInt(
      value,
      defaultValue: defaultValue,
      min: 0,
      max: 5000,
    );
  }

  /// 验证并限制 enlargeFactor 在合理范围内
  static double clampEnlargeFactor(
    dynamic value, {
    double defaultValue = 0.3,
  }) {
    return toDouble(
      value,
      defaultValue: defaultValue,
      min: 0.0,
      max: 1.0,
    );
  }
}
