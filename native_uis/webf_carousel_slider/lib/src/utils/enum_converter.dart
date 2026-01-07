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
  /// - 完整枚举名（如 'CenterPageEnlargeStrategy.scale'）
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

    // 使用 Map 替代 if-else 链，提升性能和可维护性
    const strategyMap = <String, CenterPageEnlargeStrategy>{
      'centerpageenlargestrategy.scale': CenterPageEnlargeStrategy.scale,
      'scale': CenterPageEnlargeStrategy.scale,
      'centerpageenlargestrategy.height': CenterPageEnlargeStrategy.height,
      'height': CenterPageEnlargeStrategy.height,
      'centerpageenlargestrategy.zoom': CenterPageEnlargeStrategy.zoom,
      'zoom': CenterPageEnlargeStrategy.zoom,
    };

    return strategyMap[strValue] ?? CenterPageEnlargeStrategy.scale;
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

  /// 解析 Clip 枚举
  ///
  /// 支持格式:
  /// - 枚举名（如 'none', 'hardEdge', 'antiAlias'）
  /// - 完整枚举名（如 'Clip.none'）
  /// - 不区分大小写
  ///
  /// 返回: 对应的 Clip，未找到返回 Clip.hardEdge
  ///
  /// 示例:
  /// ```dart
  /// EnumConverter.parseClip('none')                    // Clip.none
  /// EnumConverter.parseClip('hardEdge')                // Clip.hardEdge
  /// EnumConverter.parseClip('antiAlias')                // Clip.antiAlias
  /// EnumConverter.parseClip('Clip.hardEdge')           // Clip.hardEdge
  /// EnumConverter.parseClip('invalid')                 // Clip.hardEdge (默认)
  /// EnumConverter.parseClip(null)                      // Clip.hardEdge (默认)
  /// ```
  static Clip parseClip(dynamic value) {
    if (value == null) return Clip.hardEdge;
    if (value is Clip) return value;

    final strValue = value.toString().toLowerCase();

    // 使用 Map 替代 if-else 链，提升性能和可维护性
    const clipMap = <String, Clip>{
      'clip.none': Clip.none,
      'none': Clip.none,
      'clip.hardedge': Clip.hardEdge,
      'hardedge': Clip.hardEdge,
      'clip.antialias': Clip.antiAlias,
      'antialias': Clip.antiAlias,
      'clip.antialiaswithsaveboundary': Clip.antiAliasWithSaveLayer,
      'antialiaswithsaveboundary': Clip.antiAliasWithSaveLayer,
    };

    return clipMap[strValue] ?? Clip.hardEdge;
  }
}
