import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webf/dom.dart' as dom;
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'carousel_slider_bindings_generated.dart';

// 导入新的工具类和管理器
import 'utils/type_converter.dart';
import 'utils/enum_converter.dart';
import 'config/carousel_config.dart';
import 'event/event_manager.dart';
import 'event/scroll_listener.dart';
import 'controller/controller_manager.dart';

/// WebF Custom Element wrapper for carousel_slider_plus.
/// Provides a high-performance carousel component accessible from JavaScript.
///
/// Extends the generated bindings class to enable automatic property mapping.
class CarouselSliderElement extends CarouselSliderBindings {
  CarouselSliderElement(super.context);

  // Internal state
  bool _autoplay = false;
  double _autoplayInterval = 4.0;
  bool _enableInfiniteScroll = true;
  double _aspectRatio = 16 / 9;
  bool _enlargeCenterPage = false;
  double _viewportFraction = 0.8;
  int _currentIndex = 0;
  double? _autoPlayAnimationDuration;
  Curve? _autoPlayCurve = Curves.fastOutSlowIn;
  double? _initialPage;
  bool _reverse = false;
  Axis _scrollDirection = Axis.horizontal;
  bool _padEnds = true;
  String? _height;

  // 新增的配置选项
  bool _pauseAutoPlayOnTouch = true;
  bool _pauseAutoPlayOnManualNavigate = true;
  bool _pageSnapping = true;
  double? _enlargeFactor;

  // 新增属性状态
  bool _animateToClosest = true;
  bool _pauseAutoPlayInFiniteScroll = false;
  bool _disableCenter = false;
  CenterPageEnlargeStrategy _enlargeStrategy =
      CenterPageEnlargeStrategy.scale;
  ScrollPhysics? _scrollPhysics;

  // 新的配置和管理器
  CarouselConfig? _config;

  void _invalidateConfigAndRequestUpdate() {
    _config = null;
    state?.requestUpdateState();
  }

  CarouselEventManager? get _eventManager =>
      (state as CarouselSliderElementState?)?._eventManager;

  @override
  bool get autoplay => _autoplay;

