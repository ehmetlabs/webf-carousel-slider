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

  /// 验证并限制 autoplayDelay（毫秒）在合理范围内
  static int clampAutoplayDelayMs(
    dynamic value, {
    int defaultValue = 3000,
  }) {
    return toInt(
      value,
      defaultValue: defaultValue,
      min: 500,
      max: 60000,
    );
  }

  /// 验证并限制 speed（毫秒）在合理范围内
  static int clampSpeedMs(
    dynamic value, {
    int defaultValue = 300,
  }) {
    return toInt(
      value,
      defaultValue: defaultValue,
      min: 0,
      max: 5000,
    );
  }
}
