import 'package:flutter/material.dart';
import 'package:webf/css.dart';
import 'package:webf/dom.dart' as dom;
import 'package:webf/webf.dart';

class WebFCarouselSliderItem extends WidgetElement {
  WebFCarouselSliderItem(super.context);

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  set imageUrl(dynamic value) {
    final next = _normalizeText(value?.toString());
    if (_imageUrl != next) {
      _imageUrl = next;
      _requestUpdate();
    }
  }

  void _requestUpdate() {
    state?.requestUpdateState(() {});
  }

  static String? _normalizeText(String? value) {
    if (value == null) {
      return null;
    }
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  @override
  void initializeAttributes(Map<String, ElementAttributeProperty> attributes) {
    super.initializeAttributes(attributes);
    attributes['image-url'] = ElementAttributeProperty(
      getter: () => _imageUrl,
      setter: (value) => imageUrl = value,
      deleter: () => imageUrl = null,
    );
  }

  static final StaticDefinedBindingPropertyMap carouselSliderItemProperties = {
    'imageUrl': StaticDefinedBindingProperty(
      getter: (element) => castToType<WebFCarouselSliderItem>(element).imageUrl,
      setter: (element, value) =>
          castToType<WebFCarouselSliderItem>(element).imageUrl = value,
    ),
  };

  @override
  List<StaticDefinedBindingPropertyMap> get properties => [
        ...super.properties,
        carouselSliderItemProperties,
      ];

  @override
  WebFWidgetElementState createState() {
    return WebFCarouselSliderItemState(this);
  }
}

class WebFCarouselSliderItemState extends WebFWidgetElementState {
  WebFCarouselSliderItemState(super.widgetElement);

  @override
  WebFCarouselSliderItem get widgetElement =>
      super.widgetElement as WebFCarouselSliderItem;

  @override
  Widget build(BuildContext context) {
    final CSSRenderStyle renderStyle = widgetElement.renderStyle;
    double? width = renderStyle.width.computedValue;
    double? height = renderStyle.height.computedValue;
    if (width == 0) width = null;
    if (height == 0) height = null;

    final baseImage = _buildImageLayer();
    final overlayWidgets = _buildOverlayWidgets();

    final layers = <Widget>[
      Positioned.fill(child: baseImage),
    ];

    if (overlayWidgets.isNotEmpty) {
      layers.add(Positioned.fill(
        child: Stack(
          fit: StackFit.expand,
          children: overlayWidgets,
        ),
      ));
    }

    Widget content = Stack(
      fit: StackFit.expand,
      children: layers,
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

  Widget _buildImageLayer() {
    final imageUrl = widgetElement.imageUrl;
    if (imageUrl == null) {
      return const SizedBox.expand();
    }
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(color: Colors.transparent);
      },
    );
  }

  List<Widget> _buildOverlayWidgets() {
    final overlays = <Widget>[];
    for (final node in widgetElement.childNodes) {
      if (node is dom.Element) {
        overlays.add(node.toWidget());
      }
    }
    return overlays;
  }
}
