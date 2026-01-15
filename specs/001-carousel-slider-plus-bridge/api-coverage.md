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
| CarouselSlider(...) | constructor | <webf-carousel-slider> element | exposed | Element + properties map to CarouselOptions. |
| CarouselSlider.builder(...) | constructor | DOM child elements | exposed | Use DOM children as items to mirror builder behavior. |

## CarouselOptions (properties)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| height | double? | height | exposed | number → double. |
| aspectRatio | double | aspectRatio | exposed | number → double. |
| viewportFraction | double | viewportFraction | exposed | number → double. |
| initialPage | int | initialPage | exposed | number → int. |
| enableInfiniteScroll | bool | enableInfiniteScroll | exposed | boolean. |
| animateToClosest | bool | animateToClosest | exposed | boolean. |
| reverse | bool | reverse | exposed | boolean. |
| autoPlay | bool | autoPlay | exposed | boolean. |
| autoPlayInterval | Duration | autoPlayInterval | exposed | milliseconds number. |
| autoPlayAnimationDuration | Duration | autoPlayAnimationDuration | exposed | milliseconds number. |
| autoPlayCurve | Curve | autoPlayCurve | exposed | curve name string. |
| enlargeCenterPage | bool | enlargeCenterPage | exposed | boolean. |
| onPageChanged | callback | onPageChanged | exposed | callback property only. |
| onScrolled | ValueChanged<double?> | onScrolled | exposed | callback property only. |
| scrollPhysics | ScrollPhysics? | scrollPhysics | exposed | string identifier. |
| pageSnapping | bool | pageSnapping | exposed | boolean. |
| scrollDirection | Axis | scrollDirection | exposed | `horizontal` \| `vertical`. |
| pauseAutoPlayOnTouch | bool | pauseAutoPlayOnTouch | exposed | boolean. |
| pauseAutoPlayOnManualNavigate | bool | pauseAutoPlayOnManualNavigate | exposed | boolean. |
| pauseAutoPlayInFiniteScroll | bool | pauseAutoPlayInFiniteScroll | exposed | boolean. |
| pageViewKey | PageStorageKey? | pageViewKey | exposed | string identifier. |
| enlargeStrategy | CenterPageEnlargeStrategy | enlargeStrategy | exposed | enum string. |
| enlargeFactor | double | enlargeFactor | exposed | number → double. |
| disableCenter | bool | disableCenter | exposed | boolean. |
| padEnds | bool | padEnds | exposed | boolean. |
| clipBehavior | Clip | clipBehavior | exposed | string identifier. |

## CarouselSlider (widget properties)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| disableGesture | bool | disableGesture | exposed | boolean. |

## CarouselSliderController (methods)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| nextPage({duration, curve}) | method | nextPage(duration?, curve?) | exposed | duration in ms; curve name string. |
| previousPage({duration, curve}) | method | previousPage(duration?, curve?) | exposed | duration in ms; curve name string. |
| jumpToPage(int page) | method | jumpToPage(page) | exposed | direct jump without animation. |
| animateToPage(int page, {duration, curve}) | method | animateToPage(page, duration?, curve?) | exposed | duration in ms; curve name string. |
| startAutoPlay() | method | startAutoPlay() | exposed | starts autoplay timer. |
| stopAutoPlay() | method | stopAutoPlay() | exposed | stops autoplay timer. |

## CarouselState (public)

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| CarouselState(...) | class | N/A | missing | JS does not expose the class directly. |
| realPage | int | realPage (read-only) | exposed | surfaced via element property. |
| other members | class members | N/A | missing | Not exposed. |

## Helpers

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| ConditionalParentWidget | class | N/A | missing | Flutter-only helper. |

## Enums

| Source API | Type | JS Exposure | Status | Notes |
| --- | --- | --- | --- | --- |
| CarouselPageChangedReason (timed/manual/controller) | enum | CarouselPageChangedReason ('timed'/'manual'/'controller') | exposed | string union in JS types. |
| CenterPageEnlargeStrategy (scale/height/zoom) | enum | CenterPageEnlargeStrategy ('scale'/'height'/'zoom') | exposed | string union in JS types. |

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

无额外自定义事件暴露，使用 `onPageChanged` / `onScrolled` 回调属性。

## JS Element Properties/Methods (current)

