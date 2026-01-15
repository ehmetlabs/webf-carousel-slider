import 'dart:async';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:webf/webf.dart';

typedef CarouselCallbackGetter = dynamic Function();

/// 回调管理器
///
/// 负责调用 JS 侧回调以匹配 carousel_slider_plus 的语义。
class CarouselEventManager {
  CarouselEventManager({
    required CarouselCallbackGetter onPageChanged,
    required CarouselCallbackGetter onScrolled,
  })  : _onPageChanged = onPageChanged,
        _onScrolled = onScrolled;

  final CarouselCallbackGetter _onPageChanged;
  final CarouselCallbackGetter _onScrolled;

  void dispatchPageChanged(int index, CarouselPageChangedReason reason) {
    _invokeCallback(_onPageChanged(), [index, reason.name]);
  }

  void dispatchScrolled(double? value) {
    _invokeCallback(_onScrolled(), [value]);
  }

  void _invokeCallback(dynamic callback, List<dynamic> args) {
    if (callback == null) return;
    if (callback is JSFunction) {
      unawaited(callback.invoke(args));
      return;
    }
    if (callback is Function) {
      Function.apply(callback, args);
    }
  }
}
