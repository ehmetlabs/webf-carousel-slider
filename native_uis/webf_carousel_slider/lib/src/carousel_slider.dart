import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webf/dom.dart' as dom;
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'carousel_slider_bindings_generated.dart';

/// WebF Custom Element wrapper for carousel_slider_plus.
/// Provides a high-performance carousel component accessible from JavaScript.
///
/// Extends the generated bindings class to enable automatic property mapping.
class CarouselSliderElement extends CarouselSliderBindings {
  CarouselSliderElement(super.context);

  // Internal state
  String _variant = 'default';
  bool _autoplay = false;
  double _autoplayInterval = 3.0;
  bool _enableInfiniteScroll = true;
  double _aspectRatio = 0.0;
  bool _enlargeCenterPage = false;
  double _viewportFraction = 1.0;
  int _currentIndex = 0;
  double? _autoPlayAnimationDuration;
  CarouselSliderAutoPlayCurve? _autoPlayCurve;
  double? _initialPage;
  bool _reverse = false;
  CarouselSliderScrollDirection? _scrollDirection;
  bool _padEnds = true;
  String? _height;

  // Property getters/setters
  String get variant => _variant;

  set variant(dynamic value) {
    if (value is String && _variant != value) {
      _variant = value;
      state?.requestUpdateState();
    }
  }

  @override
  bool get autoplay => _autoplay;

  @override
  set autoplay(dynamic value) {
    final boolValue = value is bool ? value : value == 'true' || value == '';
    if (_autoplay != boolValue) {
      _autoplay = boolValue;
      state?.requestUpdateState();
    }
  }

  @override
  double? get autoplayInterval => _autoplayInterval;

  @override
  set autoplayInterval(dynamic value) {
    final doubleValue = value is double ? value : double.tryParse(value.toString()) ?? 3.0;
    if (_autoplayInterval != doubleValue) {
      _autoplayInterval = doubleValue;
      state?.requestUpdateState();
    }
  }

  @override
  bool get enableInfiniteScroll => _enableInfiniteScroll;

  @override
  set enableInfiniteScroll(dynamic value) {
    final boolValue = value is bool ? value : value == 'true' || value == '';
    if (_enableInfiniteScroll != boolValue) {
      _enableInfiniteScroll = boolValue;
      state?.requestUpdateState();
    }
  }

  @override
  double? get aspectRatio => _aspectRatio;

  @override
  set aspectRatio(dynamic value) {
    final doubleValue = value is double ? value : double.tryParse(value.toString()) ?? 0.0;
    if (_aspectRatio != doubleValue && doubleValue > 0) {
      _aspectRatio = doubleValue;
      state?.requestUpdateState();
    }
  }

  @override
  bool get enlargeCenterPage => _enlargeCenterPage;

  @override
  set enlargeCenterPage(dynamic value) {
    final boolValue = value is bool ? value : value == 'true' || value == '';
    if (_enlargeCenterPage != boolValue) {
      _enlargeCenterPage = boolValue;
      state?.requestUpdateState();
    }
  }

  @override
  double? get viewportFraction => _viewportFraction;

  @override
  set viewportFraction(dynamic value) {
    final doubleValue = value is double ? value : double.tryParse(value.toString()) ?? 1.0;
    if (_viewportFraction != doubleValue && doubleValue > 0 && doubleValue <= 1.0) {
      _viewportFraction = doubleValue;
      state?.requestUpdateState();
    }
  }

  @override
  double? get currentIndex => _currentIndex.toDouble();

  @override
  set currentIndex(dynamic value) {
    final intValue = value is int ? value : (value is double ? value.toInt() : int.tryParse(value.toString()) ?? 0);
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
    // Options parsing - will trigger rebuild
    state?.requestUpdateState();
  }

  @override
  double? get autoPlayAnimationDuration => _autoPlayAnimationDuration;

  @override
  set autoPlayAnimationDuration(dynamic value) {
    final doubleValue = value is double ? value : double.tryParse(value.toString()) ?? 800.0;
    if (_autoPlayAnimationDuration != doubleValue) {
      _autoPlayAnimationDuration = doubleValue;
      state?.requestUpdateState();
    }
  }

  @override
  CarouselSliderAutoPlayCurve? get autoPlayCurve => _autoPlayCurve;

  @override
  set autoPlayCurve(dynamic value) {
    if (_autoPlayCurve != value) {
      _autoPlayCurve = value;
      state?.requestUpdateState();
    }
  }

  @override
  double? get initialPage => _initialPage?.toDouble();

  @override
  set initialPage(dynamic value) {
    final doubleValue = value is double ? value : double.tryParse(value.toString()) ?? 0.0;
    if (_initialPage != doubleValue) {
      _initialPage = doubleValue;
      state?.requestUpdateState();
    }
  }

