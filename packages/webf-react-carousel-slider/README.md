# WebF React Carousel Slider

React wrapper for the WebF `<carousel-slider>` custom element. It is intended for WebF environments where the Flutter custom element is registered.

## Requirements

- React >= 16.8
- react-dom >= 16.8
- @openwebf/react-core-ui ^0.24.2
- Flutter-side registration via `webf_carousel_slider` (see `native_uis/webf_carousel_slider`)

## Installation

```bash
npm install @ehmetlabs/webf-react-carousel-slider
```

## Usage

```tsx
import React, { useRef } from 'react';
import {
  CarouselSlider,
  CarouselSliderElement,
  Axis,
  Curve,
} from '@ehmetlabs/webf-react-carousel-slider';

export function App() {
  const ref = useRef<CarouselSliderElement>(null);

  return (
    <CarouselSlider
      ref={ref}
      autoplay
      autoplayInterval={4}
      aspectRatio={16 / 9}
      viewportFraction={0.8}
      enlargeCenterPage
      scrollDirection={Axis.horizontal}
      autoPlayCurve={Curve.fastOutSlowIn}
      onChange={(event) => {
        console.log(event.detail.index, event.detail.reason);
      }}
    >
      <img src="https://example.com/1.jpg" />
      <img src="https://example.com/2.jpg" />
    </CarouselSlider>
  );
}
```

## Options JSON (batch config + items)

If you prefer a single JSON string, use `options`. Keys are camelCase.

```tsx
<CarouselSlider
  options={JSON.stringify({
    autoplay: true,
    autoplayInterval: 3,
    items: [
      { id: 1, url: 'https://example.com/1.jpg' },
      { id: 2, url: 'https://example.com/2.jpg' },
    ],
  })}
  onItemclick={(event) => {
    console.log('Clicked:', event.detail.id);
  }}
/>;
```

Notes:

- `items` is used only when there are no children.
- Invalid JSON triggers an `error` event on the underlying element.

## Props

All props map to kebab-case attributes on `<carousel-slider>` unless noted.

| Prop | Type | Default | Attribute |
| --- | --- | --- | --- |
| `currentIndex` | number | 0 | `current-index` |
| `options` | string (JSON) | - | `options` |
| `height` | string | - | `height` |
| `aspectRatio` | number | 16/9 | `aspect-ratio` |
| `viewportFraction` | number | 0.8 | `viewport-fraction` |
| `initialPage` | number | 0 | `initial-page` |
| `padEnds` | boolean | true | `pad-ends` |
| `disableCenter` | boolean | false | `disable-center` |
| `enableInfiniteScroll` | boolean | true | `enable-infinite-scroll` |
| `animateToClosest` | boolean | true | `animate-to-closest` |
| `reverse` | boolean | false | `reverse` |
| `scrollDirection` | Axis | Axis.horizontal | `scroll-direction` |
| `pageSnapping` | boolean | true | `page-snapping` |
| `scrollPhysics` | string | - | `scroll-physics` |
| `autoplay` | boolean | false | `autoplay` |
| `autoplayInterval` | number (seconds) | 4.0 | `autoplay-interval` |
| `autoPlayAnimationDuration` | number (ms) | 800 | `auto-play-animation-duration` |
| `autoPlayCurve` | Curve | Curves.fastOutSlowIn | `auto-play-curve` |
| `pauseAutoPlayOnTouch` | boolean | true | `pause-auto-play-on-touch` |
| `pauseAutoPlayOnManualNavigate` | boolean | true | `pause-auto-play-on-manual-navigate` |
| `pauseAutoPlayInFiniteScroll` | boolean | false | `pause-auto-play-in-finite-scroll` |
| `enlargeCenterPage` | boolean | false | `enlarge-center-page` |
| `enlargeStrategy` | CenterPageEnlargeStrategy | scale | `enlarge-strategy` |
| `enlargeFactor` | number | 0.3 | `enlarge-factor` |
| `id` | string | - | `id` |
| `className` | string | - | `class` |
| `style` | React.CSSProperties | - | - |
| `children` | React.ReactNode | - | - |

Value notes:

- `scrollDirection`: use `Axis.horizontal` or `Axis.vertical` (strings like `horizontal` are also accepted).
- `autoPlayCurve`: use `Curve` enum values such as `Curves.fastOutSlowIn`.
- `enlargeStrategy`: `CenterPageEnlargeStrategy.scale`, `height`, or `zoom`.
- `scrollPhysics`: `clamping`, `bouncing`, or `fixed`.

### Event props

| Prop | DOM event | Detail |
| --- | --- | --- |
| `onChange` | `change` | `{ index, reason }` |
| `onSlidestart` | `slidestart` | - |
| `onSlideend` | `slideend` | - |
| `onPageanimationstart` | `pageanimationstart` | `{ from, to }` |
| `onPageanimationend` | `pageanimationend` | `{ index }` |
| `onAutoplaypause` | `autoplaypause` | - |
| `onAutoplayresume` | `autoplayresume` | - |
| `onScrolled` | `scrolled` | `number` |
| `onItemclick` | `itemclick` | `{ id }` |

If you need events not exposed as props (for example, `error`), attach a listener via `ref.current?.addEventListener(...)`.

## Ref methods

Use a ref to call imperative APIs on the element:

- `next()` - next page (fixed 300ms ease animation)
- `previous()` - previous page (fixed 300ms ease animation)
- `jumpToPage(page: number)` - jump without animation
- `pause()` / `resume()` - pause or resume autoplay
- `startAutoPlay()` / `stopAutoPlay()` - explicit autoplay control

## Build

```bash
npm run build
```

## Generated files

The following files are generated. Do not edit them manually:

- `src/index.ts`
- `src/types.ts`
