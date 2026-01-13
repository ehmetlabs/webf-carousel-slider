# Phase 1 Data Model: Carousel Slider JS Bridge Parity

## Entities

无新增持久化数据实体。本功能主要是 UI 组件 API 的桥接与行为一致性。

## Validation Rules

- 输入参数与事件语义必须与 `carousel_slider_plus` 原始定义一致。
- 不引入新的持久化状态或存储依赖。

## State Transitions

- 组件内部状态转移遵循原始组件行为，不新增额外状态机。
