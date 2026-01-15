import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:webf/css.dart';
import 'package:webf/webf.dart';

import 'carousel_slider_bindings_generated.dart';
import 'config/carousel_config.dart';
import 'event/event_manager.dart';
import 'carousel_slider_item.dart';
import 'utils/type_converter.dart';

/// WebF Custom Element wrapper for carousel_slider_plus.
/// Provides a high-performance carousel component accessible from JavaScript.
class WebFCarouselSlider extends CarouselSliderBindings {
  WebFCarouselSlider(super.context);

  double? _height;
  double _aspectRatio = 16 / 9;
  double _viewportFraction = 0.8;
  int _initialPage = 0;
  bool _enableInfiniteScroll = true;
  bool _animateToClosest = true;
  bool _reverse = false;
  bool _autoPlay = false;
  int _autoPlayIntervalMs = 4000;
  int _autoPlayAnimationDurationMs = 800;
  Curve _autoPlayCurve = Curves.fastOutSlowIn;
  bool _enlargeCenterPage = false;
  ScrollPhysics? _scrollPhysics;
  bool _pageSnapping = true;
  Axis _scrollDirection = Axis.horizontal;
  bool _pauseAutoPlayOnTouch = true;
  bool _pauseAutoPlayOnManualNavigate = true;
  bool _pauseAutoPlayInFiniteScroll = false;
  PageStorageKey<String>? _pageViewKey;
  CenterPageEnlargeStrategy _enlargeStrategy = CenterPageEnlargeStrategy.scale;
  double _enlargeFactor = 0.3;
  bool _disableCenter = false;
  bool _padEnds = true;
  Clip _clipBehavior = Clip.hardEdge;
  int _realPage = 0;
  bool _disableGesture = false;

  CarouselEventManager? get _eventManager =>
      (state as WebFCarouselSliderState?)?._eventManager;

  void _requestUpdate() {
    state?.requestUpdateState(() {});
  }

  void _setAutoplay(bool value) {
    if (_autoplay == value) {
      if (_autoplay) {
        (state as WebFCarouselSliderState?)?.startAutoplay();
      } else {
        (state as WebFCarouselSliderState?)?.stopAutoplay();
      }
      return;
    }
    _autoplay = value;
    _requestUpdate();
    if (_autoplay) {
      _eventManager?.dispatchPlay();
      (state as WebFCarouselSliderState?)?.startAutoplay();
    } else {
      _eventManager?.dispatchPause();
      (state as WebFCarouselSliderState?)?.stopAutoplay();
    }
  }

  @override
  bool get autoplay => _autoplay;

  @override
  set autoplay(dynamic value) {
    final boolValue = TypeConverter.toBool(value);
    _setAutoplay(boolValue);
  }

  @override
  double? get autoplayDelay => _autoplayDelayMs.toDouble();

  @override
  set autoplayDelay(dynamic value) {
    final next = TypeConverter.clampAutoplayDelayMs(value,
        defaultValue: _autoplayDelayMs);
    if (_autoplayDelayMs != next) {
      _autoplayDelayMs = next;
      _requestUpdate();
    }
  }

  @override
  double? get speed => _speedMs.toDouble();

  @override
  set speed(dynamic value) {
    final next = TypeConverter.clampSpeedMs(value, defaultValue: _speedMs);
    if (_speedMs != next) {
      _speedMs = next;
      _requestUpdate();
    }
  }

  @override
  String? get easing => _easingName;

  @override
  set easing(dynamic value) {
    final curve = TypeConverter.parseEasing(value, fallback: _easingCurve);
    final name =
        TypeConverter.normalizeEasingName(value, fallback: _easingName);
    if (_easingCurve != curve || _easingName != name) {
      _easingCurve = curve;
      _easingName = name;
      _requestUpdate();
    }
  }

  @override
  bool get loop => _loop;

  @override
  set loop(dynamic value) {
    final boolValue = TypeConverter.toBool(value);
    if (_loop != boolValue) {
      _loop = boolValue;
      _requestUpdate();
    }
  }

  @override
  String? get direction =>
      _direction == Axis.horizontal ? 'horizontal' : 'vertical';

  @override
  set direction(dynamic value) {
    final next = TypeConverter.parseDirection(value);
    if (_direction != next) {
      _direction = next;
      _requestUpdate();
    }
  }

