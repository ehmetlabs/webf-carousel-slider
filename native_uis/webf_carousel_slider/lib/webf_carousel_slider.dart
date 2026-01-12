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
/// <webf-carousel-slider autoplay autoplay-delay="3000" speed="300" easing="ease-in-out" slides-per-view="1">
///   <img src="image1.jpg" />
///   <img src="image2.jpg" />
///   <img src="image3.jpg" />
/// </webf-carousel-slider>
///
/// // In JavaScript
/// const carousel = document.querySelector('webf-carousel-slider');
///
/// // Listen to changes
/// carousel.addEventListener('change', (event) => {
///   console.log('Current index:', event.detail.index);
/// });
///
/// // Control programmatically
/// carousel.slideNext();        // Next page
/// carousel.slidePrev();        // Previous page
/// carousel.slideTo(2);         // Slide to page 2
/// carousel.autoplayStop();     // Stop autoplay
/// carousel.autoplayStart();    // Start autoplay
/// ```
///
/// ## Features
///
/// - ✅ High-performance Flutter rendering
/// - ✅ Smooth animations and transitions
/// - ✅ Swiper-compatible API subset
/// - ✅ Autoplay with customizable delay
/// - ✅ Infinite scroll support
/// - ✅ Custom easing (cubic-bezier)
/// - ✅ Centered slides
/// - ✅ Vertical and horizontal scroll directions
/// - ✅ Programmatic control methods
/// - ✅ Event-driven API
/// - ✅ TypeScript definitions
library;

import 'package:webf/webf.dart';
import 'src/carousel_slider.dart';

export 'src/carousel_slider.dart';

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
}
