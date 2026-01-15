# Feature Specification: Carousel Slider JS Bridge Parity

## Assumptions

- 本规范聚焦 JS 侧对 `carousel_slider_plus` 的接口、参数、事件原样可用与一致性，不讨论实现细节。
- 以现有 `carousel_slider_plus` 公共接口与事件文档为权威来源，覆盖清单以该来源为基准。
- JS 侧运行环境与现有示例一致；使用原始 `carousel_slider_plus` API 命名的调用代码无需为本次改动做语义调整。示例文件允许更新为原始 API 命名以验证兼容性。
- 官方来源已记录于 `specs/001-carousel-slider-plus-bridge/api-inventory.md`（pub.dev + v7.1.1 源码 tag）。

**Feature Branch**: `001-carousel-slider-plus-bridge`  
**Created**: 2026-01-13  
**Status**: Draft  
**Input**: User description: "@native_uis/webf_carousel_slider/ 完全重构，优化，清理这个项目，必须原封不动的 把 carousel_slider_plus 的原先有的所有接口，参数，事件 根据 webf-native-ui-dev skill 桥接暴漏给 js , 原先 carousel_slider_plus 自己的 接口，参数，事件 命名都不可以改，不要做额外封装，不要做额外转移，不要做额外转换"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - JS API 原样可用 (Priority: P1)

作为使用者，我希望在 JS 侧直接使用 `carousel_slider_plus` 的所有接口、参数、事件且命名完全一致。

**Why this priority**: 这是核心价值，决定是否能“原封不动”复用现有 API。  

**Independent Test**: 用一个仅依赖原始 API/事件命名的示例脚本即可验证功能是否完整可用。  

**Acceptance Scenarios**:

1. **Given** 使用者仅知道 `carousel_slider_plus` 的原始 API/参数/事件命名，**When** 按原始名称调用或监听，**Then** 所有调用与事件均可用。
2. **Given** 已存在的调用代码不做任何改动，**When** 在该 JS 运行环境中执行，**Then** 行为与原始 API 语义保持一致。

---

### User Story 2 - 行为一致且无额外封装 (Priority: P2)

作为使用者，我希望接口语义不被额外封装、转移或转换，这样调用结果与原始组件一致且可预测。

**Why this priority**: 任何额外封装都会破坏兼容性与预期行为。  

**Independent Test**: 对比原始组件的行为说明与当前实现的行为说明，逐项验证一致性。  

**Acceptance Scenarios**:

1. **Given** 任意原始参数输入，**When** 传入到当前实现，**Then** 行为与原始组件一致，且不发生额外格式转换。

**关键行为清单（必须覆盖）**：
- autoplay / autoPlayInterval / autoPlayAnimationDuration
- enableInfiniteScroll / reverse / enlargeCenterPage
- initialPage / viewportFraction / aspectRatio
- pageView 的 onPageChanged 语义与触发频率

---

### User Story 3 - 维护者可验证完整覆盖 (Priority: P3)

作为维护者，我希望有一份可核对的 API 覆盖清单，这样能确认所有原始接口与事件都已暴露。

**Why this priority**: 便于验证完整性并避免遗漏。  

**Independent Test**: 依据覆盖清单逐项比对，验证每一项均可用。  

**Acceptance Scenarios**:

1. **Given** 覆盖清单包含全部原始接口/参数/事件，**When** 逐项核验，**Then** 每项都有对应的可用实现且命名一致。

---

### Edge Cases

- 当使用者传入原始组件不支持的参数时，系统必须与原始组件的失败模式一致（如同样的错误提示或无操作）。
- 当事件触发顺序或频率在边界条件下变化时，系统必须与原始事件语义一致。
- 当调用顺序与原始推荐顺序不一致时，系统必须保持与原始组件一致的容错或失败行为。

## Clarifications

### Session 2026-01-14

- Q: 迁移说明是否需要保留？（考虑“不需要向后兼容/旧命名”） → A: 迁移说明要求保留（遵循宪章）；如发生破坏性变更，必须更新 CHANGELOG 并提供迁移说明。

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: 系统 MUST 完整暴露 `carousel_slider_plus` 的所有公开接口、参数与事件。
- **FR-002**: 系统 MUST 保持所有接口、参数、事件名称与原始命名完全一致。
- **FR-003**: 系统 MUST 保持行为语义与原始组件一致，不引入额外封装、转移或转换。
- **FR-004**: 系统 MUST 提供一份可核对的 API 覆盖清单，用于验证完整性。
- **FR-005**: 系统 MUST 在不改变对外行为的前提下完成重构与清理；清理范围限定于 `native_uis/webf_carousel_slider/lib/src/{config,controller,event,utils}`，但为满足 FR-001/FR-002/FR-007 可修改 `native_uis/webf_carousel_slider/lib/src/{carousel_slider.dart,carousel_slider_item.dart,*.d.ts}`；不新增/改变对外 API；仅移除冗余转换与未使用逻辑并保持现有测试覆盖。
- **FR-006**: 系统 MUST 在覆盖清单中标注每个接口/事件的验证方式（示例调用或事件触发步骤）。
- **FR-007**: 系统 MUST 移除任何非 `carousel_slider_plus` 原始命名的对外接口，禁止保留旧名作为公开 API。

### Non-Functional Requirements

- **NFR-001**: 系统 MUST 保持轮播交互流畅性（基准场景：默认配置连续滑动 10 次；使用 Flutter Performance Overlay 或 DevTools 统计，90% 帧时间 < 16.7ms，无可感知卡顿）。
- **NFR-002**: 系统 MUST 避免引入新的运行时依赖，除非在计划中明确必要性与收益。
- **NFR-003**: 系统 MUST 保持 WebF 兼容性，不引入未支持的 Web API。

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 覆盖清单验证 FR-001/FR-002 通过率 100%。
- **SC-002**: 示例脚本（按原始 API 命名）验证通过率 100%。
- **SC-003**: 关键行为对比测试通过率达到 100%（原始语义一致）。
- **SC-004**: 维护者对完整覆盖的核对用例一次性通过，无遗漏项。
