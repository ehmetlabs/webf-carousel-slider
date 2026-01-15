/// WebF Carousel Slider
/// ================
///
/// A WebF Custom Element wrapper for carousel_slider_plus.
/// Provides hybrid UI carousel component with Flutter performance and JavaScript API.
///
/// ## Usage
///
/// ### In Flutter App
///
/// ```dart
/// import 'package:webf_carousel_slider/webf_carousel_slider.dart';
///
/// void main() {
///   // Initialize WebF
///   WebFControllerManager.instance.initialize(
///     WebFControllerManagerConfig(
///       maxAliveInstances: 2,
///       maxAttachedInstances: 1,
///     ),
///   );
///
///   // Install carousel slider component
///   installWebFCarouselSlider();
///
///   runApp(MyApp());
/// }
/// ```
///
/// ### In JavaScript/TypeScript
///
/// ```javascript
/// // Add to HTML
/// <webf-carousel-slider auto-play auto-play-interval="3000" auto-play-animation-duration="300" enable-infinite-scroll>
///   <webf-carousel-slider-item image-url="image1.jpg"></webf-carousel-slider-item>
///   <webf-carousel-slider-item image-url="image2.jpg"></webf-carousel-slider-item>
///   <webf-carousel-slider-item image-url="image3.jpg"></webf-carousel-slider-item>
/// </webf-carousel-slider>
///
/// // In JavaScript
/// const carousel = document.querySelector('webf-carousel-slider');
///
/// // Listen to changes
/// carousel.onPageChanged = (index, reason) => {
///   console.log('Current index:', index, 'reason:', reason);
/// };
///
/// // Control programmatically
/// carousel.nextPage();         // Next page
/// carousel.previousPage();     // Previous page
/// carousel.jumpToPage(2);      // Jump to page 2
/// carousel.stopAutoPlay();     // Stop autoplay
/// carousel.startAutoPlay();    // Start autoplay
/// ```
///
/// ## Features
///
/// - ✅ High-performance Flutter rendering
/// - ✅ Smooth animations and transitions
/// - ✅ carousel_slider_plus API naming parity
/// - ✅ Autoplay with configurable interval/duration
/// - ✅ Infinite scroll support
/// - ✅ Curve mapping (including cubic-bezier)
/// - ✅ Center page enlarge strategies
/// - ✅ Vertical and horizontal scroll directions
/// - ✅ Programmatic control methods
/// - ✅ Callback-driven API (onPageChanged/onScrolled)
/// - ✅ TypeScript definitions
library;

import 'package:webf/webf.dart';
import 'src/carousel_slider.dart';
import 'src/carousel_slider_item.dart';

export 'src/carousel_slider.dart';
export 'src/carousel_slider_item.dart';

/// Install the WebF Carousel Slider custom element.
///
/// Call this function in your app's initialization before
/// rendering any carousel components.
///
/// Example:
/// ```dart
/// void main() {
///   installWebFCarouselSlider();
///   runApp(MyApp());
/// }
/// ```
void installWebFCarouselSlider() {
  // Register the custom element with WebF
  WebF.defineCustomElement('webf-carousel-slider', (context) {
    return WebFCarouselSlider(context);
  });
  WebF.defineCustomElement('webf-carousel-slider-item', (context) {
    return WebFCarouselSliderItem(context);
  });

  // Backward compatibility for generated React/Vue wrappers.
  WebF.defineCustomElement('carousel-slider', (context) {
    return WebFCarouselSlider(context);
  });
  WebF.defineCustomElement('carousel-slider-item', (context) {
    return WebFCarouselSliderItem(context);
  });
}
