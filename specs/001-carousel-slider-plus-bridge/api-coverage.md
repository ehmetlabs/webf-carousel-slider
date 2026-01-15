# API Coverage: carousel_slider_plus v7.1.1 -> WebF JS Bridge

Authoritative sources:
- https://pub.dev/documentation/carousel_slider_plus/7.1.1/
- https://github.com/kishan-dhankecha/carousel_slider_plus/tree/v7.1.1

This document maps carousel_slider_plus public APIs to the current WebF JS bridge
exposure and records gaps. It is a parity checklist for FR-001/FR-002/FR-003.

## Legend
- JS Exposure: current JS-facing name in WebF (.d.ts / element API)
- Status: exposed | partial | missing | mismatch
- Notes: payload/typing or semantic differences

## CarouselSlider (constructors)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| CarouselSlider(...) | constructor | <webf-carousel-slider> element | partial | No direct constructor; element + attributes map to options. |
| CarouselSlider.builder(...) | constructor | N/A | missing | No JS builder API exposed. |

## CarouselOptions (properties)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| height | double? | N/A | missing | No height attribute in JS. |
| aspectRatio | double | N/A | missing | No aspectRatio attribute in JS. |
| viewportFraction | double | slidesPerView | mismatch | slidesPerView is not viewportFraction; mapping needed. |
| initialPage | int | initialSlide | mismatch | Naming differs. |
| enableInfiniteScroll | bool | loop | mismatch | Naming differs. |
| animateToClosest | bool | N/A | missing | Not exposed in JS. |
| reverse | bool | N/A | missing | Not exposed in JS. |
| autoPlay | bool | autoplay | mismatch | Naming differs (autoPlay vs autoplay). |
| autoPlayInterval | Duration | autoplayDelay | mismatch | unit uses Duration vs ms; ensure mapping. |
| autoPlayAnimationDuration | Duration | speed | mismatch | speed is ms; ensure mapping. |
| autoPlayCurve | Curve | easing | mismatch | easing string vs Curve; mapping needed. |
| enlargeCenterPage | bool | centeredSlides | mismatch | centeredSlides semantics differ; verify. |
| onPageChanged | callback | change event | partial | JS uses CustomEvent with {index, previousIndex, reason}. |
| onScrolled | ValueChanged<double?> | N/A | missing | No JS event/callback. |
| scrollPhysics | ScrollPhysics? | N/A | missing | Not exposed in JS. |
| pageSnapping | bool | N/A | missing | Not exposed in JS. |
| scrollDirection | Axis | direction | mismatch | direction string vs Axis. |
| pauseAutoPlayOnTouch | bool | autoplayDisableOnInteraction | mismatch | Naming differs; ensure semantics. |
| pauseAutoPlayOnManualNavigate | bool | N/A | missing | Not exposed in JS. |
| pauseAutoPlayInFiniteScroll | bool | N/A | missing | Not exposed in JS. |
| pageViewKey | PageStorageKey? | N/A | missing | Not exposed in JS. |
| enlargeStrategy | CenterPageEnlargeStrategy | N/A | missing | Not exposed in JS. |
| enlargeFactor | double | N/A | missing | Not exposed in JS. |
| disableCenter | bool | N/A | missing | Not exposed in JS. |
| padEnds | bool | N/A | missing | Not exposed in JS. |
| clipBehavior | Clip | N/A | missing | Not exposed in JS. |

## CarouselSliderController (methods)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| nextPage({duration, curve}) | method | slideNext(speed?) | partial | speed maps to duration ms; curve not exposed. |
| previousPage({duration, curve}) | method | slidePrev(speed?) | partial | speed maps to duration ms; curve not exposed. |
| jumpToPage(int page) | method | slideTo(index, speed?) | partial | slideTo uses optional speed; jump vs animate not distinguished. |
| animateToPage(int page, {duration, curve}) | method | slideTo(index, speed?) | partial | curve not exposed. |
| startAutoPlay() | method | autoplayStart() | mismatch | Naming differs. |
| stopAutoPlay() | method | autoplayStop() | mismatch | Naming differs. |

## CarouselState (public)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| CarouselState(...) | class | N/A | missing | Internal state not exposed. |
| properties/methods | class members | N/A | missing | No JS exposure. |

## Helpers

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| ConditionalParentWidget | class | N/A | missing | Flutter-only helper. |

## Enums

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| CarouselPageChangedReason (timed/manual/controller) | enum | CarouselChangeReason ('autoplay'|'drag'|'api') | mismatch | Value names differ; mapping needed. |
| CenterPageEnlargeStrategy (scale/height/zoom) | enum | N/A | missing | Not exposed in JS. |

## Typedefs

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| ExtendedIndexedWidgetBuilder | typedef | N/A | missing | No JS builder API. |

## Utils

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| getRealIndex(...) | function | N/A | missing | Not exposed in JS. |
| remainder(...) | function | N/A | missing | Not exposed in JS. |

## JS Events (current)

| JS Event | Payload | Source API | Status | Notes |
| --- | --- | --- | --- | --- |
| change | { index, previousIndex, reason } | onPageChanged | partial | reason values differ from CarouselPageChangedReason. |
| changestart | { index } | N/A | missing | No source API equivalent. |
| changeend | { index } | N/A | missing | No source API equivalent. |
| play | Event | startAutoPlay | partial | Existence OK; payload differs (none). |
| pause | Event | stopAutoPlay | partial | Existence OK; payload differs (none). |

## JS Element Properties/Methods (current)

