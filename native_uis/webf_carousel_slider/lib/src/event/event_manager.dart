import 'package:webf/webf.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

/// 事件管理器
///
/// 职责:
/// - 统一管理所有轮播事件派发
/// - 封装 CustomEvent 创建逻辑
/// - 提供类型安全的事件接口
/// - 确保事件命名规范一致
class CarouselEventManager {
  /// 关联的元素
  final WidgetElement element;

  /// 创建事件管理器
  ///
  /// [element] - 派发事件的 WidgetElement
  CarouselEventManager(this.element);

  /// 派发页面变化事件
  ///
  /// 当轮播切换到新页面时触发
  ///
  /// 参数:
  /// - index: 新的页面索引（0-based）
  /// - reason: 触发原因（timed/manual/controller）
  ///
  /// 示例:
  /// ```dart
  /// _eventManager.dispatchPageChanged(2, CarouselPageChangedReason.timed);
  /// ```
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('change', (event) => {
  ///   console.log('页面:', event.detail.index);
  ///   console.log('原因:', event.detail.reason);
  /// });
  /// ```
  void dispatchPageChanged(int index, CarouselPageChangedReason reason) {
    element.dispatchEvent(CustomEvent(
      'change',
      detail: {
        'index': index,
        'reason': reason.toString().split('.').last,
      },
    ));
  }

  /// 派发滑动开始事件
  ///
  /// 用户开始滑动手势时触发
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('slidestart', () => {
  ///   console.log('开始滑动');
  /// });
  /// ```
  void dispatchSlideStart() {
    element.dispatchEvent(Event('slidestart'));
  }

  /// 派发滑动结束事件
  ///
  /// 用户结束滑动手势时触发
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('slideend', () => {
  ///   console.log('结束滑动');
  /// });
  /// ```
  void dispatchSlideEnd() {
    element.dispatchEvent(Event('slideend'));
  }

  /// 派发页面动画开始事件
  ///
  /// 页面切换动画开始时触发
  ///
  /// 参数:
  /// - fromIndex: 起始页面索引
  /// - toIndex: 目标页面索引
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('pageanimationstart', (event) => {
  ///   console.log('从', event.detail.from, '到', event.detail.to);
  /// });
  /// ```
  void dispatchAnimationStart(int fromIndex, int toIndex) {
    element.dispatchEvent(CustomEvent(
      'pageanimationstart',
      detail: {
        'from': fromIndex,
        'to': toIndex,
      },
    ));
  }

  /// 派发页面动画结束事件
  ///
  /// 页面切换动画完成时触发
  ///
  /// 参数:
  /// - index: 当前页面索引
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('pageanimationend', (event) => {
  ///   console.log('动画结束，当前页:', event.detail.index);
  /// });
  /// ```
  void dispatchAnimationEnd(int index) {
    element.dispatchEvent(CustomEvent(
      'pageanimationend',
      detail: {
        'index': index,
      },
    ));
  }

  /// 派发自动播放暂停事件
  ///
  /// 自动播放被暂停时触发
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('autoplaypause', () => {
  ///   console.log('自动播放已暂停');
  /// });
  /// ```
  void dispatchAutoplayPause() {
    element.dispatchEvent(Event('autoplaypause'));
  }

  /// 派发自动播放恢复事件
  ///
  /// 自动播放恢复时触发
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('autoplayresume', () => {
  ///   console.log('自动播放已恢复');
  /// });
  /// ```
  void dispatchAutoplayResume() {
    element.dispatchEvent(Event('autoplayresume'));
  }

  /// 派发错误事件
  ///
  /// 发生错误时触发
  ///
  /// 参数:
  /// - message: 错误信息
  /// - stack: 错误堆栈（可选）
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('error', (event) => {
  ///   console.error('错误:', event.detail.message);
  /// });
  /// ```
  void dispatchError(String message, {String? stack}) {
    final detail = <String, dynamic>{
      'message': message,
    };

    if (stack != null) {
      detail['stack'] = stack;
    }

    element.dispatchEvent(CustomEvent('error', detail: detail));
  }

  /// 派发自定义事件
  ///
  /// 用于派发扩展的自定义事件
  ///
  /// 参数:
  /// - eventName: 事件名称
  /// - detail: 事件数据（可选）
  ///
  /// 示例:
  /// ```dart
  /// _eventManager.dispatchCustomEvent('myevent', {'data': 123});
  /// ```
  void dispatchCustomEvent(String eventName, {Object? detail}) {
    if (detail != null) {
      element.dispatchEvent(CustomEvent(eventName, detail: detail));
    } else {
      element.dispatchEvent(Event(eventName));
    }
  }

  /// 派发滚动事件
  ///
  /// 当轮播滚动时触发
  ///
  /// 参数:
  /// - pixels: 当前滚动位置（像素），null 表示无法确定
  ///
  /// 示例:
  /// ```dart
  /// _eventManager.dispatchScrolled(123.45);
  /// ```
  void dispatchScrolled(double? pixels) {
    element.dispatchEvent(CustomEvent(
      'scrolled',
      detail: pixels,
    ));
  }

  /// 派发单项点击事件
  ///
  /// 点击轮播图片项时触发
  ///
  /// 参数:
  /// - id: 图片项 ID
  ///
  /// JavaScript 监听:
  /// ```javascript
  /// carousel.addEventListener('itemclick', (event) => {
  ///   console.log('点击项 ID:', event.detail.id);
  /// });
  /// ```
  void dispatchItemClick(Object id) {
    element.dispatchEvent(CustomEvent(
      'itemclick',
      detail: {
        'id': id,
      },
    ));
  }
}
