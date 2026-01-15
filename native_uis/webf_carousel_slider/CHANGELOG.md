# Changelog

## 0.2.0

### Breaking
- 移除旧的 Swiper 风格 API 名称，统一为 `carousel_slider_plus` 原始命名（属性/方法/事件）。
- 移除自定义事件（`change`/`changestart`/`changeend`/`play`/`pause`），改为 `onPageChanged`/`onScrolled` 回调属性。

### Changed
- JS 侧完整对齐 `CarouselOptions` 与 `CarouselSliderController` 命名与语义。
- `enlargeStrategy`、`autoPlayCurve` 等通过字符串标识映射到 Flutter 枚举/曲线。
- `realPage` 以只读属性暴露当前真实索引。

## 0.1.0

### Architecture
- Follows WebF Hybrid UI best practices
- SOLID principles compliance
- Type-safe Dart implementation
- Comprehensive TypeScript definitions

## 0.0.0

### Initial Release
- Initial package setup
