# JS API Parity Spec (Strict Original Names)

Target: `carousel_slider_plus` v7.1.1 public API names and semantics.
Strict mode: JS bridge MUST expose original names without renaming.

Authoritative sources:
- https://pub.dev/documentation/carousel_slider_plus/7.1.1/
- https://github.com/kishan-dhankecha/carousel_slider_plus/tree/v7.1.1

## 1) Custom Elements

- `<webf-carousel-slider>`
- `<webf-carousel-slider-item>`

## 2) CarouselSlider API (JS-facing)

### 2.1 Constructors (JS entry)

Because JS uses custom elements, constructors are represented as element usage:
- `CarouselSlider(...)` -> `<webf-carousel-slider>` element
- `CarouselSlider.builder(...)` -> MUST be exposed via template/slot/DOM child elements (no JS itemBuilder function)

### 2.2 Properties (mirror CarouselOptions)

All fields MUST keep original names:

- `height?: number`
- `aspectRatio?: number`
- `viewportFraction?: number`
- `initialPage?: number`
- `enableInfiniteScroll?: boolean`
- `animateToClosest?: boolean`
- `reverse?: boolean`
- `autoPlay?: boolean`
- `autoPlayInterval?: number` (milliseconds)
- `autoPlayAnimationDuration?: number` (milliseconds)
- `autoPlayCurve?: string` (curve name or CSS-like mapping; must preserve semantics)
- `enlargeCenterPage?: boolean`
- `onPageChanged?: (index: number, reason: CarouselPageChangedReason) => void`
- `onScrolled?: (value: number | null) => void`
- `scrollPhysics?: string`
- `pageSnapping?: boolean`
- `scrollDirection?: 'horizontal' | 'vertical'`
- `pauseAutoPlayOnTouch?: boolean`
- `pauseAutoPlayOnManualNavigate?: boolean`
- `pauseAutoPlayInFiniteScroll?: boolean`
- `pageViewKey?: string`
- `enlargeStrategy?: CenterPageEnlargeStrategy`
- `enlargeFactor?: number`
- `disableCenter?: boolean`
- `padEnds?: boolean`
- `clipBehavior?: string`

Notes:
- Any JS type mapping MUST preserve original semantics; no renaming.
- Where Flutter types do not map 1:1 (Curve/ScrollPhysics/PageStorageKey/Clip), use string identifiers but do not rename the property.

### 2.3 Methods (mirror CarouselSliderController)

- `nextPage(duration?: number, curve?: string): void`
- `previousPage(duration?: number, curve?: string): void`
- `jumpToPage(page: number): void`
- `animateToPage(page: number, duration?: number, curve?: string): void`
- `startAutoPlay(): void`
- `stopAutoPlay(): void`

### 2.4 Read-only state

- `realPage?: number` (maps from CarouselState.realPage)

## 3) Enums (JS-facing)

- `CarouselPageChangedReason = 'timed' | 'manual' | 'controller'`
- `CenterPageEnlargeStrategy = 'scale' | 'height' | 'zoom'`

## 4) Events (JS-facing)

### 4.1 onPageChanged

Expose as callback property only:

- `onPageChanged(index: number, reason: CarouselPageChangedReason): void`

### 4.2 onScrolled

Expose as callback property only:

- `onScrolled(value: number | null): void`

## 5) CarouselSliderItem API (JS-facing)

- `imageUrl?: string`

## 6) Builder API (JS-facing)

Strict parity requires exposing a builder concept using template/slot/DOM child elements (no JS itemBuilder function). Proposed contract:

- Children are `webf-carousel-slider-item` nodes or any custom child elements
- `itemCount`/`itemBuilder` are NOT exposed in JS
- The DOM child list is the source of items, mirroring builder behavior via DOM

## 7) Utilities (Optional JS exposure)

If strictly exposing all public API, provide JS functions:
- `getRealIndex(position: number, base: number, length?: number): number`
- `remainder(input: number, source?: number): number`

## 8) Removal/Breaking Notes

Strict original names supersede existing JS API names. Legacy JS API MUST be removed.

### 8.1 Legacy JS API to remove/rename

Properties (legacy -> strict original):
- `autoplay` -> `autoPlay`
- `autoplayDelay` -> `autoPlayInterval`
- `autoplayDisableOnInteraction` -> `pauseAutoPlayOnTouch`
- `speed` -> `autoPlayAnimationDuration`
- `easing` -> `autoPlayCurve`
- `loop` -> `enableInfiniteScroll`
- `direction` -> `scrollDirection`
- `slidesPerView` -> `viewportFraction`
- `centeredSlides` -> `enlargeCenterPage`
- `initialSlide` -> `initialPage`
- `allowTouchMove` -> `disableGesture` (note inverse semantics)
- `activeIndex` -> `realPage`

Methods (legacy -> strict original):
- `slideNext` -> `nextPage`
- `slidePrev` -> `previousPage`
- `slideTo` -> `jumpToPage` / `animateToPage` (split)
- `autoplayStart` -> `startAutoPlay`
- `autoplayStop` -> `stopAutoPlay`

Events (legacy -> strict original):
- `change` -> `pageChanged` (payload must match onPageChanged signature)
- `changestart` -> N/A (no source API)
- `changeend` -> N/A (no source API)
- `play` -> N/A (only callback startAutoPlay)
- `pause` -> N/A (only callback stopAutoPlay)

## 9) Non-goals

- No extra wrapping or semantic conversion beyond type coercion required to
  bridge JS to Flutter.
