# WebF Carousel Slider

A WebF carousel custom element implemented in Flutter, with a React wrapper for JavaScript/TypeScript usage inside WebF.

## Repository layout

- `native_uis/webf_carousel_slider`: Flutter package that registers the `<webf-carousel-slider>` custom element.
- `packages/webf-react-carousel-slider`: React wrapper package published as `@ehmetlabs/webf-react-carousel-slider`.

## Features

- Flutter-rendered carousel with smooth animations
- Autoplay, pause/resume, infinite scroll
- Centered slides, vertical/horizontal modes
- Swiper-compatible subset of JavaScript methods and custom events
- Typed React wrapper for WebF projects

## Documentation

- Flutter custom element: `native_uis/webf_carousel_slider/README.md`
- React wrapper: `packages/webf-react-carousel-slider/README.md`

## Build and test

- Flutter dependencies + tests:
  ```bash
  cd native_uis/webf_carousel_slider
  flutter pub get
  flutter test
  ```
- React wrapper build:
  ```bash
  cd packages/webf-react-carousel-slider
  npm install
  npm run build
  ```

## Code generation

Generated files should not be edited directly:

- `native_uis/webf_carousel_slider/lib/src/carousel_slider_bindings_generated.dart`
- `packages/webf-react-carousel-slider/src/index.ts`
- `packages/webf-react-carousel-slider/src/types.ts`

Regenerate via WebF CLI (adjust arguments as needed):

```bash
webf codegen ... --flutter-package-src=./native_uis/webf_carousel_slider
```

## License

MIT. See `LICENSE`.