  @override
  set autoplay(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: false);
    if (_autoplay != boolValue) {
      _autoplay = boolValue;
      _config = null; // 清除缓存，触发重建
      state?.requestUpdateState();
    }
  }

  @override
  double? get autoplayInterval => _autoplayInterval;

  @override
  set autoplayInterval(dynamic value) {
    final doubleValue = TypeConverter.validateAutoplayInterval(value);
    if (_autoplayInterval != doubleValue) {
      _autoplayInterval = doubleValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get enableInfiniteScroll => _enableInfiniteScroll;

  @override
  set enableInfiniteScroll(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_enableInfiniteScroll != boolValue) {
      _enableInfiniteScroll = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  double? get aspectRatio => _aspectRatio;

  @override
  set aspectRatio(dynamic value) {
    final doubleValue = TypeConverter.validateAspectRatio(value);
    if (_aspectRatio != doubleValue) {
      _aspectRatio = doubleValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get enlargeCenterPage => _enlargeCenterPage;

  @override
  set enlargeCenterPage(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: false);
    if (_enlargeCenterPage != boolValue) {
      _enlargeCenterPage = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  double? get viewportFraction => _viewportFraction;

  @override
  set viewportFraction(dynamic value) {
    final doubleValue = TypeConverter.validateViewportFraction(value);
    if (_viewportFraction != doubleValue) {
      _viewportFraction = doubleValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  double? get currentIndex => _currentIndex.toDouble();

  @override
  set currentIndex(dynamic value) {
    final intValue = TypeConverter.toInt(value, defaultValue: 0, min: 0);
    if (_currentIndex != intValue) {
      _currentIndex = intValue;
      // Trigger page change
      final sliderState = state as CarouselSliderElementState?;
      sliderState?.jumpToPage(intValue);
    }
  }

  @override
  String? get options => jsonEncode(_getCurrentOptions());

  @override
  set options(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return;
    }

    try {
      final json = jsonDecode(value.toString()) as Map<String, dynamic>;

      void applyIfPresent(String key, void Function(dynamic) apply) {
        if (json.containsKey(key)) {
          apply(json[key]);
        }
      }

      // 批量更新属性（保持顺序，避免潜在的依赖差异）
      applyIfPresent('autoplay', (v) => autoplay = v);
      applyIfPresent('autoplayInterval', (v) => autoplayInterval = v);
      applyIfPresent('enableInfiniteScroll', (v) => enableInfiniteScroll = v);
      applyIfPresent('aspectRatio', (v) => aspectRatio = v);
      applyIfPresent('enlargeCenterPage', (v) => enlargeCenterPage = v);
      applyIfPresent('viewportFraction', (v) => viewportFraction = v);
      applyIfPresent('initialPage', (v) => initialPage = v);
      applyIfPresent('height', (v) => height = v);
      applyIfPresent(
        'autoPlayAnimationDuration',
        (v) => autoPlayAnimationDuration = v,
      );
      applyIfPresent('autoPlayCurve', (v) => autoPlayCurve = v);
      applyIfPresent('reverse', (v) => reverse = v);
      applyIfPresent('scrollDirection', (v) => scrollDirection = v);
      applyIfPresent('padEnds', (v) => padEnds = v);
      applyIfPresent('pauseAutoPlayOnTouch', (v) => pauseAutoPlayOnTouch = v);
      applyIfPresent(
        'pauseAutoPlayOnManualNavigate',
        (v) => pauseAutoPlayOnManualNavigate = v,
      );
      applyIfPresent('pageSnapping', (v) => pageSnapping = v);
      applyIfPresent('enlargeFactor', (v) => enlargeFactor = v);
      applyIfPresent('currentIndex', (v) => currentIndex = v);
      // 新增属性处理
      applyIfPresent('animateToClosest', (v) => animateToClosest = v);
      applyIfPresent(
        'pauseAutoPlayInFiniteScroll',
        (v) => pauseAutoPlayInFiniteScroll = v,
      );
      applyIfPresent('disableCenter', (v) => disableCenter = v);
      applyIfPresent('enlargeStrategy', (v) => enlargeStrategy = v);
      applyIfPresent('scrollPhysics', (v) => scrollPhysics = v);

      // 触发重建
      state?.requestUpdateState();
    } catch (e) {
      // 派发错误事件
      final eventManager =
          (state as CarouselSliderElementState?)?._eventManager;
      eventManager?.dispatchError('Failed to parse options: $e');
    }
  }

  @override
  double? get autoPlayAnimationDuration => _autoPlayAnimationDuration;

  @override
  set autoPlayAnimationDuration(dynamic value) {
    final doubleValue =
        TypeConverter.toDouble(value, defaultValue: 800.0, min: 100, max: 5000);
    if (_autoPlayAnimationDuration != doubleValue) {
      _autoPlayAnimationDuration = doubleValue;
      _config = null;
      state?.requestUpdateState();
    }
  }

  @override
  String? get autoPlayCurve => _autoPlayCurve?.toString();

  @override
  set autoPlayCurve(dynamic value) {
    final curveValue = TypeConverter.parseAutoPlayCurve(value);
    if (_autoPlayCurve != curveValue) {
      _autoPlayCurve = curveValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  double? get initialPage => _initialPage?.toDouble();

  @override
  set initialPage(dynamic value) {
    final doubleValue =
        TypeConverter.toDouble(value, defaultValue: 0.0, min: 0);
    if (_initialPage != doubleValue) {
      _initialPage = doubleValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get reverse => _reverse;

  @override
  set reverse(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: false);
    if (_reverse != boolValue) {
      _reverse = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  String? get scrollDirection => _scrollDirection.toString();

  @override
  set scrollDirection(dynamic value) {
    final directionValue = TypeConverter.parseScrollDirection(value);
    if (_scrollDirection != directionValue) {
      _scrollDirection = directionValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get padEnds => _padEnds;

  @override
  set padEnds(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_padEnds != boolValue) {
      _padEnds = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  String? get height => _height;

  @override
  set height(dynamic value) {
    final stringValue = TypeConverter.asString(value);
    if (_height != stringValue) {
      _height = stringValue.isNotEmpty ? stringValue : null;
      state?.requestUpdateState();
    }
  }

  // 新增属性的 getter/setter

  @override
  bool get pauseAutoPlayOnTouch => _pauseAutoPlayOnTouch;

  @override
  set pauseAutoPlayOnTouch(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pauseAutoPlayOnTouch != boolValue) {
      _pauseAutoPlayOnTouch = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get pauseAutoPlayOnManualNavigate => _pauseAutoPlayOnManualNavigate;

  @override
  set pauseAutoPlayOnManualNavigate(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pauseAutoPlayOnManualNavigate != boolValue) {
      _pauseAutoPlayOnManualNavigate = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get pageSnapping => _pageSnapping;

  @override
  set pageSnapping(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_pageSnapping != boolValue) {
      _pageSnapping = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  double? get enlargeFactor => _enlargeFactor;

  @override
  set enlargeFactor(dynamic value) {
    final doubleValue = TypeConverter.validateEnlargeFactor(value);
    if (_enlargeFactor != doubleValue) {
      _enlargeFactor = doubleValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  // 新增属性的 getter/setter

  @override
  bool get animateToClosest => _animateToClosest;

  @override
  set animateToClosest(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: true);
    if (_animateToClosest != boolValue) {
      _animateToClosest = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get pauseAutoPlayInFiniteScroll => _pauseAutoPlayInFiniteScroll;

  @override
  set pauseAutoPlayInFiniteScroll(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: false);
    if (_pauseAutoPlayInFiniteScroll != boolValue) {
      _pauseAutoPlayInFiniteScroll = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  bool get disableCenter => _disableCenter;

  @override
  set disableCenter(dynamic value) {
    final boolValue = TypeConverter.toBool(value, defaultValue: false);
    if (_disableCenter != boolValue) {
      _disableCenter = boolValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  String? get enlargeStrategy => _enlargeStrategy.toString();

  @override
  set enlargeStrategy(dynamic value) {
    final enumValue = EnumConverter.parseEnlargeStrategy(value);
    if (_enlargeStrategy != enumValue) {
      _enlargeStrategy = enumValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  @override
  String? get scrollPhysics {
    if (_scrollPhysics == null) return null;
    if (_scrollPhysics is ClampingScrollPhysics) return 'clamping';
    if (_scrollPhysics is BouncingScrollPhysics) return 'bouncing';
    if (_scrollPhysics is FixedExtentScrollPhysics) return 'fixed';
    return null;
  }

  @override
  set scrollPhysics(dynamic value) {
    final physicsValue = EnumConverter.parseScrollPhysics(value);
    if (_scrollPhysics != physicsValue) {
      _scrollPhysics = physicsValue;
      _invalidateConfigAndRequestUpdate();
    }
  }

  // Methods for programmatic control
  void next(List<dynamic>? args) {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.nextPage();
  }

  void previous(List<dynamic>? args) {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.previousPage();
  }

  void jumpToPage(List<dynamic>? args) {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.jumpToPage(args?.first as int? ?? 0);
  }

  void pause(List<dynamic>? args) {
    _autoplay = false;
    // 派发自动播放暂停事件
    _eventManager?.dispatchAutoplayPause();
    state?.requestUpdateState();
  }

  void resume(List<dynamic>? args) {
    _autoplay = true;
    // 派发自动播放恢复事件
    _eventManager?.dispatchAutoplayResume();
    state?.requestUpdateState();
  }

  void startAutoPlay(List<dynamic>? args) {
    _autoplay = true;
    // 派发自动播放恢复事件
    _eventManager?.dispatchAutoplayResume();
    state?.requestUpdateState();
  }

  void stopAutoPlay(List<dynamic>? args) {
    _autoplay = false;
    // 派发自动播放暂停事件
    _eventManager?.dispatchAutoplayPause();
    state?.requestUpdateState();
  }

  Map<String, dynamic> _getCurrentOptions() {
    final autoPlayCurve =
        (_autoPlayCurve ?? Curves.fastOutSlowIn).toString();
    final enlargeStrategy = _enlargeStrategy.toString();
    final scrollDirection =
        _scrollDirection == Axis.horizontal ? 'horizontal' : 'vertical';

    return {
      'autoplay': autoplay,
      'autoplayInterval': autoplayInterval,
      'autoPlayAnimationDuration': _autoPlayAnimationDuration ?? 800.0,
      'autoPlayCurve': autoPlayCurve,
      'enableInfiniteScroll': enableInfiniteScroll,
      'aspectRatio': aspectRatio,
      'enlargeCenterPage': enlargeCenterPage,
      'enlargeFactor': enlargeFactor ?? 0.3,
      'viewportFraction': viewportFraction,
      'initialPage': _initialPage ?? _currentIndex,
      'reverse': reverse,
      'scrollDirection': scrollDirection,
      'padEnds': padEnds,
      'pageSnapping': pageSnapping,
      'pauseAutoPlayOnTouch': pauseAutoPlayOnTouch,
      'pauseAutoPlayOnManualNavigate': pauseAutoPlayOnManualNavigate,
      'scrollPhysics': scrollPhysics,
      'animateToClosest': animateToClosest,
      'pauseAutoPlayInFiniteScroll': pauseAutoPlayInFiniteScroll,
      'disableCenter': disableCenter,
      'enlargeStrategy': enlargeStrategy,
      'height': height,
      'currentIndex': currentIndex,
    };
  }

  @override
  WebFWidgetElementState createState() {
    return CarouselSliderElementState(this);
  }
}

class CarouselSliderElementState extends WebFWidgetElementState {
  late final CarouselControllerManager _controllerManager;
  late final CarouselEventManager _eventManager;

  // 缓存子组件列表
  List<Widget>? _cachedItems;
  int? _cachedChildCount;

  CarouselSliderElementState(super.widgetElement);

  @override
  CarouselSliderElement get widgetElement =>
      super.widgetElement as CarouselSliderElement;

  @override
  void initState() {
    super.initState();
    _controllerManager = CarouselControllerManager();
    _eventManager = CarouselEventManager(widgetElement);
  }

  @override
  void dispose() {
    _controllerManager.dispose();
    super.dispose();
  }

  void nextPage() {
    _controllerManager.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    _controllerManager.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void jumpToPage(int page) {
    _controllerManager.jumpToPage(page);
  }

  CarouselOptions _buildOptions() {
    // 复用或创建配置对象
    final config = widgetElement._config ??= CarouselConfig(
      aspectRatio: widgetElement._aspectRatio,
      viewportFraction: widgetElement._viewportFraction,
      initialPage:
          (widgetElement._initialPage ?? widgetElement._currentIndex.toDouble()),
      enableInfiniteScroll: widgetElement._enableInfiniteScroll,
      reverse: widgetElement._reverse,
      autoPlay: widgetElement._autoplay,
      autoPlayInterval: widgetElement._autoplayInterval,
      autoPlayAnimationDuration: widgetElement._autoPlayAnimationDuration,
      autoPlayCurve: widgetElement._autoPlayCurve,
      enlargeCenterPage: widgetElement._enlargeCenterPage,
      enlargeFactor: widgetElement._enlargeFactor,
      scrollDirection: widgetElement._scrollDirection,
      padEnds: widgetElement._padEnds,
      pageSnapping: widgetElement._pageSnapping,
      scrollPhysics: widgetElement._scrollPhysics,
      pauseAutoPlayOnTouch: widgetElement._pauseAutoPlayOnTouch,
      pauseAutoPlayOnManualNavigate:
          widgetElement._pauseAutoPlayOnManualNavigate,
      onPageChanged: _onPageChanged,
      animateToClosest: widgetElement._animateToClosest,
      pauseAutoPlayInFiniteScroll: widgetElement._pauseAutoPlayInFiniteScroll,
      disableCenter: widgetElement._disableCenter,
      enlargeStrategy: widgetElement._enlargeStrategy,
    );

    return config.build();
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    final previousIndex = widgetElement._currentIndex;
    widgetElement._currentIndex = index;

    // 派发页面动画开始事件
    _eventManager.dispatchAnimationStart(previousIndex, index);

    // 使用 EventManager 派发事件
    _eventManager.dispatchPageChanged(index, reason);

    // 派发页面动画结束事件（延迟执行，模拟动画完成）
    Future.delayed(const Duration(milliseconds: 300), () {
      _eventManager.dispatchAnimationEnd(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final options = _buildOptions();

    // 获取当前子节点数量
    final currentChildCount = widgetElement.childNodes.length;

    // 只在子节点数量变化时重建子组件列表
    if (_cachedItems == null || _cachedChildCount != currentChildCount) {
      _cachedItems = _buildItems();
      _cachedChildCount = currentChildCount;
    }

    final carousel = CarouselSlider(
      options: options,
      items: _cachedItems!,
      controller: _controllerManager.controller,
    );

    // 用 GestureDetector 包裹以捕获滑动手势
    final gestureCarousel = GestureDetector(
      onPanStart: (_) {
        _eventManager.dispatchSlideStart();
      },
      onPanEnd: (_) {
        _eventManager.dispatchSlideEnd();
      },
      child: carousel,
    );

    // 包裹滚动监听器以派发 scrolled 事件
    final scrollListener = CarouselScrollListener(
      element: widgetElement,
      child: gestureCarousel,
    );

    // 应用 height 属性
    if (widgetElement._height != null && widgetElement._height!.isNotEmpty) {
      final heightValue = _parseHeight(widgetElement._height!);
      if (heightValue != null) {
        return SizedBox(height: heightValue, child: scrollListener);
      }
    }

    return scrollListener;
  }

  /// 构建子组件列表
  List<Widget> _buildItems() {
    // Build placeholder widgets
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
              'Add child elements',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    // Build child widgets from element children
    final List<Widget> children = [];
    for (var child in widgetElement.childNodes) {
      // Only process element nodes
      if (child is dom.Element) {
        final element = child;
        // Convert element to widget
        children.add(element.toWidget());
      }
    }

    // Use placeholder if no children
    return children.isNotEmpty
        ? children
        : [placeholder, placeholder, placeholder];
  }

  /// 解析高度字符串
  /// 支持 "400", "400px", "400.0" 等格式
  double? _parseHeight(String heightStr) {
    final str = heightStr.trim().toLowerCase();

    // 移除 px 后缀
    if (str.endsWith('px')) {
      final numStr = str.replaceAll('px', '').trim();
      return double.tryParse(numStr);
    }

    // 直接解析数字
    return double.tryParse(str);
  }
}
