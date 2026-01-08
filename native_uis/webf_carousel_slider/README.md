# WebF Carousel Slider

A WebF Custom Element wrapper for [carousel_slider_plus](https://pub.dev/packages/carousel_slider_plus). Provides a high-performance hybrid UI carousel component with Flutter rendering and JavaScript API.

## Features

- ✅ **High-performance Flutter rendering** - Smooth 60fps animations
- ✅ **Autoplay support** - Customizable intervals and pause/resume control
- ✅ **Infinite scroll** - Seamless looping navigation
- ✅ **Responsive design** - Aspect ratio and viewport customization
- ✅ **Center enlargement** - Scale effect for center item
- ✅ **Multiple orientations** - Horizontal and vertical scroll
- ✅ **Programmatic control** - Methods for navigation and playback
- ✅ **Event-driven API** - Listen to page changes and animations
- ✅ **TypeScript definitions** - Full type safety for TypeScript projects
- ✅ **React/Vue support** - Generated components via WebF CLI

## Installation

### Flutter Package

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  webf_carousel_slider: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### JavaScript/TypeScript

After generating the JavaScript package with WebF CLI:

```bash
npm install @your-org/webf-carousel-slider-react
# or
npm install @your-org/webf-carousel-slider-vue
```

## Getting Started

### Flutter App Setup

1. **Install the component in your app's initialization:**

```dart
import 'package:webf_carousel_slider/webf_carousel_slider.dart';

void main() {
  // Initialize WebF
  WebFControllerManager.instance.initialize(
    WebFControllerManagerConfig(
      maxAliveInstances: 2,
      maxAttachedInstances: 1,
    ),
  );

  // Install carousel slider component
  installWebFCarouselSlider();

  runApp(MyApp());
}
```

2. **Use in your WebF widget:**

```dart
WebF(
  bundle: WebFBundle.fromUrl('assets/index.html'),
  // The carousel-slider custom element is now available
)
```

### HTML/JavaScript Usage

```html
<!DOCTYPE html>
<html>
<head>
  <title>Carousel Slider Demo</title>
  <style>
    carousel-slider {
      width: 100%;
      max-width: 800px;
      margin: 0 auto;
    }

    carousel-slider img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  </style>
</head>
<body>
  <carousel-slider
    autoplay="true"
    autoplay-interval="4"
    enable-infinite-scroll="true"
    aspect-ratio="16/9"
    viewport-fraction="0.8"
    enlarge-center-page="true"
  >
    <img src="https://via.placeholder.com/800x400/FF6B6B/FFFFFF?text=Slide+1" />
    <img src="https://via.placeholder.com/800x400/4ECDC4/FFFFFF?text=Slide+2" />
    <img src="https://via.placeholder.com/800x400/45B7D1/FFFFFF?text=Slide+3" />
    <img src="https://via.placeholder.com/800x400/96CEB4/FFFFFF?text=Slide+4" />
  </carousel-slider>

  <script>
    const carousel = document.querySelector('carousel-slider');

    // Listen to page changes
    carousel.addEventListener('change', (event) => {
      console.log('Current index:', event.detail.index);
      console.log('Reason:', event.detail.reason);
    });

    // Control programmatically
    document.getElementById('nextBtn').addEventListener('click', () => {
      carousel.next();
    });

    document.getElementById('prevBtn').addEventListener('click', () => {
      carousel.previous();
    });

    // Pause/Resume autoplay
    document.getElementById('pauseBtn').addEventListener('click', () => {
      carousel.pause();
    });

    document.getElementById('resumeBtn').addEventListener('click', () => {
      carousel.resume();
    });
  </script>
</body>
</html>
```

### React Example

```tsx
import { CarouselSlider } from '@your-org/webf-carousel-slider-react';

function App() {
  const handleChange = (event) => {
    console.log('Page changed to:', event.detail.index);
  };

  return (
    <div>
      <CarouselSlider
        autoplay={true}
        autoplayInterval={4}
        aspectRatio={16 / 9}
        viewportFraction={0.8}
        enlargeCenterPage={true}
        onChange={handleChange}
      >
        <img src="slide1.jpg" alt="Slide 1" />
        <img src="slide2.jpg" alt="Slide 2" />
        <img src="slide3.jpg" alt="Slide 3" />
      </CarouselSlider>
    </div>
  );
}
```

### Vue Example

```vue
<template>
  <div>
    <CarouselSlider
      :autoplay="true"
      :autoplay-interval="4"
      :aspect-ratio="16/9"
      :viewport-fraction="0.8"
      :enlarge-center-page="true"
      @change="handleChange"
    >
      <img src="slide1.jpg" alt="Slide 1" />
      <img src="slide2.jpg" alt="Slide 2" />
      <img src="slide3.jpg" alt="Slide 3" />
    </CarouselSlider>
  </div>
</template>

<script setup>
import { CarouselSlider } from '@your-org/webf-carousel-slider-vue';

const handleChange = (event) => {
  console.log('Page changed to:', event.detail.index);
};
</script>
```

## API Reference

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `autoplay` | `boolean` | `false` | Enable autoplay |
| `autoplayInterval` | `number` | `4.0` | Autoplay interval in seconds |
| `enableInfiniteScroll` | `boolean` | `true` | Enable infinite scroll loop |
| `aspectRatio` | `number` | `16/9` | Aspect ratio |
| `enlargeCenterPage` | `boolean` | `false` | Enlarge the center page |
| `viewportFraction` | `number` | `0.8` | Fraction of viewport visible (0.0-1.0) |
| `initialPage` | `number` | `0` | Initial page index |
| `reverse` | `boolean` | `false` | Reverse carousel direction |
| `scrollDirection` | `string` | `'horizontal'` | Scroll direction ('horizontal' or 'vertical') |
| `height` | `string` | - | Fixed height (e.g., "400") |
| `autoPlayAnimationDuration` | `number` | `800` | Animation duration in ms |
| `autoPlayCurve` | `string` | `'Curves.fastOutSlowIn'` | Animation curve |
| `currentIndex` | `number` | `0` | Current page index (read/write) |
| `options` | `string` | - | JSON string with all options |

### Events

| Event | Detail | Description |
|-------|--------|-------------|
| `change` | `{ index: number, reason: string }` | Fired when page changes |
| `pageAnimationStart` | - | Fired when animation starts |
| `pageAnimationEnd` | - | Fired when animation completes |

### Methods

| Method | Parameters | Description |
|--------|-----------|-------------|
| `next()` | - | Navigate to next page |
| `previous()` | - | Navigate to previous page |
| `jumpToPage(page)` | `page: number` | Jump to specific page |
| `pause()` | - | Pause autoplay |
| `resume()` | - | Resume autoplay |

## Advanced Usage

### Dynamic Options

```javascript
const carousel = document.querySelector('carousel-slider');

// Set multiple options at once via JSON
carousel.options = JSON.stringify({
  height: 400,
  aspectRatio: 16 / 9,
  viewportFraction: 0.8,
  autoPlay: true,
  autoPlayInterval: 4.0,
  enlargeCenterPage: true,
});
```

### Custom Styling

```css
carousel-slider {
  width: 100%;
  max-width: 1200px;
  margin: 20px auto;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

carousel-slider img {
  border-radius: 8px;
}
```

### Integration with State Management

```javascript
import { useState, useEffect } from 'react';

function GalleryApp() {
  const [currentIndex, setCurrentIndex] = useState(0);
  const carouselRef = useRef(null);

  useEffect(() => {
    const carousel = carouselRef.current;

    const handleChange = (e) => {
      setCurrentIndex(e.detail.index);
    };

    carousel.addEventListener('change', handleChange);
    return () => carousel.removeEventListener('change', handleChange);
  }, []);

  return (
    <div>
      <CarouselSlider ref={carouselRef} autoplay={true}>
        {images.map((img) => (
          <img key={img.id} src={img.url} alt={img.alt} />
        ))}
      </CarouselSlider>
      <p>Current slide: {currentIndex + 1}</p>
    </div>
  );
}
```

## Code Generation

To generate React/Vue components from this package:

```bash
# Install WebF CLI
npm install -g @openwebf/webf-cli

# Generate React package
webf codegen webf-carousel-slider-react \
  --flutter-package-src=./native_uis/webf_carousel_slider \
  --framework=react

# Generate Vue package
webf codegen webf-carousel-slider-vue \
  --flutter-package-src=./native_uis/webf_carousel_slider \
  --framework=vue

# Publish to npm (optional)
webf codegen webf-carousel-slider-react \
  --flutter-package-src=./native_uis/webf_carousel_slider \
  --framework=react \
  --publish-to-npm
```

## Architecture

This package follows the WebF Hybrid UI architecture:

```
┌─────────────────────────────────────┐
│  JavaScript/TypeScript (React/Vue)  │  ← Generated by CLI
│  @your-org/webf-carousel-slider     │
├─────────────────────────────────────┤
│  TypeScript Definitions (.d.ts)     │  ← Type definitions
│  Carousel slider interfaces         │
├─────────────────────────────────────┤
│  Dart (Flutter)                     │  ← This package
│  CarouselSliderElement wrapper      │
└─────────────────────────────────────┘
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with [WebF](https://openwebf.com/)
- Based on [carousel_slider_plus](https://pub.dev/packages/carousel_slider_plus)
- Follows [WebF Hybrid UI Development Guide](https://github.com/openwebf/webf/tree/main/.claude/skills/webf-hybrid-ui-dev)