| JS Exposure | Type | Source API | Status | Notes |
| --- | --- | --- | --- | --- |
| height | number | CarouselOptions.height | exposed | number → double. |
| aspectRatio | number | CarouselOptions.aspectRatio | exposed | number → double. |
| viewportFraction | number | CarouselOptions.viewportFraction | exposed | number → double. |
| initialPage | number | CarouselOptions.initialPage | exposed | number → int. |
| enableInfiniteScroll | boolean | CarouselOptions.enableInfiniteScroll | exposed | boolean. |
| animateToClosest | boolean | CarouselOptions.animateToClosest | exposed | boolean. |
| reverse | boolean | CarouselOptions.reverse | exposed | boolean. |
| autoPlay | boolean | CarouselOptions.autoPlay | exposed | boolean. |
| autoPlayInterval | number (ms) | CarouselOptions.autoPlayInterval | exposed | milliseconds. |
| autoPlayAnimationDuration | number (ms) | CarouselOptions.autoPlayAnimationDuration | exposed | milliseconds. |
| autoPlayCurve | string | CarouselOptions.autoPlayCurve | exposed | curve name string. |
| enlargeCenterPage | boolean | CarouselOptions.enlargeCenterPage | exposed | boolean. |
| onPageChanged | callback | CarouselOptions.onPageChanged | exposed | callback property. |
| onScrolled | callback | CarouselOptions.onScrolled | exposed | callback property. |
| scrollPhysics | string | CarouselOptions.scrollPhysics | exposed | string identifier. |
| pageSnapping | boolean | CarouselOptions.pageSnapping | exposed | boolean. |
| scrollDirection | string | CarouselOptions.scrollDirection | exposed | `horizontal` \| `vertical`. |
| pauseAutoPlayOnTouch | boolean | CarouselOptions.pauseAutoPlayOnTouch | exposed | boolean. |
| pauseAutoPlayOnManualNavigate | boolean | CarouselOptions.pauseAutoPlayOnManualNavigate | exposed | boolean. |
| pauseAutoPlayInFiniteScroll | boolean | CarouselOptions.pauseAutoPlayInFiniteScroll | exposed | boolean. |
| pageViewKey | string | CarouselOptions.pageViewKey | exposed | string identifier. |
| enlargeStrategy | string | CarouselOptions.enlargeStrategy | exposed | enum string. |
| enlargeFactor | number | CarouselOptions.enlargeFactor | exposed | number → double. |
| disableCenter | boolean | CarouselOptions.disableCenter | exposed | boolean. |
| padEnds | boolean | CarouselOptions.padEnds | exposed | boolean. |
| clipBehavior | string | CarouselOptions.clipBehavior | exposed | string identifier. |
| disableGesture | boolean | CarouselSlider.disableGesture | exposed | boolean. |
| realPage (readonly) | number | CarouselState.realPage | exposed | read-only mapping. |
| nextPage(duration?, curve?) | method | CarouselSliderController.nextPage | exposed | duration ms, curve name. |
| previousPage(duration?, curve?) | method | CarouselSliderController.previousPage | exposed | duration ms, curve name. |
| jumpToPage(page) | method | CarouselSliderController.jumpToPage | exposed | direct jump. |
| animateToPage(page, duration?, curve?) | method | CarouselSliderController.animateToPage | exposed | duration ms, curve name. |
| startAutoPlay() | method | CarouselSliderController.startAutoPlay | exposed | starts autoplay. |
| stopAutoPlay() | method | CarouselSliderController.stopAutoPlay | exposed | stops autoplay. |

## Notes
- 记录 JS 暴露与官方 API 的一致性状态，任何差异需说明原因与影响。
- 作为 API 完整性核对清单与测试对照。

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

### CarouselSlider widget properties
- `disableGesture`: 设置 `disableGesture` 并验证是否禁用触控滑动。

### CarouselSliderController methods
- `nextPage`: 调用并确认向后翻页与动画参数。
- `previousPage`: 调用并确认向前翻页与动画参数。
- `jumpToPage`: 调用并确认无动画跳转。
- `animateToPage`: 调用并确认带动画跳转。
- `startAutoPlay`: 调用并确认自动播放启动。
- `stopAutoPlay`: 调用并确认自动播放停止。

### CarouselState (public)
- `realPage`: 验证 `realPage` 读取与内部状态一致。

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
- 无自定义事件；仅验证 `onPageChanged` / `onScrolled` 回调。

## Example Snippets (JS)

```js
const carousel = document.querySelector('webf-carousel-slider');

// Properties (CarouselOptions + widget properties)
carousel.height = 240;
carousel.aspectRatio = 2.0;
carousel.viewportFraction = 0.8;
carousel.initialPage = 1;
carousel.enableInfiniteScroll = true;
carousel.animateToClosest = true;
carousel.reverse = false;
carousel.autoPlay = true;
carousel.autoPlayInterval = 3000;
carousel.autoPlayAnimationDuration = 800;
carousel.autoPlayCurve = 'fast-out-slow-in';
carousel.enlargeCenterPage = false;
carousel.scrollPhysics = 'clamping';
carousel.pageSnapping = true;
carousel.scrollDirection = 'horizontal';
carousel.pauseAutoPlayOnTouch = true;
carousel.pauseAutoPlayOnManualNavigate = true;
carousel.pauseAutoPlayInFiniteScroll = false;
carousel.pageViewKey = 'carousel-main';
carousel.enlargeStrategy = 'scale';
carousel.enlargeFactor = 0.3;
carousel.disableCenter = false;
carousel.padEnds = true;
carousel.clipBehavior = 'hardEdge';
carousel.disableGesture = false;

// Callbacks
carousel.onPageChanged = (index, reason) => {
  console.log(index, reason);
};
carousel.onScrolled = (value) => {
  console.log(value);
};

// Controller methods
carousel.nextPage();
carousel.previousPage(300, 'linear');
carousel.jumpToPage(2);
carousel.animateToPage(3, 300, 'ease-in-out');
carousel.startAutoPlay();
carousel.stopAutoPlay();

// Items
// <webf-carousel-slider-item image-url="image.jpg"></webf-carousel-slider-item>
```

## WebF Compatibility (T033)

- 未新增 DOM/CSS/JS API 使用；仅使用既有自定义元素属性与 JS 回调机制。

## Performance Validation (T027)

- 方法：默认配置连续滑动 10 次，目标 60 fps，无可感知卡顿。
- 结果：未执行（需要在真实设备/模拟器验证）。
