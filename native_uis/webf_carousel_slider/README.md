# WebF Carousel Slider (Flutter Custom Element)

WebF custom element wrapper for `carousel_slider_plus`. It exposes a high-performance `<carousel-slider>` element to JavaScript while rendering with Flutter.

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
<carousel-slider
  autoplay="true"
  autoplay-interval="4"
  aspect-ratio="16/9"
  viewport-fraction="0.8"
  enlarge-center-page="true"
>
  <img src="https://example.com/slide-1.jpg" />
  <img src="https://example.com/slide-2.jpg" />
  <img src="https://example.com/slide-3.jpg" />
</carousel-slider>
```

```javascript
const carousel = document.querySelector('carousel-slider');

carousel.addEventListener('change', (event) => {
  console.log('Index:', event.detail.index);
  console.log('Reason:', event.detail.reason); // timed | manual | controller
});

carousel.next();
carousel.pause();
carousel.resume();
```

## Options JSON (batch config + items)

You can set multiple attributes with a single JSON string via `options`. The keys use camelCase.

```javascript
carousel.options = JSON.stringify({
  autoplay: true,
  autoplayInterval: 3,
  viewportFraction: 0.9,
  enlargeCenterPage: true,
  enlargeFactor: 0.2,
  items: [
    { id: 1, url: 'https://example.com/1.jpg' },
    { id: 2, url: 'https://example.com/2.jpg' },
  ],
});
```

Notes:

- `items` is used only when there are no child elements.
- Invalid JSON will emit an `error` event with the parse message.

Supported keys:

- `autoplay`
- `autoplayInterval`
- `enableInfiniteScroll`
- `aspectRatio`
- `enlargeCenterPage`
- `viewportFraction`
- `initialPage`
- `height`
- `autoPlayAnimationDuration`
- `autoPlayCurve`
- `reverse`
- `scrollDirection`
- `padEnds`
- `pauseAutoPlayOnTouch`
- `pauseAutoPlayOnManualNavigate`
- `pageSnapping`
- `enlargeFactor`
- `currentIndex`
- `animateToClosest`
- `pauseAutoPlayInFiniteScroll`
- `disableCenter`
- `enlargeStrategy`
- `scrollPhysics`
- `items`

## API reference

### Attributes (kebab-case)

| Attribute | Type | Default | Notes |
| --- | --- | --- | --- |
| `current-index` | number | 0 | Read/write. Setting triggers a jump. |
| `options` | string (JSON) | - | Batch config via camelCase keys. |
| `height` | string | - | Overrides `aspect-ratio` when provided. |
| `aspect-ratio` | number | 16/9 | Clamped to 0.1-10.0. |
| `viewport-fraction` | number | 0.8 | Clamped to 0.01-1.0. |
| `initial-page` | number | 0 | Only used on first build. |
| `pad-ends` | boolean | true | Adds padding when `viewport-fraction` < 1. |
| `disable-center` | boolean | false | Disables the Center wrapper. |
| `enable-infinite-scroll` | boolean | true | Enables circular scrolling. |
| `animate-to-closest` | boolean | true | Chooses the nearest loop path. |
| `reverse` | boolean | false | Reverses scroll direction. |
| `scroll-direction` | string | Axis.horizontal | Accepts `Axis.horizontal`, `Axis.vertical`, `horizontal`, `vertical`. |
| `page-snapping` | boolean | true | Snaps to page boundaries. |
| `scroll-physics` | string | - | `clamping`, `bouncing`, `fixed`. |
| `autoplay` | boolean | false | Enables autoplay. |
| `autoplay-interval` | number (seconds) | 4.0 | Clamped to 0.5-60.0. |
| `auto-play-animation-duration` | number (ms) | 800 | Clamped to 100-5000. |
| `auto-play-curve` | string | Curves.fastOutSlowIn | Accepts Curves.* or short names like `ease`. |
| `pause-auto-play-on-touch` | boolean | true | Pauses on touch. |
| `pause-auto-play-on-manual-navigate` | boolean | true | Pauses when calling navigation methods. |
| `pause-auto-play-in-finite-scroll` | boolean | false | Pauses at the end when infinite scroll is off. |
| `enlarge-center-page` | boolean | false | Enlarges the active page. |
| `enlarge-strategy` | string | scale | `scale`, `height`, `zoom`. |
| `enlarge-factor` | number | 0.3 | Clamped to 0.0-1.0. |

### Methods

These methods are available on the element instance:

- `next()` - move to the next page (fixed 300ms ease animation)
- `previous()` - move to the previous page (fixed 300ms ease animation)
- `jumpToPage(page: number)` - jump without animation
- `pause()` / `resume()` - pause or resume autoplay
- `startAutoPlay()` / `stopAutoPlay()` - explicit autoplay control

### Events

| Event | Detail | Description |
| --- | --- | --- |
| `change` | `{ index, reason }` | Fired when the page changes. |
| `slidestart` | - | Fired when the user starts dragging. |
| `slideend` | - | Fired when the user stops dragging. |
| `pageanimationstart` | `{ from, to }` | Fired when page animation starts. |
| `pageanimationend` | `{ index }` | Fired when page animation ends. |
| `autoplaypause` | - | Fired when autoplay is paused. |
| `autoplayresume` | - | Fired when autoplay resumes. |
| `scrolled` | `number` | Fired on scroll (throttled to 100ms). |
| `itemclick` | `{ id }` | Fired when an image item is clicked. |
| `error` | `{ message, stack? }` | Fired on options parsing errors. |

## Testing

```bash
flutter test
```
