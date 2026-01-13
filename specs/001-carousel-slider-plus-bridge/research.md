# Phase 0 Research: Carousel Slider JS Bridge Parity

## Decision 1: API 真实来源与覆盖基准

**Decision**: 以 `carousel_slider_plus` 的官方文档与源码公开 API 作为唯一覆盖基准。  
**Rationale**: 需求明确要求“原封不动”暴露原始接口/参数/事件，必须以官方公开 API 为准。  
**Alternatives considered**: 仅依赖当前 WebF 包中的 .d.ts 和实现（可能存在遗漏）。
**Sources**:
- https://pub.dev/packages/carousel_slider_plus
- https://pub.dev/documentation/carousel_slider_plus/latest/
- https://github.com/kishan-dhankecha/carousel_slider_plus/tree/v7.1.1

## Decision 2: 暴露策略

**Decision**: 仅桥接公开 API 与事件，不做额外封装/转移/转换。  
**Rationale**: 用户明确禁止任何额外封装与命名改变，确保零改动使用。  
**Alternatives considered**: 适配层或别名映射（被需求明确禁止）。

## Decision 3: 验证策略

**Decision**: 使用“API 覆盖清单 + 示例调用/事件触发步骤”作为完整性验证手段。  
**Rationale**: 能逐项验证覆盖与命名一致性，符合维护者需求。  
**Alternatives considered**: 仅依赖单元测试覆盖（无法体现完整接口清单）。
