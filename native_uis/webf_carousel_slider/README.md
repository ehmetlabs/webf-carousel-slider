# WebF Carousel Slider (Flutter Custom Element)

WebF custom element wrapper for `carousel_slider_plus`. It exposes a high-performance `<webf-carousel-slider>` element to JavaScript while rendering with Flutter.

## Requirements

- Flutter >= 3.16.0
- Dart >= 3.0.0
- webf ^0.24.2
- carousel_slider_plus ^7.1.1

## Installation

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  webf_carousel_slider: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Flutter setup

Register the custom element once during app initialization:

```dart
import 'package:webf/webf.dart';
import 'package:webf_carousel_slider/webf_carousel_slider.dart';

void main() {
  WebFControllerManager.instance.initialize(
    WebFControllerManagerConfig(
      maxAliveInstances: 2,
      maxAttachedInstances: 1,
    ),
  );

  installWebFCarouselSlider();

  runApp(const MyApp());
}
```

## HTML usage

```html
<webf-carousel-slider
  autoplay
  autoplay-delay="3000"
  speed="300"
  slides-per-view="1"
  centered-slides
  loop
>
  <img src="https://example.com/slide-1.jpg" />
  <img src="https://example.com/slide-2.jpg" />
  <img src="https://example.com/slide-3.jpg" />
</webf-carousel-slider>
```

```javascript
const carousel = document.querySelector('webf-carousel-slider');

carousel.addEventListener('change', (event) => {
  console.log('Index:', event.detail.index);
  console.log('Reason:', event.detail.reason); // autoplay | drag | api
});

carousel.slideNext();
carousel.autoplayStop();
carousel.autoplayStart();
```

## API reference

This custom element keeps a Swiper-compatible subset of attributes and methods.

### Attributes (kebab-case)

| Attribute | Type | Default | Notes |
| --- | --- | --- | --- |
| `autoplay` | boolean | false | Enables autoplay. |
| `autoplay-delay` | number (ms) | 3000 | 500-60000. |
| `autoplay-disable-on-interaction` | boolean | false | Stops autoplay after interaction. |
| `speed` | number (ms) | 300 | 0-5000. |
| `loop` | boolean | false | Enables infinite loop. |
| `direction` | string | `horizontal` | `horizontal` or `vertical`. |
| `slides-per-view` | number | 1 | - |
| `centered-slides` | boolean | false | Centers slides in view. |
| `initial-slide` | number | 0 | Only used on first build. |
| `allow-touch-move` | boolean | true | Allows drag interaction. |

### Read-only properties

| Property | Type | Description |
| --- | --- | --- |
| `activeIndex` | number | Current active index. |

### Methods

These methods are available on the element instance:

- `slideNext(speed?: number)` - slide to the next page
- `slidePrev(speed?: number)` - slide to the previous page
- `slideTo(index: number, speed?: number)` - slide to an index
- `autoplayStart()` - start autoplay
- `autoplayStop()` - stop autoplay

### Events

| Event | Detail | Description |
| --- | --- | --- |
| `change` | `{ index, previousIndex, reason }` | Fired when the page changes. |
| `changestart` | `{ index }` | Fired when the user starts dragging. |
| `changeend` | `{ index }` | Fired when the user ends dragging. |
| `play` | - | Fired when autoplay starts. |
| `pause` | - | Fired when autoplay pauses. |

## WebF async rendering note

WebF performs layout asynchronously. If you need size measurements (for example,
`getBoundingClientRect()`), wait for the `onscreen` event before reading
layout-related properties.

## Testing

```bash
flutter test
```