  @override
  double? get slidesPerView => _slidesPerView;

  @override
  set slidesPerView(dynamic value) {
    final next =
        TypeConverter.clampSlidesPerView(value, defaultValue: _slidesPerView);
    if (_slidesPerView != next) {
      _slidesPerView = next;
      _requestUpdate();
    }
  }

  @override
  bool get centeredSlides => _centeredSlides;

  @override
  set centeredSlides(dynamic value) {
    final boolValue = TypeConverter.toBool(value);
    if (_centeredSlides != boolValue) {
      _centeredSlides = boolValue;
      _requestUpdate();
    }
  }

  @override
  double? get initialSlide => _initialSlide.toDouble();

  @override
  set initialSlide(dynamic value) {
    final next = TypeConverter.toInt(value, min: 0);
    if (_initialSlide != next) {
      _initialSlide = next;
      _requestUpdate();
    }
  }

  @override
  double? get activeIndex => _activeIndex.toDouble();

  @override
  set activeIndex(dynamic value) {
    // 只读属性，忽略外部设置
  }

  @override
  bool get allowTouchMove => _allowTouchMove;

  @override
  set allowTouchMove(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_allowTouchMove != boolValue) {
      _allowTouchMove = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get autoplayDisableOnInteraction => _autoplayDisableOnInteraction;

  @override
  set autoplayDisableOnInteraction(dynamic value) {
    final boolValue = TypeConverter.toBool(value);
    if (_autoplayDisableOnInteraction != boolValue) {
      _autoplayDisableOnInteraction = boolValue;
      _requestUpdate();
    }
  }

  void _slideNextSync(List<dynamic> args) {
    final durationMs = TypeConverter.clampSpeedMs(
      args.isNotEmpty ? args[0] : null,
      defaultValue: _speedMs,
    );
    (state as WebFCarouselSliderState?)
        ?.nextPage(durationMs: durationMs, curve: _easingCurve);
  }

  void _slidePrevSync(List<dynamic> args) {
    final durationMs = TypeConverter.clampSpeedMs(
      args.isNotEmpty ? args[0] : null,
      defaultValue: _speedMs,
    );
    (state as WebFCarouselSliderState?)
        ?.previousPage(durationMs: durationMs, curve: _easingCurve);
  }

  void _slideToSync(List<dynamic> args) {
    final index = TypeConverter.toInt(
      args.isNotEmpty ? args[0] : null,
      defaultValue: _activeIndex,
      min: 0,
    );
    final durationMs = TypeConverter.clampSpeedMs(
      args.length > 1 ? args[1] : null,
      defaultValue: _speedMs,
    );
    if (durationMs <= 0) {
      (state as WebFCarouselSliderState?)?.jumpToPage(index);
      return;
    }
    (state as WebFCarouselSliderState?)?.animateToPage(
      page: index,
      durationMs: durationMs,
      curve: _easingCurve,
    );
  }

  void _autoplayStartSync(List<dynamic> args) {
    _setAutoplay(true);
  }

  void _autoplayStopSync(List<dynamic> args) {
    _setAutoplay(false);
  }

  static final StaticDefinedSyncBindingObjectMethodMap carouselMethods = {
    'slideNext': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._slideNextSync(args);
        return null;
      },
    ),
    'slidePrev': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._slidePrevSync(args);
        return null;
      },
    ),
    'slideTo': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._slideToSync(args);
        return null;
      },
    ),
    'autoplayStart': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._autoplayStartSync(args);
        return null;
      },
    ),
    'autoplayStop': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._autoplayStopSync(args);
        return null;
      },
    ),
  };

  @override
  List<StaticDefinedSyncBindingObjectMethodMap> get methods => [
        ...super.methods,
        carouselMethods,
      ];

  @override
  WebFWidgetElementState createState() {
    return WebFCarouselSliderState(this);
  }
}

class WebFCarouselSliderState extends WebFWidgetElementState {
  late final CarouselSliderController _controller;
  late final CarouselEventManager _eventManager;
  bool _isDragging = false;

  WebFCarouselSliderState(super.widgetElement);

