# Implementation Plan: Carousel Slider JS Bridge Parity

**Branch**: `001-carousel-slider-plus-bridge` | **Date**: 2026-01-13 | **Spec**: /Users/aihe/Workspace/app/webf-carousel/specs/001-carousel-slider-plus-bridge/spec.md
**Input**: Feature specification from `/specs/001-carousel-slider-plus-bridge/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

完成 `carousel_slider_plus` 公共接口/参数/事件在 JS 侧的原样桥接，
确保命名与语义完全一致，同时在不改变对外行为的前提下重构清理实现。

## Technical Context

**Language/Version**: Dart >=3.0.0 <4.0.0, Flutter >=3.16.0; TypeScript strict mode  
**Primary Dependencies**: webf ^0.24.2; carousel_slider_plus ^7.1.1  
**Storage**: N/A  
**Testing**: flutter test (native_uis/webf_carousel_slider/test/)  
**Target Platform**: WebF runtime (Flutter-based)  
**Project Type**: Mobile/native UI library with JS bindings  
**Performance Goals**: 保持 60 fps 级别的轮播性能与事件响应  
**Constraints**: 不能改变对外 API 命名与语义；禁止新增不必要运行时依赖  
**Scale/Scope**: 单一组件库（carousel slider + item）

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] Dart ↔ TypeScript public API parity is planned (bindings + types + codegen)
- [x] Dart behavior changes include a `flutter_test` plan in `native_uis/webf_carousel_slider/test/`
- [x] Public API changes include README/example update plan
- [x] Dependency/performance impact is justified (avoid new runtime deps, avoid unnecessary rebuilds)
- [x] WebF compatibility considerations are documented for any new web APIs

## Project Structure

### Documentation (this feature)

```text
specs/001-carousel-slider-plus-bridge/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
native_uis/webf_carousel_slider/
├── lib/
│   ├── src/
│   │   ├── config/
│   │   ├── controller/
│   │   ├── event/
│   │   ├── utils/
│   │   ├── carousel_slider.dart
│   │   ├── carousel_slider_item.dart
│   │   └── *.d.ts
│   └── webf_carousel_slider.dart
├── test/
│   ├── config/
│   ├── utils/
│   └── *_test.dart
└── example/
    ├── lib/main.dart
    └── assets/index.html
```

**Structure Decision**: 单包 Flutter/WebF 组件结构，绑定类型定义与实现同目录维护。

## Complexity Tracking

无额外复杂性豁免。
