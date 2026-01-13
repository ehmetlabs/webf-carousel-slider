/**
 * WebF Carousel Slider Item
 *
 * Custom element: <webf-carousel-slider-item>
 */

/**
 * Properties for <webf-carousel-slider-item>.
 */
interface CarouselSliderItemProperties {
  /**
   * Image source URL.
   */
  imageUrl?: string;
}

declare global {
  interface HTMLElementTagNameMap {
    'webf-carousel-slider-item': HTMLElement & CarouselSliderItemProperties;
  }

  interface HTMLElement extends CarouselSliderItemProperties {}
}

export {};
