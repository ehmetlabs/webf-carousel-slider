import 'package:flutter/material.dart';
import 'package:webf/dom.dart' as dom;

/// 滚动事件监听器
///
/// 使用 NotificationListener 监听滚动并派发 scrolled 事件
/// 支持节流机制以避免事件派发过于频繁
class CarouselScrollListener extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// WebF 元素，用于派发事件
  final dom.Element element;

  /// 节流时间间隔
  ///
  /// 默认 100 毫秒，可根据需要调整
  final Duration throttleDuration;

  const CarouselScrollListener({
    super.key,
    required this.child,
    required this.element,
    this.throttleDuration = const Duration(milliseconds: 100),
  });

  @override
  Widget build(BuildContext context) {
    return _ThrottledScrollNotificationListener(
      element: element,
      throttleDuration: throttleDuration,
      child: child,
    );
  }
}

/// 节流的滚动通知监听器
///
/// 使用 StatefulWidget 维护节流状态
/// 只处理深度为 0 的滚动通知（来自直接的 PageView）
class _ThrottledScrollNotificationListener extends StatefulWidget {
  final Widget child;
  final dom.Element element;
  final Duration throttleDuration;

  const _ThrottledScrollNotificationListener({
    required this.child,
    required this.element,
    required this.throttleDuration,
  });

  @override
  State<_ThrottledScrollNotificationListener> createState() =>
      _ThrottledScrollNotificationListenerState();
}

class _ThrottledScrollNotificationListenerState
    extends State<_ThrottledScrollNotificationListener> {
  /// 上次派发事件的时间
  DateTime? _lastDispatchTime;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // 只处理深度为 0 的滚动通知（来自直接的 PageView）
        // 避免处理嵌套可滚动组件的滚动事件
        if (notification.depth == 0) {
          _dispatchThrottled(notification.metrics.pixels);
        }
        return false; // 不阻止通知继续传递
      },
      child: widget.child,
    );
  }

  /// 节流派发滚动事件
  ///
  /// 只有在距上次派发时间超过 [throttleDuration] 时才真正派发
  /// 避免过于频繁的滚动事件影响性能
  void _dispatchThrottled(double? pixels) {
    final now = DateTime.now();

    // 检查是否需要节流
    if (_lastDispatchTime != null &&
        now.difference(_lastDispatchTime!) < widget.throttleDuration) {
      return;
    }

    _lastDispatchTime = now;

    // 派发 scrolled 事件
    widget.element.dispatchEvent(dom.CustomEvent(
      'scrolled',
      detail: pixels,
    ));
  }
}