| JS Exposure | Type | Source API | Status | Notes |
| --- | --- | --- | --- | --- |
| autoplay | boolean | autoPlay | mismatch | Naming differs. |
| autoplayDelay | number (ms) | autoPlayInterval | mismatch | Duration vs ms. |
| autoplayDisableOnInteraction | boolean | pauseAutoPlayOnTouch | mismatch | Naming differs. |
| speed | number (ms) | autoPlayAnimationDuration | mismatch | Duration vs ms; also used by slide methods. |
| easing | string | autoPlayCurve | mismatch | Curve vs string. |
| loop | boolean | enableInfiniteScroll | mismatch | Naming differs. |
| direction | string | scrollDirection | mismatch | Axis vs string. |
| slidesPerView | number | viewportFraction | mismatch | Semantics differ; mapping required. |
| centeredSlides | boolean | enlargeCenterPage | mismatch | Semantics differ. |
| initialSlide | number | initialPage | mismatch | Naming differs. |
| allowTouchMove | boolean | disableGesture | mismatch | Inverse naming/logic. |
| activeIndex (readonly) | number | CarouselState.realPage | partial | Needs mapping to real/current index. |
| slideNext(speed?) | method | nextPage | partial | Curve not exposed. |
| slidePrev(speed?) | method | previousPage | partial | Curve not exposed. |
| slideTo(index, speed?) | method | jumpToPage/animateToPage | partial | Jump vs animate not distinguished. |
| autoplayStart() | method | startAutoPlay | mismatch | Naming differs. |
| autoplayStop() | method | stopAutoPlay | mismatch | Naming differs. |

## Notes
- This document intentionally records mismatches without proposing conversions, per FR-003.
- Use it as the canonical checklist for API parity work and tests.

## Verification Steps (per API)

### CarouselSlider constructors
- `CarouselSlider(...)`: 用 `<webf-carousel-slider>` 创建元素并渲染，确认可正常显示。
- `CarouselSlider.builder(...)`: 通过 DOM 子元素模式提供 items，确认 builder 等效渲染。

### CarouselOptions properties
- `height`: 设置元素高度样式/属性后确认 CarouselOptions.height 生效。
- `aspectRatio`: 设置 `aspectRatio` 并确认渲染比例变化。
- `viewportFraction`: 设置 `viewportFraction` 并确认每页宽度比例变化。
- `initialPage`: 设置 `initialPage` 并确认初始索引。
- `enableInfiniteScroll`: 设置 `enableInfiniteScroll` 并确认循环行为。
- `animateToClosest`: 设置 `animateToClosest` 并验证动画选择最近页。
- `reverse`: 设置 `reverse` 并确认滚动方向反转。
- `autoPlay`: 设置 `autoPlay` 并确认自动播放启动/停止。
- `autoPlayInterval`: 设置 `autoPlayInterval` 并确认播放间隔变化。
- `autoPlayAnimationDuration`: 设置 `autoPlayAnimationDuration` 并确认动画时长变化。
- `autoPlayCurve`: 设置 `autoPlayCurve` 并确认动画曲线变化。
- `enlargeCenterPage`: 设置 `enlargeCenterPage` 并确认中心页放大。
- `onPageChanged`: 监听回调，触发翻页并验证 index/reason。
- `onScrolled`: 触发滚动并验证回调参数。
- `scrollPhysics`: 设置 `scrollPhysics` 并确认滚动物理行为变化。
- `pageSnapping`: 设置 `pageSnapping` 并确认吸附行为。
- `scrollDirection`: 设置 `scrollDirection` 并确认横/纵滚动。
- `pauseAutoPlayOnTouch`: 触摸交互时验证自动播放暂停/恢复。
- `pauseAutoPlayOnManualNavigate`: 调用控制器方法时验证自动播放暂停/恢复。
- `pauseAutoPlayInFiniteScroll`: 有限滚动末尾验证自动播放行为。
- `pageViewKey`: 设置 `pageViewKey` 并验证状态保持。
- `enlargeStrategy`: 设置 `enlargeStrategy` 并验证缩放策略。
- `enlargeFactor`: 设置 `enlargeFactor` 并验证缩放比例。
- `disableCenter`: 设置 `disableCenter` 并验证 Center 包裹行为。
- `padEnds`: 设置 `padEnds` 并验证两端 padding。
- `clipBehavior`: 设置 `clipBehavior` 并验证裁剪行为。

### CarouselSliderController methods
- `nextPage`: 调用并确认向后翻页与动画参数。
- `previousPage`: 调用并确认向前翻页与动画参数。
- `jumpToPage`: 调用并确认无动画跳转。
- `animateToPage`: 调用并确认带动画跳转。
- `startAutoPlay`: 调用并确认自动播放启动。
- `stopAutoPlay`: 调用并确认自动播放停止。

### CarouselState (public)
- `CarouselState`: 暴露后验证可读取 `realPage` 等状态字段。

### Helpers
- `ConditionalParentWidget`: Flutter 端存在性验证（无需 JS 暴露）。

### Enums
- `CarouselPageChangedReason`: 触发翻页并验证 reason 为 `timed/manual/controller`。
- `CenterPageEnlargeStrategy`: 设置并验证 `scale/height/zoom` 行为。

### Typedefs
- `ExtendedIndexedWidgetBuilder`: DOM 子元素模式替代，验证 item 生成与 realIndex 语义。

### Utils
- `getRealIndex`: 调用并验证返回值与官方实现一致。
- `remainder`: 调用并验证返回值与官方实现一致。

### JS Events (current)
- `change/changestart/changeend/play/pause`: 若被移除，确认不再对外暴露。
