import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webf/dom.dart' as dom;
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

/// WebF Custom Element wrapper for carousel_slider_plus.
/// Provides a high-performance carousel component accessible from JavaScript.
///
/// This is a base implementation extending WidgetElement directly.
/// After running WebF CLI codegen, this should extend the generated bindings class.
class CarouselSliderElement extends WidgetElement {
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

  // Property getters/setters
  String get variant => _variant;

  set variant(String value) {
    if (_variant != value) {
      _variant = value;
      state?.requestUpdateState();
    }
  }

  bool get autoplay => _autoplay;

  set autoplay(bool value) {
    if (_autoplay != value) {
      _autoplay = value;
      state?.requestUpdateState();
    }
  }

  double get autoplayInterval => _autoplayInterval;

  set autoplayInterval(double value) {
    if (_autoplayInterval != value) {
      _autoplayInterval = value;
      state?.requestUpdateState();
    }
  }

  bool get enableInfiniteScroll => _enableInfiniteScroll;

  set enableInfiniteScroll(bool value) {
    if (_enableInfiniteScroll != value) {
      _enableInfiniteScroll = value;
      state?.requestUpdateState();
    }
  }

  double get aspectRatio => _aspectRatio;

  set aspectRatio(double value) {
    if (_aspectRatio != value && value > 0) {
      _aspectRatio = value;
      state?.requestUpdateState();
    }
  }

  bool get enlargeCenterPage => _enlargeCenterPage;

  set enlargeCenterPage(bool value) {
    if (_enlargeCenterPage != value) {
      _enlargeCenterPage = value;
      state?.requestUpdateState();
    }
  }

  double get viewportFraction => _viewportFraction;

  set viewportFraction(double value) {
    if (_viewportFraction != value && value > 0 && value <= 1.0) {
      _viewportFraction = value;
      state?.requestUpdateState();
    }
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    if (_currentIndex != value) {
      _currentIndex = value;
      // Trigger page change
      final sliderState = state as CarouselSliderElementState?;
      sliderState?.jumpToPage(value);
    }
  }

  String get options => jsonEncode(_getCurrentOptions());

  set options(String value) {
    // Options parsing - will trigger rebuild
    state?.requestUpdateState();
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
    return CarouselOptions(
      height: null,
      aspectRatio:
          widgetElement.aspectRatio > 0 ? widgetElement.aspectRatio : 16 / 9,
      viewportFraction: widgetElement.viewportFraction,
      initialPage: widgetElement.currentIndex,
      enableInfiniteScroll: widgetElement.enableInfiniteScroll,
      reverse: false,
      autoPlay: widgetElement.autoplay,
      autoPlayInterval: Duration(
          milliseconds: (widgetElement.autoplayInterval * 1000).toInt()),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.ease,
      enlargeCenterPage: widgetElement.enlargeCenterPage,
      scrollDirection: Axis.horizontal,
      padEnds: true,
      onPageChanged: _onPageChanged,
    );
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    widgetElement._currentIndex = index;

    // Dispatch change event
    widgetElement.dispatchEvent(Event('change'));
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
