import 'dart:async';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:webf/css.dart';
import 'package:webf/dom.dart' as dom;
import 'package:webf/webf.dart';

import 'carousel_slider_bindings_generated.dart';
import 'carousel_slider_item.dart';
import 'config/carousel_config.dart';
import 'event/event_manager.dart';
import 'utils/enum_converter.dart';
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
  String _autoPlayCurveName = 'fast-out-slow-in';
  bool _enlargeCenterPage = false;
  ScrollPhysics? _scrollPhysics;
  String? _scrollPhysicsName;
  bool _pageSnapping = true;
  Axis _scrollDirection = Axis.horizontal;
  bool _pauseAutoPlayOnTouch = true;
  bool _pauseAutoPlayOnManualNavigate = true;
  bool _pauseAutoPlayInFiniteScroll = false;
  String? _pageViewKeyValue;
  CenterPageEnlargeStrategy _enlargeStrategy = CenterPageEnlargeStrategy.scale;
  double _enlargeFactor = 0.3;
  bool _disableCenter = false;
  bool _padEnds = true;
  Clip _clipBehavior = Clip.hardEdge;
  String _clipBehaviorName = 'hardEdge';
  int _realPage = 0;
  bool _disableGesture = false;

  dynamic _onPageChanged;
  dynamic _onScrolled;

  void _requestUpdate() {
    state?.requestUpdateState(() {});
  }

  void _setRealPage(int value) {
    _realPage = value;
  }

  @override
  double? get height => _height;

  @override
  set height(value) {
    final next = value == null ? null : TypeConverter.toDouble(value);
    if (_height != next) {
      _height = next;
      _requestUpdate();
    }
  }

  @override
  double? get aspectRatio => _aspectRatio;

  @override
  set aspectRatio(value) {
    final next = TypeConverter.toDouble(
      value,
      defaultValue: 16 / 9,
      min: 0.01,
    );
    if (_aspectRatio != next) {
      _aspectRatio = next;
      _requestUpdate();
    }
  }

  @override
  double? get viewportFraction => _viewportFraction;

  @override
  set viewportFraction(value) {
    final next = TypeConverter.clampViewportFraction(
      value,
      defaultValue: _viewportFraction,
    );
    if (_viewportFraction != next) {
      _viewportFraction = next;
      _requestUpdate();
    }
  }

  @override
  double? get initialPage => _initialPage.toDouble();

  @override
  set initialPage(value) {
    final next = TypeConverter.toInt(
      value,
      defaultValue: _initialPage,
      min: 0,
    );
    if (_initialPage != next) {
      _initialPage = next;
      _requestUpdate();
    }
  }

  @override
  bool get enableInfiniteScroll => _enableInfiniteScroll;

  @override
  set enableInfiniteScroll(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_enableInfiniteScroll != boolValue) {
      _enableInfiniteScroll = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get animateToClosest => _animateToClosest;

  @override
  set animateToClosest(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_animateToClosest != boolValue) {
      _animateToClosest = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get reverse => _reverse;

  @override
  set reverse(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_reverse != boolValue) {
      _reverse = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get autoPlay => _autoPlay;

  @override
  set autoPlay(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_autoPlay != boolValue) {
      _autoPlay = boolValue;
      _requestUpdate();
    }
  }

  @override
  double? get autoPlayInterval => _autoPlayIntervalMs.toDouble();

  @override
  set autoPlayInterval(value) {
    final next = TypeConverter.clampAutoPlayIntervalMs(
      value,
      defaultValue: _autoPlayIntervalMs,
    );
    if (_autoPlayIntervalMs != next) {
      _autoPlayIntervalMs = next;
      _requestUpdate();
    }
  }

  @override
  double? get autoPlayAnimationDuration => _autoPlayAnimationDurationMs.toDouble();

  @override
  set autoPlayAnimationDuration(value) {
    final next = TypeConverter.clampAutoPlayAnimationDurationMs(
      value,
      defaultValue: _autoPlayAnimationDurationMs,
    );
    if (_autoPlayAnimationDurationMs != next) {
      _autoPlayAnimationDurationMs = next;
      _requestUpdate();
    }
  }

  @override
  String? get autoPlayCurve => _autoPlayCurveName;

  @override
  set autoPlayCurve(value) {
    final curve = TypeConverter.parseEasing(
      value,
      fallback: _autoPlayCurve,
    );
    final name = TypeConverter.normalizeEasingName(
      value,
      fallback: _autoPlayCurveName,
    );
    if (_autoPlayCurve != curve || _autoPlayCurveName != name) {
      _autoPlayCurve = curve;
      _autoPlayCurveName = name;
      _requestUpdate();
    }
  }

  @override
  bool get enlargeCenterPage => _enlargeCenterPage;

  @override
  set enlargeCenterPage(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_enlargeCenterPage != boolValue) {
      _enlargeCenterPage = boolValue;
      _requestUpdate();
    }
  }

  @override
  dynamic get onPageChanged => _onPageChanged;

  @override
  set onPageChanged(value) {
    if (!identical(_onPageChanged, value)) {
      _onPageChanged = value;
      _requestUpdate();
    }
  }

  @override
  dynamic get onScrolled => _onScrolled;

  @override
  set onScrolled(value) {
    if (!identical(_onScrolled, value)) {
      _onScrolled = value;
      _requestUpdate();
    }
  }

  @override
  String? get scrollPhysics => _scrollPhysicsName;

  @override
  set scrollPhysics(value) {
    final nextName = value == null ? null : value.toString();
    final nextPhysics = EnumConverter.parseScrollPhysics(value);
    if (_scrollPhysicsName != nextName || _scrollPhysics != nextPhysics) {
      _scrollPhysicsName = nextName;
      _scrollPhysics = nextPhysics;
      _requestUpdate();
    }
  }

  @override
  bool get pageSnapping => _pageSnapping;

  @override
  set pageSnapping(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pageSnapping != boolValue) {
      _pageSnapping = boolValue;
      _requestUpdate();
    }
  }

  @override
  CarouselSliderScrollDirection? get scrollDirection =>
      _scrollDirection == Axis.vertical
          ? CarouselSliderScrollDirection.vertical
          : CarouselSliderScrollDirection.horizontal;

  @override
  set scrollDirection(value) {
    final next = value is CarouselSliderScrollDirection
        ? (value == CarouselSliderScrollDirection.vertical
            ? Axis.vertical
            : Axis.horizontal)
        : TypeConverter.parseDirection(value);
    if (_scrollDirection != next) {
      _scrollDirection = next;
      _requestUpdate();
    }
  }

  @override
  bool get pauseAutoPlayOnTouch => _pauseAutoPlayOnTouch;

  @override
  set pauseAutoPlayOnTouch(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pauseAutoPlayOnTouch != boolValue) {
      _pauseAutoPlayOnTouch = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get pauseAutoPlayOnManualNavigate => _pauseAutoPlayOnManualNavigate;

  @override
  set pauseAutoPlayOnManualNavigate(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pauseAutoPlayOnManualNavigate != boolValue) {
      _pauseAutoPlayOnManualNavigate = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get pauseAutoPlayInFiniteScroll => _pauseAutoPlayInFiniteScroll;

  @override
  set pauseAutoPlayInFiniteScroll(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_pauseAutoPlayInFiniteScroll != boolValue) {
      _pauseAutoPlayInFiniteScroll = boolValue;
      _requestUpdate();
    }
  }

  @override
  String? get pageViewKey => _pageViewKeyValue;

  @override
  set pageViewKey(value) {
    final next = value?.toString();
    final normalized =
        next == null || next.trim().isEmpty ? null : next.trim();
    if (_pageViewKeyValue != normalized) {
      _pageViewKeyValue = normalized;
      _requestUpdate();
    }
  }

  @override
  CarouselSliderEnlargeStrategy? get enlargeStrategy {
    switch (_enlargeStrategy) {
      case CenterPageEnlargeStrategy.height:
        return CarouselSliderEnlargeStrategy.height;
      case CenterPageEnlargeStrategy.zoom:
        return CarouselSliderEnlargeStrategy.zoom;
      case CenterPageEnlargeStrategy.scale:
      default:
        return CarouselSliderEnlargeStrategy.scale;
    }
  }

  @override
  set enlargeStrategy(value) {
    final next = EnumConverter.parseEnlargeStrategy(value);
    if (_enlargeStrategy != next) {
      _enlargeStrategy = next;
      _requestUpdate();
    }
  }

  @override
  double? get enlargeFactor => _enlargeFactor;

  @override
  set enlargeFactor(value) {
    final next = TypeConverter.clampEnlargeFactor(
      value,
      defaultValue: _enlargeFactor,
    );
    if (_enlargeFactor != next) {
      _enlargeFactor = next;
      _requestUpdate();
    }
  }

  @override
  bool get disableCenter => _disableCenter;

  @override
  set disableCenter(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_disableCenter != boolValue) {
      _disableCenter = boolValue;
      _requestUpdate();
    }
  }

  @override
  bool get padEnds => _padEnds;

  @override
  set padEnds(value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_padEnds != boolValue) {
      _padEnds = boolValue;
      _requestUpdate();
    }
  }

  @override
  String? get clipBehavior => _clipBehaviorName;

  @override
  set clipBehavior(value) {
    final clip = TypeConverter.parseClipBehavior(
      value,
      fallback: _clipBehavior,
    );
    final name = TypeConverter.normalizeClipBehaviorName(
      value,
      fallback: _clipBehaviorName,
    );
    if (_clipBehavior != clip || _clipBehaviorName != name) {
      _clipBehavior = clip;
      _clipBehaviorName = name;
      _requestUpdate();
    }
  }

  @override
  double? get realPage => _realPage.toDouble();

  @override
  set realPage(value) {
    // 只读属性，忽略外部设置
  }

  @override
  bool get disableGesture => _disableGesture;

  @override
  set disableGesture(value) {
    final boolValue = TypeConverter.toBool(value);
    if (_disableGesture != boolValue) {
      _disableGesture = boolValue;
      _requestUpdate();
    }
  }

  Duration _parseDuration(dynamic value, {required Duration fallback}) {
    if (value == null) return fallback;
    final ms = TypeConverter.toInt(
      value,
      defaultValue: fallback.inMilliseconds,
      min: 0,
    );
    return Duration(milliseconds: ms);
  }

  Curve _parseCurve(dynamic value, {required Curve fallback}) {
    if (value == null) return fallback;
    return TypeConverter.parseEasing(value, fallback: fallback);
  }

  void _nextPageSync(List<dynamic> args) {
    final duration = _parseDuration(
      args.isNotEmpty ? args[0] : null,
      fallback: const Duration(milliseconds: 300),
    );
    final curve = _parseCurve(
      args.length > 1 ? args[1] : null,
      fallback: Curves.linear,
    );
    (state as WebFCarouselSliderState?)
        ?.nextPage(duration: duration, curve: curve);
  }

  void _previousPageSync(List<dynamic> args) {
    final duration = _parseDuration(
      args.isNotEmpty ? args[0] : null,
      fallback: const Duration(milliseconds: 300),
    );
    final curve = _parseCurve(
      args.length > 1 ? args[1] : null,
      fallback: Curves.linear,
    );
    (state as WebFCarouselSliderState?)
        ?.previousPage(duration: duration, curve: curve);
  }

  void _jumpToPageSync(List<dynamic> args) {
    if (args.isEmpty) return;
    final page = TypeConverter.toInt(args[0], min: 0);
    (state as WebFCarouselSliderState?)?.jumpToPage(page);
  }

  void _animateToPageSync(List<dynamic> args) {
    if (args.isEmpty) return;
    final page = TypeConverter.toInt(args[0], min: 0);
    final duration = _parseDuration(
      args.length > 1 ? args[1] : null,
      fallback: const Duration(milliseconds: 300),
    );
    final curve = _parseCurve(
      args.length > 2 ? args[2] : null,
      fallback: Curves.linear,
    );
    (state as WebFCarouselSliderState?)?.animateToPage(
      page: page,
      duration: duration,
      curve: curve,
    );
  }

  void _startAutoPlaySync(List<dynamic> args) {
    (state as WebFCarouselSliderState?)?.startAutoPlay();
  }

  void _stopAutoPlaySync(List<dynamic> args) {
    (state as WebFCarouselSliderState?)?.stopAutoPlay();
  }

  static final StaticDefinedSyncBindingObjectMethodMap carouselMethods = {
    'nextPage': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._nextPageSync(args);
        return null;
      },
    ),
    'previousPage': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._previousPageSync(args);
        return null;
      },
    ),
    'jumpToPage': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._jumpToPageSync(args);
        return null;
      },
    ),
    'animateToPage': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._animateToPageSync(args);
        return null;
      },
    ),
    'startAutoPlay': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._startAutoPlaySync(args);
        return null;
      },
    ),
    'stopAutoPlay': StaticDefinedSyncBindingObjectMethod(
      call: (element, args) {
        castToType<WebFCarouselSlider>(element)._stopAutoPlaySync(args);
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
  final GlobalKey _carouselKey = GlobalKey();

  WebFCarouselSliderState(super.widgetElement);

  @override
  WebFCarouselSlider get widgetElement =>
      super.widgetElement as WebFCarouselSlider;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
    _eventManager = CarouselEventManager(
      onPageChanged: () => widgetElement.onPageChanged,
      onScrolled: () => widgetElement.onScrolled,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncRealPageFromState();
    });
  }

  void _syncRealPageFromState({int? fallback}) {
    final dynamic sliderState = _carouselKey.currentState;
    final dynamic carouselState = sliderState?.state;
    final dynamic realPage = carouselState?.realPage;
    if (realPage is int) {
      widgetElement._setRealPage(realPage);
      return;
    }
    if (realPage is double) {
      widgetElement._setRealPage(realPage.toInt());
      return;
    }
    if (fallback != null) {
      widgetElement._setRealPage(fallback);
    }
  }

  void nextPage({required Duration duration, required Curve curve}) {
    _controller.nextPage(duration: duration, curve: curve);
  }

  void previousPage({required Duration duration, required Curve curve}) {
    _controller.previousPage(duration: duration, curve: curve);
  }

  void jumpToPage(int page) {
    _controller.jumpToPage(page);
  }

  void animateToPage({
    required int page,
    required Duration duration,
    required Curve curve,
  }) {
    _controller.animateToPage(page, duration: duration, curve: curve);
  }

  void startAutoPlay() {
    _controller.startAutoPlay();
  }

  void stopAutoPlay() {
    _controller.stopAutoPlay();
  }

  void _handlePageChanged(int index, CarouselPageChangedReason reason) {
    _syncRealPageFromState(fallback: index);
    _eventManager.dispatchPageChanged(index, reason);
  }

  void _handleScrolled(double? value) {
    _eventManager.dispatchScrolled(value);
  }

  CarouselOptions _buildOptions() {
    final config = CarouselConfig(
      height: widgetElement._height,
      aspectRatio: widgetElement._aspectRatio,
      viewportFraction: widgetElement._viewportFraction,
      initialPage: widgetElement._initialPage,
      enableInfiniteScroll: widgetElement._enableInfiniteScroll,
      animateToClosest: widgetElement._animateToClosest,
      reverse: widgetElement._reverse,
      autoPlay: widgetElement._autoPlay,
      autoPlayIntervalMs: widgetElement._autoPlayIntervalMs.toDouble(),
      autoPlayAnimationDurationMs:
          widgetElement._autoPlayAnimationDurationMs.toDouble(),
      autoPlayCurve: widgetElement._autoPlayCurve,
      enlargeCenterPage: widgetElement._enlargeCenterPage,
      scrollPhysics: widgetElement._scrollPhysics,
      pageSnapping: widgetElement._pageSnapping,
      scrollDirection: widgetElement._scrollDirection,
      pauseAutoPlayOnTouch: widgetElement._pauseAutoPlayOnTouch,
      pauseAutoPlayOnManualNavigate:
          widgetElement._pauseAutoPlayOnManualNavigate,
      pauseAutoPlayInFiniteScroll: widgetElement._pauseAutoPlayInFiniteScroll,
      pageViewKey: widgetElement._pageViewKeyValue == null
          ? null
          : PageStorageKey<String>(widgetElement._pageViewKeyValue!),
      enlargeStrategy: widgetElement._enlargeStrategy,
      enlargeFactor: widgetElement._enlargeFactor,
      disableCenter: widgetElement._disableCenter,
      padEnds: widgetElement._padEnds,
      clipBehavior: widgetElement._clipBehavior,
      onPageChanged: _handlePageChanged,
      onScrolled: _handleScrolled,
    );

    return config.build();
  }

  @override
  Widget build(BuildContext context) {
    final CSSRenderStyle renderStyle = widgetElement.renderStyle;
    double? width = renderStyle.width.computedValue;
    double? height = renderStyle.height.computedValue;
    if (width == 0) width = null;
    if (height == 0) height = null;

    final options = _buildOptions();
    final items = _buildItems();

    Widget content = CarouselSlider(
      key: _carouselKey,
      options: options,
      items: items,
      controller: _controller,
      disableGesture: widgetElement._disableGesture,
    );

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
    for (final child in widgetElement.childNodes) {
      if (child is WebFCarouselSliderItem) {
        children.add(child.toWidget());
      } else if (child is dom.Element) {
        children.add(child.toWidget());
      }
    }
    return children;
  }
}
