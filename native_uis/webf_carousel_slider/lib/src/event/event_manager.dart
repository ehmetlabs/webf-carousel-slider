import 'package:webf/webf.dart';

/// 事件管理器
///
/// 职责:
/// - 统一管理轮播事件派发
/// - 封装 CustomEvent 创建逻辑
class CarouselEventManager {
  final WidgetElement element;

  CarouselEventManager(this.element);

  void dispatchChange({
    required int index,
    required int previousIndex,
    required String reason,
  }) {
    element.dispatchEvent(CustomEvent(
      'change',
      detail: {
        'index': index,
        'previousIndex': previousIndex,
        'reason': reason,
      },
    ));
  }

  void dispatchChangeStart(int index) {
    element.dispatchEvent(CustomEvent(
      'changestart',
      detail: {
        'index': index,
      },
    ));
  }

  void dispatchChangeEnd(int index) {
    element.dispatchEvent(CustomEvent(
      'changeend',
      detail: {
        'index': index,
      },
    ));
  }

  void dispatchPlay() {
    element.dispatchEvent(Event('play'));
  }

  void dispatchPause() {
    element.dispatchEvent(Event('pause'));
  }
}
