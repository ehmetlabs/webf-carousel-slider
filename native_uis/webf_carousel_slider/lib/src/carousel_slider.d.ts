/**
 * WebF Carousel Slider
 *
 * Custom element: <webf-carousel-slider>
 * Flutter-backed carousel slider for WebF.
 */

/**
 * Reason for page change.
 */
export type CarouselPageChangedReason = 'timed' | 'manual' | 'controller';

/**
 * Strategy for enlarging center page.
 */
export type CenterPageEnlargeStrategy = 'scale' | 'height' | 'zoom';

/**
 * Properties for <webf-carousel-slider>.
 */
interface CarouselSliderProperties {
  /**
   * Set carousel height. Overrides aspectRatio if provided.
   */
  height?: number;

  /**
   * Aspect ratio when height is not set.
   * Default: 16 / 9
   */
  aspectRatio?: number;

  /**
   * The fraction of the viewport that each page should occupy.
   * Default: 0.8 (carousel_slider_plus default)
   */
  viewportFraction?: number;

  /**
   * The initial page to show.
   * Default: 0
   */
  initialPage?: number;

  /**
   * Determines if carousel should loop infinitely.
   * Default: true
   */
  enableInfiniteScroll?: boolean;

  /**
   * Loop to the closest occurrence of requested page.
   * Default: true
   */
  animateToClosest?: boolean;

  /**
   * Reverse the order of items.
   * Default: false
   */
  reverse?: boolean;

  /**
   * Enables auto play.
   * Default: false
   */
  autoPlay?: boolean;

  /**
   * Frequency of slides in milliseconds.
   * Default: 4000
   */
  autoPlayInterval?: number;

  /**
   * Animation duration between pages in milliseconds.
   * Default: 800
   */
  autoPlayAnimationDuration?: number;

  /**
   * Animation curve name.
   * Default: 'fast-out-slow-in'
   */
  autoPlayCurve?: string;

  /**
   * Whether current page should be larger than side images.
   * Default: false
   */
  enlargeCenterPage?: boolean;

  /**
   * Called whenever the page in the center changes.
   */
  onPageChanged?: (index: number, reason: CarouselPageChangedReason) => void;

  /**
   * Called whenever the carousel is scrolled.
   */
  onScrolled?: (value: number | null) => void;

  /**
   * Scroll physics identifier.
   */
  scrollPhysics?: string;

  /**
   * Set to false to disable page snapping.
   * Default: true
   */
  pageSnapping?: boolean;

  /**
   * Axis along which the page view scrolls.
   * Default: 'horizontal'
   */
  scrollDirection?: 'horizontal' | 'vertical';

  /**
   * Pause auto play on touch.
   * Default: true
   */
  pauseAutoPlayOnTouch?: boolean;

  /**
   * Pause auto play on manual navigation.
   * Default: true
   */
  pauseAutoPlayOnManualNavigate?: boolean;

  /**
   * When finite scroll, decide whether auto play loops to first item.
   * Default: false
   */
  pauseAutoPlayInFiniteScroll?: boolean;

  /**
   * PageStorageKey identifier.
   */
  pageViewKey?: string;

  /**
   * Determine which method to enlarge the center page.
   * Default: 'scale'
   */
  enlargeStrategy?: 'scale' | 'height' | 'zoom';

  /**
   * How much the pages next to the center page will be scaled down.
   * Default: 0.3
   */
  enlargeFactor?: number;

  /**
   * Whether to disable the Center widget for each slide.
   * Default: false
   */
  disableCenter?: boolean;

  /**
   * Whether to add padding to both ends of the list.
   * Default: true
   */
  padEnds?: boolean;

  /**
   * Clip behavior name.
   * Default: 'hardEdge'
   */
  clipBehavior?: string;

  /**
   * Whether to disable touch gestures.
   * Default: false
   */
  disableGesture?: boolean;

  /**
   * Current real page index (read-only).
   */
  readonly realPage?: number;
}

/**
 * Methods for <webf-carousel-slider>.
 */
interface CarouselSliderMethods {
  /**
   * Animates to the next page.
   */
  nextPage(duration?: number, curve?: string): void;

  /**
   * Animates to the previous page.
   */
  previousPage(duration?: number, curve?: string): void;

  /**
   * Jumps to a specific page without animation.
   */
  jumpToPage(page: number): void;

  /**
   * Animates to a specific page.
   */
  animateToPage(page: number, duration?: number, curve?: string): void;

  /**
   * Starts auto play.
   */
  startAutoPlay(): void;

  /**
   * Stops auto play.
   */
  stopAutoPlay(): void;
}

/**
 * Events for <webf-carousel-slider>.
 */
interface CarouselSliderEvents {}

declare global {
  interface HTMLElementTagNameMap {
    'webf-carousel-slider': HTMLElement &
      CarouselSliderProperties &
      CarouselSliderMethods &
      CarouselSliderEvents;
  }

  interface HTMLElement extends
    CarouselSliderProperties,
    CarouselSliderMethods,
    CarouselSliderEvents {}
}

export {};
