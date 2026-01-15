# WebF Carousel Slider (Vue typings)

Type declarations for the WebF custom element backed by `carousel_slider_plus`.
It exposes `<webf-carousel-slider>` with strict original API names and renders via Flutter.

## Requirements

- Flutter >= 3.16.0
- Dart >= 3.0.0
- webf ^0.24.2
- carousel_slider_plus ^7.1.1

## Installation

```bash
npm install @ehmetlabs/webf-vue-carousel-slider
```

## Vue usage

```vue
<template>
  <webf-carousel-slider
    auto-play
    auto-play-interval="3000"
    auto-play-animation-duration="300"
    enable-infinite-scroll
  >
    <webf-carousel-slider-item image-url="https://example.com/slide-1.jpg" />
    <webf-carousel-slider-item image-url="https://example.com/slide-2.jpg" />
  </webf-carousel-slider>
</template>

<script setup lang="ts">
const onPageChanged = (index: number, reason: 'timed' | 'manual' | 'controller') => {
  console.log(index, reason);
};
</script>
```

## API reference

Props and methods mirror `carousel_slider_plus` naming and semantics. See
`native_uis/webf_carousel_slider/README.md` for the complete API list,
attribute names, and legacy name removals.
