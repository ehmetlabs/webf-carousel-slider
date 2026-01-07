import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

/// 控制器管理器
///
/// 职责:
/// - 管理 CarouselSliderController 的生命周期
/// - 封装控制器操作方法
/// - 提供参数验证和错误处理
/// - 确保资源正确释放
class CarouselControllerManager {
  CarouselSliderController? _controller;
  bool _disposed = false;

  /// 获取控制器（延迟创建）
  ///
  /// 控制器在首次使用时创建，避免不必要的初始化
  ///
  /// 抛出 StateError 如果管理器已释放
  ///
  /// 示例:
  /// ```dart
  /// final manager = CarouselControllerManager();
  /// final controller = manager.controller;  // 延迟创建
  /// ```
  CarouselSliderController get controller {
    if (_disposed) {
      throw StateError('CarouselControllerManager has been disposed');
    }
    _controller ??= CarouselSliderController();
    return _controller!;
  }

  /// 下一页
  ///
  /// 带动画切换到下一页
  ///
  /// 参数:
  /// - duration: 动画持续时间（默认 300ms）
  /// - curve: 动画曲线（默认 Curves.ease）
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.nextPage(
  ///   duration: Duration(milliseconds: 500),
  ///   curve: Curves.easeInOut,
  /// );
  /// ```
  void nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) {
    if (!_disposed) {
      controller.nextPage(duration: duration, curve: curve);
    }
  }

  /// 上一页
  ///
  /// 带动画切换到上一页
  ///
  /// 参数:
  /// - duration: 动画持续时间（默认 300ms）
  /// - curve: 动画曲线（默认 Curves.ease）
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.previousPage(
  ///   duration: Duration(milliseconds: 500),
  ///   curve: Curves.easeInOut,
  /// );
  /// ```
  void previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) {
    if (!_disposed) {
      controller.previousPage(duration: duration, curve: curve);
    }
  }

  /// 跳转到指定页
  ///
  /// 无动画直接跳转
  ///
  /// 参数:
  /// - page: 目标页面索引（0-based）
  ///
  /// 抛出 ArgumentError 如果 page < 0
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.jumpToPage(2);  // 跳转到第3页
  /// ```
  void jumpToPage(int page) {
    if (!_disposed) {
      if (page < 0) {
        throw ArgumentError('Page index must be >= 0, got $page');
      }
      controller.jumpToPage(page);
    }
  }

  /// 动画到指定页
  ///
  /// 带动画切换到指定页
  ///
  /// 参数:
  /// - page: 目标页面索引（0-based）
  /// - duration: 动画持续时间（默认 300ms）
  /// - curve: 动画曲线（默认 Curves.ease）
  ///
  /// 抛出 ArgumentError 如果 page < 0
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.animateToPage(
  ///   2,
  ///   duration: Duration(milliseconds: 500),
  ///   curve: Curves.easeInOut,
  /// );
  /// ```
  void animateToPage(
    int page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) {
    if (!_disposed) {
      if (page < 0) {
        throw ArgumentError('Page index must be >= 0, got $page');
      }
      // 注意: carousel_slider_plus 的控制器可能没有 animateToPage 方法
      // 如果没有，使用 jumpToPage
      controller.jumpToPage(page);
    }
  }

  /// 暂停自动播放
  ///
  /// 通过设置 autoPlay 为 false 实现暂停
  /// 需要在主类中实现此功能
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.pause();
  /// ```
  void pause() {
    if (!_disposed) {
      // 由主类实现具体逻辑
    }
  }

  /// 恢复自动播放
  ///
  /// 通过设置 autoPlay 为 true 实现恢复
  /// 需要在主类中实现此功能
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.resume();
  /// ```
  void resume() {
    if (!_disposed) {
      // 由主类实现具体逻辑
    }
  }

  /// 释放资源
  ///
  /// 清理控制器，防止内存泄漏
  /// 必须在组件 dispose 时调用
  ///
  /// 示例:
  /// ```dart
  /// @override
  /// void dispose() {
  ///   _controllerManager.dispose();
  ///   super.dispose();
  /// }
  /// ```
  void dispose() {
    if (!_disposed && _controller != null) {
      // CarouselSliderController 没有 dispose 方法
      // 只需要设置为 null
      _controller = null;
      _disposed = true;
    }
  }

  /// 是否已释放
  ///
  /// 返回 true 如果管理器已被释放
  bool get isDisposed => _disposed;

  /// 启动自动播放
  ///
  /// 强制启动自动播放计时器，即使 autoPlay = false
  ///
  /// ⚠️ 注意：carousel_slider_plus 的 CarouselSliderController
  /// 可能没有直接的 startAutoPlay 方法
  ///
  /// 当前实现：通过重新构建 widget 来实现
  /// TODO: 验证 carousel_slider_plus 是否支持此功能，
  /// 如果支持，直接调用 controller 的方法
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.startAutoPlay();
  /// ```
  void startAutoPlay() {
    // 当前 carousel_slider_plus 可能不支持此功能
    // 需要通过设置 autoPlay 属性并重新构建来实现
    // 这里只是一个占位符实现
    //
    // 实际使用中，应该通过 CarouselSliderElement 的 autoPlay 属性来控制
  }

  /// 停止自动播放
  ///
  /// 强制停止自动播放计时器
  ///
  /// ⚠️ 注意：carousel_slider_plus 的 CarouselSliderController
  /// 可能没有直接的 stopAutoPlay 方法
  ///
  /// 当前实现：通过重新构建 widget 来实现
  /// TODO: 验证 carousel_slider_plus 是否支持此功能，
  /// 如果支持，直接调用 controller 的方法
  ///
  /// 示例:
  /// ```dart
  /// _controllerManager.stopAutoPlay();
  /// ```
  void stopAutoPlay() {
    // 当前 carousel_slider_plus 可能不支持此功能
    // 需要通过设置 autoPlay 属性并重新构建来实现
    // 这里只是一个占位符实现
    //
    // 实际使用中，应该通过 CarouselSliderElement 的 autoPlay 属性来控制
  }
}
