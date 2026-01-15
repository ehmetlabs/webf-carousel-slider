import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:webf_carousel_slider/src/carousel_slider.dart';
import 'package:webf_carousel_slider/src/carousel_slider_bindings_generated.dart';

void main() {
  group('WebFCarouselSlider API parity (JS-facing names)', () {
    test('exposes CarouselOptions-aligned properties', () {
      final keys = CarouselSliderBindings.carouselSliderProperties.keys.toSet();

      const expected = <String>{
        'height',
        'aspectRatio',
        'viewportFraction',
        'initialPage',
        'enableInfiniteScroll',
        'animateToClosest',
        'reverse',
        'autoPlay',
        'autoPlayInterval',
        'autoPlayAnimationDuration',
        'autoPlayCurve',
        'enlargeCenterPage',
        'onPageChanged',
        'onScrolled',
        'scrollPhysics',
        'pageSnapping',
        'scrollDirection',
        'pauseAutoPlayOnTouch',
        'pauseAutoPlayOnManualNavigate',
        'pauseAutoPlayInFiniteScroll',
        'pageViewKey',
        'enlargeStrategy',
        'enlargeFactor',
        'disableCenter',
        'padEnds',
        'clipBehavior',
        'realPage',
        'disableGesture',
      };

      for (final name in expected) {
        expect(keys.contains(name), isTrue, reason: 'missing $name');
      }

      const legacy = <String>{
        'autoplay',
        'autoplayDelay',
        'autoplayDisableOnInteraction',
        'speed',
        'easing',
        'loop',
        'direction',
        'slidesPerView',
        'centeredSlides',
        'initialSlide',
        'allowTouchMove',
        'activeIndex',
      };

      for (final name in legacy) {
        expect(keys.contains(name), isFalse,
            reason: 'legacy $name still exposed');
      }
    });

    test('exposes controller-aligned method names', () {
      final keys = WebFCarouselSlider.carouselMethods.keys.toSet();

      const expected = <String>{
        'nextPage',
        'previousPage',
        'jumpToPage',
        'animateToPage',
        'startAutoPlay',
        'stopAutoPlay',
      };

      for (final name in expected) {
        expect(keys.contains(name), isTrue, reason: 'missing $name');
      }

      const legacy = <String>{
        'slideNext',
        'slidePrev',
        'slideTo',
        'autoplayStart',
        'autoplayStop',
      };

      for (final name in legacy) {
        expect(keys.contains(name), isFalse,
            reason: 'legacy $name still exposed');
      }
    });
  });
}