  @override
  WebFCarouselSlider get widgetElement =>
      super.widgetElement as WebFCarouselSlider;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
    _eventManager = CarouselEventManager(widgetElement);
  }

  void nextPage({required int durationMs, required Curve curve}) {
    _controller.nextPage(
      duration: Duration(milliseconds: durationMs),
      curve: curve,
    );
  }

  void previousPage({required int durationMs, required Curve curve}) {
    _controller.previousPage(
      duration: Duration(milliseconds: durationMs),
      curve: curve,
    );
  }

  void jumpToPage(int page) {
    _controller.jumpToPage(page);
  }

  void animateToPage({
    required int page,
    required int durationMs,
    required Curve curve,
  }) {
    _controller.animateToPage(
      page,
      duration: Duration(milliseconds: durationMs),
      curve: curve,
    );
  }

  void startAutoplay() {
    _controller.startAutoPlay();
  }

  void stopAutoplay() {
    _controller.stopAutoPlay();
  }

  CarouselOptions _buildOptions(double? height) {
    final viewportFraction = TypeConverter.slidesPerViewToViewportFraction(
      widgetElement._slidesPerView,
    );
    final config = CarouselConfig(
      height: height,
      aspectRatio: widgetElement._aspectRatio,
      viewportFraction: viewportFraction,
      initialIndex: widgetElement._initialSlide,
      loop: widgetElement._loop,
      autoplay: widgetElement._autoplay,
      autoplayDelayMs: widgetElement._autoplayDelayMs.toDouble(),
      speedMs: widgetElement._speedMs.toDouble(),
      easing: widgetElement._easingCurve,
      direction: widgetElement._direction,
      centeredSlides: widgetElement._centeredSlides,
      allowTouchMove: widgetElement._allowTouchMove,
      autoplayDisableOnInteraction: widgetElement._autoplayDisableOnInteraction,
      onPageChanged: _onPageChanged,
    );

    return config.build();
  }

  String _mapChangeReason(CarouselPageChangedReason reason) {
    switch (reason) {
      case CarouselPageChangedReason.timed:
        return 'autoplay';
      case CarouselPageChangedReason.manual:
        return 'drag';
      case CarouselPageChangedReason.controller:
        return 'api';
    }
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    final previousIndex = widgetElement._activeIndex;
    widgetElement._activeIndex = index;

    _eventManager.dispatchChange(
      index: index,
      previousIndex: previousIndex,
      reason: _mapChangeReason(reason),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CSSRenderStyle renderStyle = widgetElement.renderStyle;
    double? width = renderStyle.width.computedValue;
    double? height = renderStyle.height.computedValue;
    if (width == 0) width = null;
    if (height == 0) height = null;

    final options = _buildOptions(height);
    final items = _buildItems();

    final carousel = CarouselSlider(
      options: options,
      items: items,
      controller: _controller,
    );

    final allowTouchMove = widgetElement._allowTouchMove;
    final gestureCarousel = GestureDetector(
      onPanStart: allowTouchMove
          ? (_) {
              if (widgetElement._autoplayDisableOnInteraction &&
                  widgetElement._autoplay) {
                widgetElement._setAutoplay(false);
              }
              _isDragging = true;
              _eventManager.dispatchChangeStart(widgetElement._activeIndex);
            }
          : null,
      onPanEnd: allowTouchMove
          ? (_) {
              if (!_isDragging) return;
              _isDragging = false;
              _eventManager.dispatchChangeEnd(widgetElement._activeIndex);
            }
          : null,
      onPanCancel: allowTouchMove
          ? () {
              if (!_isDragging) return;
              _isDragging = false;
              _eventManager.dispatchChangeEnd(widgetElement._activeIndex);
            }
          : null,
      child: carousel,
    );

    Widget content = gestureCarousel;
    if (width != null || height != null) {
      content = SizedBox(
        width: width,
        height: height,
        child: content,
      );
    }

    return ClipRect(child: content);
  }

  List<Widget> _buildItems() {
    final List<Widget> children = [];
    for (var child in widgetElement.childNodes) {
      if (child is WebFCarouselSliderItem) {
        children.add(child.toWidget());
      }
    }

    if (children.isNotEmpty) {
      return children;
    }

    final placeholder = Container(
      color: Colors.grey[300],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              'Add <webf-carousel-slider-item>',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    return [placeholder, placeholder, placeholder];
  }
}
