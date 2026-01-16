# WebF Carousel Slider (React)

React wrapper for the WebF custom element backed by `carousel_slider_plus`.
It exposes `<webf-carousel-slider>` with strict original API names and renders via Flutter.

## Requirements

- Flutter >= 3.16.0
- Dart >= 3.0.0
- webf ^0.24.2
- carousel_slider_plus ^7.1.1

## Installation

```bash
npm install @ehmetlabs/webf-react-carousel-slider
```

## React usage

```tsx
import { CarouselSlider, CarouselSliderItem } from '@ehmetlabs/webf-react-carousel-slider';

export function App() {
  return (
    <CarouselSlider
      style={{ height: 220 }}
      autoPlay
      autoPlayInterval={3000}
      autoPlayAnimationDuration={300}
      enableInfiniteScroll
      onPageChanged={(index, reason) => {
        console.log(index, reason);
      }}
    >
      <CarouselSliderItem imageUrl="https://example.com/slide-1.jpg" />
      <CarouselSliderItem imageUrl="https://example.com/slide-2.jpg" />
    </CarouselSlider>
  );
}
```

The generated React wrapper renders a `<carousel-slider>` custom element.
Ensure the element has an explicit height via `style` or CSS.

## API reference

Props and methods mirror `carousel_slider_plus` naming and semantics. See
`native_uis/webf_carousel_slider/README.md` for the complete API list,
attribute names, and legacy name removals.
