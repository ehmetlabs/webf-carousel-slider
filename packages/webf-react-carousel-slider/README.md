# WebF React Carousel Slider

React wrapper for the WebF `<webf-carousel-slider>` custom element. It is intended for WebF environments where the Flutter custom element is registered.

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
import { CarouselSlider, CarouselSliderElement } from '@ehmetlabs/webf-react-carousel-slider';

export function App() {
  const ref = useRef<CarouselSliderElement>(null);

  return (
    <CarouselSlider
      ref={ref}
      autoplay
      autoplayDelay={3000}
      speed={300}
      loop
      direction="horizontal"
      slidesPerView={1}
      centeredSlides
      allowTouchMove
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

## Props

This React wrapper keeps a Swiper-compatible subset of props.

All props map to kebab-case attributes on `<webf-carousel-slider>` unless noted.

| Prop | Type | Default | Attribute |
| --- | --- | --- | --- |
| `autoplay` | boolean | false | `autoplay` |
| `autoplayDelay` | number (ms) | 3000 | `autoplay-delay` |
| `autoplayDisableOnInteraction` | boolean | false | `autoplay-disable-on-interaction` |
| `speed` | number (ms) | 300 | `speed` |
| `loop` | boolean | false | `loop` |
| `direction` | string | `horizontal` | `direction` |
| `slidesPerView` | number | 1 | `slides-per-view` |
| `centeredSlides` | boolean | false | `centered-slides` |
| `initialSlide` | number | 0 | `initial-slide` |
| `allowTouchMove` | boolean | true | `allow-touch-move` |
| `id` | string | - | `id` |
| `className` | string | - | `class` |
| `style` | React.CSSProperties | - | - |
| `children` | React.ReactNode | - | - |

Value notes:

- `direction`: `horizontal` or `vertical`.

### Event props

| Prop | DOM event | Detail |
| --- | --- | --- |
| `onChange` | `change` | `{ index, previousIndex, reason }` |
| `onChangestart` | `changestart` | `{ index }` |
| `onChangeend` | `changeend` | `{ index }` |
| `onPlay` | `play` | - |
| `onPause` | `pause` | - |

If you need events not exposed as props, attach a listener via `ref.current?.addEventListener(...)`.

## Ref methods

Use a ref to call imperative APIs on the element:

- `slideNext(speed?: number)` - next page
- `slidePrev(speed?: number)` - previous page
- `slideTo(index: number, speed?: number)` - slide to index
- `autoplayStart()` - start autoplay
- `autoplayStop()` - stop autoplay

## WebF async rendering note

WebF layout is asynchronous. If you need to read layout information, wait for
the `onscreen` event or use `useFlutterAttached` from `@openwebf/react-core-ui`
before calling measurement APIs.

## Build

```bash
npm run build
```

## Generated files

The following files are generated. Do not edit them manually:

- `src/index.ts`
- `src/types.ts`