  @override
  bool get reverse => _reverse;

  @override
  set reverse(dynamic value) {
    final boolValue = value is bool ? value : value == 'true' || value == '';
    if (_reverse != boolValue) {
      _reverse = boolValue;
      state?.requestUpdateState();
    }
  }

  @override
  CarouselSliderScrollDirection? get scrollDirection => _scrollDirection;

  @override
  set scrollDirection(dynamic value) {
    if (_scrollDirection != value) {
      _scrollDirection = value;
      state?.requestUpdateState();
    }
  }

  @override
  bool get padEnds => _padEnds;

  @override
  set padEnds(dynamic value) {
    final boolValue = value is bool ? value : value == 'true' || value == '';
    if (_padEnds != boolValue) {
      _padEnds = boolValue;
      state?.requestUpdateState();
    }
  }

  @override
  String? get height => _height;

  @override
  set height(dynamic value) {
    if (_height != value.toString()) {
      _height = value?.toString();
      state?.requestUpdateState();
    }
  }

  // Methods for programmatic control
  void next() {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.nextPage();
  }

  void previous() {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.previousPage();
  }

  void jumpToPage(int page) {
    final sliderState = state as CarouselSliderElementState?;
    sliderState?.jumpToPage(page);
  }

  void pause() {
    _autoplay = false;
    state?.requestUpdateState();
  }

  void resume() {
    _autoplay = true;
    state?.requestUpdateState();
  }

  Map<String, dynamic> _getCurrentOptions() {
    return {
      'variant': variant,
      'autoplay': autoplay,
      'autoplayInterval': autoplayInterval,
      'enableInfiniteScroll': enableInfiniteScroll,
      'aspectRatio': aspectRatio,
      'enlargeCenterPage': enlargeCenterPage,
      'viewportFraction': viewportFraction,
      'currentIndex': currentIndex,
    };
  }

  @override
  WebFWidgetElementState createState() {
    return CarouselSliderElementState(this);
  }
}

class CarouselSliderElementState extends WebFWidgetElementState {
  CarouselSliderController? _controller;

  CarouselSliderElementState(super.widgetElement);

  @override
  CarouselSliderElement get widgetElement =>
      super.widgetElement as CarouselSliderElement;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  void nextPage() {
    _controller?.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    _controller?.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void jumpToPage(int page) {
    _controller?.jumpToPage(page);
  }

  CarouselOptions _buildOptions() {
    final aspectRatioValue = widgetElement.aspectRatio ?? 0.0;
    return CarouselOptions(
      height: null,
      aspectRatio: aspectRatioValue > 0 ? aspectRatioValue : 16 / 9,
      viewportFraction: widgetElement.viewportFraction ?? 1.0,
      initialPage: (widgetElement.currentIndex ?? 0.0).toInt(),
      enableInfiniteScroll: widgetElement.enableInfiniteScroll,
      reverse: widgetElement.reverse,
      autoPlay: widgetElement.autoplay,
      autoPlayInterval: Duration(
          milliseconds: ((widgetElement.autoplayInterval ?? 3.0) * 1000).toInt()),
      autoPlayAnimationDuration: Duration(
          milliseconds: (widgetElement.autoPlayAnimationDuration ?? 800.0).toInt()),
      autoPlayCurve: widgetElement._autoPlayCurve == null
          ? Curves.ease
          : (widgetElement._autoPlayCurve == CarouselSliderAutoPlayCurve.curvesEase
              ? Curves.ease
              : widgetElement._autoPlayCurve == CarouselSliderAutoPlayCurve.curvesEaseIn
                  ? Curves.easeIn
                  : widgetElement._autoPlayCurve == CarouselSliderAutoPlayCurve.curvesEaseOut
                      ? Curves.easeOut
                      : widgetElement._autoPlayCurve == CarouselSliderAutoPlayCurve.curvesEaseInOut
                          ? Curves.easeInOut
                          : Curves.fastOutSlowIn),
      enlargeCenterPage: widgetElement.enlargeCenterPage,
      scrollDirection: widgetElement.scrollDirection == null ||
              widgetElement.scrollDirection == CarouselSliderScrollDirection.axisHorizontal
          ? Axis.horizontal
          : Axis.vertical,
      padEnds: widgetElement.padEnds,
      onPageChanged: _onPageChanged,
    );
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    widgetElement._currentIndex = index;

    // Dispatch change event with detail data
    widgetElement.dispatchEvent(CustomEvent(
      'change',
      detail: {
        'index': index,
        'reason': reason.toString().split('.').last,
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final options = _buildOptions();

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
    final items = children.isNotEmpty
        ? children
        : [placeholder, placeholder, placeholder];

    return CarouselSlider(
      options: options,
      items: items,
      controller: _controller,
    );
  }
}
