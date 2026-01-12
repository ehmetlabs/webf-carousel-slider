/**
 * WebF Carousel Slider
 *
 * Custom element: <webf-carousel-slider>
 * Flutter-backed carousel slider for WebF.
 */

/**
 * Reason for page change.
 */
export type CarouselChangeReason = 'autoplay' | 'drag' | 'api';

/**
 * Properties for <webf-carousel-slider>.
 */
interface CarouselSliderProperties {
  /**
   * Whether to autoplay.
   * Default: false
   */
  autoplay?: boolean;

  /**
   * Autoplay delay in milliseconds.
   * Default: 3000
   */
  autoplayDelay?: number;

  /**
   * Disable autoplay on interaction.
   * Default: false
   */
  autoplayDisableOnInteraction?: boolean;

  /**
   * Transition speed in milliseconds.
   * Default: 300
   */
  speed?: number;

  /**
   * Transition easing.
   * Supported: 'ease', 'linear', 'ease-in', 'ease-out', 'ease-in-out',
   * 'fast-out-slow-in', 'cubic-bezier(x1, y1, x2, y2)'.
   * Default: 'ease'
   */
  easing?: string;

  /**
   * Whether to loop infinitely.
   * Default: false
   */
  loop?: boolean;

  /**
   * Scroll direction.
   * Default: 'horizontal'
   */
  direction?: string;

  /**
   * Number of slides per view.
   * Default: 1
   */
  slidesPerView?: number;

  /**
   * Whether to center slides in view.
   * Default: false
   */
  centeredSlides?: boolean;

  /**
   * Initial slide index.
   * Default: 0
   */
  initialSlide?: number;

  /**
   * Whether to allow touch dragging.
   * Default: true
   */
  allowTouchMove?: boolean;

  /**
   * Current active index (read-only).
   */
  readonly activeIndex?: number;
}

/**
 * Methods for <webf-carousel-slider>.
 */
interface CarouselSliderMethods {
  /**
   * Slide to the next item.
   */
  slideNext(speed?: number): void;

  /**
   * Slide to the previous item.
   */
  slidePrev(speed?: number): void;

  /**
   * Slide to a specific index.
   */
  slideTo(index: number, speed?: number): void;

  /**
   * Start autoplay.
   */
  autoplayStart(): void;

  /**
   * Stop autoplay.
   */
  autoplayStop(): void;
}

/**
 * Events for <webf-carousel-slider>.
 */
interface CarouselSliderEvents {
  /**
   * Fired when the current slide changes.
   */
  change: CustomEvent<{
    index: number;
    previousIndex: number;
    reason: CarouselChangeReason;
  }>;

  /**
   * Fired when user starts dragging.
   */
  changestart: CustomEvent<{ index: number }>;

  /**
   * Fired when user ends dragging.
   */
  changeend: CustomEvent<{ index: number }>;

  /**
   * Fired when autoplay starts.
   */
  play: Event;

  /**
   * Fired when autoplay pauses.
   */
  pause: Event;
}

declare global {
  interface HTMLElementTagNameMap {
    'webf-carousel-slider': HTMLElement &
      CarouselSliderProperties &
      CarouselSliderMethods;
  }

  interface HTMLElement extends
    CarouselSliderProperties,
    CarouselSliderMethods {}
}

export {};
