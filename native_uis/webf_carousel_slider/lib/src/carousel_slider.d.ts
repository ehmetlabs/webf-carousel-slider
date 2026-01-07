/**
 * WebF Carousel Slider Component
 *
 * A high-performance carousel slider component built on carousel_slider_plus.
 * Provides smooth animations, autoplay support, and flexible customization options.
 */

/**
 * Properties for <carousel-slider>.
 */
interface CarouselSliderProperties {
  /**
   * Current page index (0-based).
   * Setting this value programmatically changes the current page.
   * @default 0
   */
  currentIndex?: number;

  /**
   * JSON string containing carousel options.
   * Use this to set multiple options at once.
   *
   * Example:
   * ```json
   * {
   *   "height": 400,
   *   "aspectRatio": 16/9,
   *   "viewportFraction": 0.8,
   *   "enableInfiniteScroll": true,
   *   "autoPlay": true,
   *   "autoPlayInterval": 3000,
   *   "enlargeCenterPage": true
   * }
   * ```
   */
  options?: string;

  /**
   * Enable autoplay.
   * @default false
   */
  autoplay: boolean;

  /**
   * Autoplay interval in seconds.
   * @default 3.0
   */
  autoplayInterval?: number;

  /**
   * Enable infinite scroll loop.
   * @default true
   */
  enableInfiniteScroll: boolean;

  /**
   * Aspect ratio for the carousel.
   * If set, height is calculated from width.
   * @default 0.0 (disabled)
   */
  aspectRatio?: number;

  /**
   * Enlarge the center page.
   * Creates a scaling effect for the center item.
   * @default false
   */
  enlargeCenterPage: boolean;

  /**
   * Fraction of viewport visible for each item.
   * Values between 0.0 and 1.0.
   * @default 1.0
   */
  viewportFraction?: number;

  /**
   * Auto play animation duration in milliseconds.
   * @default 800
   */
  autoPlayAnimationDuration?: number;

  /**
   * Auto play curve animation.
   * @default 'Curves.ease'
   */
  autoPlayCurve?: 'Curves.ease' | 'Curves.easeIn' | 'Curves.easeOut' | 'Curves.easeInOut' | 'Curves.fastOutSlowIn';

  /**
   * Initial page index on first load.
   * @default 0
   */
  initialPage?: number;

  /**
   * Reverse the carousel direction.
   * @default false
   */
  reverse: boolean;

  /**
   * Scroll direction.
   * @default 'Axis.horizontal'
   */
  scrollDirection?: 'Axis.horizontal' | 'Axis.vertical';

  /**
   * Add padding at start and end.
   * @default true
   */
  padEnds: boolean;

  /**
   * Fixed height for the carousel.
   * Set as string like "400" or "400.0".
   */
  height?: string;

  /**
   * Pause autoplay when user touches the carousel.
   * @default true
   */
  pauseAutoPlayOnTouch: boolean;

  /**
   * Pause autoplay when user navigates manually.
   * @default true
   */
  pauseAutoPlayOnManualNavigate: boolean;

  /**
   * Enable page snapping effect.
   * @default true
   */
  pageSnapping: boolean;

  /**
   * Scale factor for the center page when enlargeCenterPage is true.
   * Values between 0.0 and 1.0.
   * @default 0.3
   */
  enlargeFactor?: number;

  // ========== Methods ==========

  /**
   * Navigate to the next page.
   */
  next(): void;

  /**
   * Navigate to the previous page.
   */
  previous(): void;

  /**
   * Jump to a specific page without animation.
   * @param page - Page index to jump to (0-based)
   */
  jumpToPage(page: number): void;

  /**
   * Pause autoplay.
   */
  pause(): void;

  /**
   * Resume autoplay.
   */
  resume(): void;
}

/**
 * Events for <carousel-slider>.
 */
interface CarouselSliderEvents {
  /**
   * Fired when the carousel page changes.
   * Event detail contains the new index and change reason.
   *
   * Example:
   * ```javascript
   * carousel.addEventListener('change', (event) => {
   *   console.log('New index:', event.detail.index);
   *   console.log('Reason:', event.detail.reason);
   * });
   * ```
   */
  change: CustomEvent<{
    /** New page index (0-based) */
    index: number;
    /** Reason for the page change */
    reason: string;
  }>;

  /**
   * Fired when user starts sliding/dragging the carousel.
   */
  slidestart: Event;

  /**
   * Fired when user stops sliding/dragging the carousel.
   */
  slideend: Event;

  /**
   * Fired when a page animation starts.
   * Event detail contains from and to page indices.
   */
  pageanimationstart: CustomEvent<{
    /** Starting page index */
    from: number;
    /** Target page index */
    to: number;
  }>;

  /**
   * Fired when a page animation completes.
   * Event detail contains the current page index.
   */
  pageanimationend: CustomEvent<{
    /** Current page index */
    index: number;
  }>;

  /**
   * Fired when autoplay is paused.
   */
  autoplaypause: Event;

  /**
   * Fired when autoplay is resumed.
   */
  autoplayresume: Event;
}
