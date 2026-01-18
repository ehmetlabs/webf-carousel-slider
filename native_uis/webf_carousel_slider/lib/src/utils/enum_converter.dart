import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

/// 枚举转换工具类
///
/// 提供字符串到枚举的转换功能，支持多种输入格式
/// 用于处理从 JavaScript 传递的属性值
class EnumConverter {
  // 私有构造函数，防止实例化
  EnumConverter._();

  /// 解析 CenterPageEnlargeStrategy
  ///
  /// 支持格式:
  /// - 枚举名（如 'scale', 'height', 'zoom'）
  /// - 不区分大小写
  ///
  /// 返回: 对应的策略，未找到返回 CenterPageEnlargeStrategy.scale
  ///
  /// 示例:
  /// ```dart
  /// EnumConverter.parseEnlargeStrategy('scale')              // CenterPageEnlargeStrategy.scale
  /// EnumConverter.parseEnlargeStrategy('height')             // CenterPageEnlargeStrategy.height
  /// EnumConverter.parseEnlargeStrategy('CenterPageEnlargeStrategy.zoom')  // CenterPageEnlargeStrategy.zoom
  /// EnumConverter.parseEnlargeStrategy('invalid')           // CenterPageEnlargeStrategy.scale (默认)
  /// EnumConverter.parseEnlargeStrategy(null)                // CenterPageEnlargeStrategy.scale (默认)
  /// ```
  static CenterPageEnlargeStrategy parseEnlargeStrategy(dynamic value) {
    if (value == null) return CenterPageEnlargeStrategy.scale;
    if (value is CenterPageEnlargeStrategy) return value;

    final strValue = value.toString().toLowerCase();
    final normalized =
        strValue.contains('.') ? strValue.split('.').last : strValue;

    switch (normalized) {
      case 'height':
        return CenterPageEnlargeStrategy.height;
      case 'zoom':
        return CenterPageEnlargeStrategy.zoom;
      case 'scale':
      default:
        return CenterPageEnlargeStrategy.scale;
    }
  }

  /// 解析 ScrollPhysics 字符串
  ///
  /// 支持的值:
  /// - 'clamping' → ClampingScrollPhysics
  /// - 'bouncing' → BouncingScrollPhysics
  /// - 'fixed' → FixedExtentScrollPhysics
  /// - null 或其他 → null（使用默认）
  ///
  /// 返回: 对应的 ScrollPhysics，未找到返回 null
  ///
  /// 示例:
  /// ```dart
  /// EnumConverter.parseScrollPhysics('clamping')  // ClampingScrollPhysics
  /// EnumConverter.parseScrollPhysics('bouncing')  // BouncingScrollPhysics
  /// EnumConverter.parseScrollPhysics('invalid')   // null
  /// EnumConverter.parseScrollPhysics(null)        // null
  /// ```
  static ScrollPhysics? parseScrollPhysics(dynamic value) {
    if (value == null) return null;
    if (value is ScrollPhysics) return value;

    final strValue = value.toString().toLowerCase();

    switch (strValue) {
      case 'clamping':
        return const ClampingScrollPhysics();
      case 'bouncing':
        return const BouncingScrollPhysics();
      case 'fixed':
        return const FixedExtentScrollPhysics();
      default:
        return null;
    }
  }
}
