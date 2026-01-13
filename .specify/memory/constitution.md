<!--
Sync Impact Report
- Version change: 1.0.1 → 1.0.2
- Modified principles: API 双层一致性
- Added sections: None
- Removed sections: None
- Modified sections: Core Principles (generated files list refined)
- Templates requiring updates:
  - ✅ checked (no changes) .specify/templates/plan-template.md
  - ✅ checked (no changes) .specify/templates/tasks-template.md
  - ✅ checked (no changes) .specify/templates/spec-template.md
  - ✅ checked (no changes) .specify/templates/checklist-template.md
  - ✅ checked (no changes) .specify/templates/agent-file-template.md
  - ⚠ pending .specify/templates/commands/*.md (directory missing)
- Runtime guidance checked:
  - ✅ checked (no changes) CLAUDE.md
  - ✅ checked (no changes) native_uis/webf_carousel_slider/README.md
- Follow-up TODOs:
  - TODO(RATIFICATION_DATE): ratification date not recorded in repo
-->
# WebF Carousel Slider Constitution

## Core Principles

### API 双层一致性
- 任何对外 API 变更必须同步更新 Dart Custom Element、TypeScript 类型与 React
  绑定，并通过 WebF CLI 重新生成绑定文件。
- 禁止手改生成文件（`packages/webf-react-carousel-slider/src/index.ts`、
  `packages/webf-react-carousel-slider/src/types.ts`、
  `native_uis/webf_carousel_slider/lib/src/carousel_slider_bindings_generated.dart`、
  `native_uis/webf_carousel_slider/lib/src/carousel_slider_item_bindings_generated.dart`）。
- `native_uis/webf_carousel_slider/lib/src/carousel_slider.d.ts` 与
  `native_uis/webf_carousel_slider/lib/src/carousel_slider_item.d.ts` 为手维护定义文件，可直接修改。
- 理由：避免 Dart/JS 行为漂移，保证接口一致可追踪。

### WebF 兼容性优先
- 新增 DOM/CSS/JS API 前必须确认 WebF 支持；不支持则提供替代方案或不引入。
- 兼容性假设必须记录在计划或实现说明中。
- 理由：避免运行时不兼容导致的功能不可用。

### 性能与依赖最小化
- 新增运行时依赖必须在计划中说明必要性与预期收益。
- 轮播渲染与事件路径避免无意义的 state 更新或热路径日志。
- 理由：保持组件轻量与稳定帧率。

### 可测试性与回归防护
- 任何 Dart 行为变更必须新增/更新
  `native_uis/webf_carousel_slider/test/` 测试并通过 `flutter test`。
- 新增事件/属性必须覆盖默认值与边界条件。
- 理由：降低回归风险并确保行为可验证。

### 文档与示例同步
- 公开 API 变更必须同步更新
  `native_uis/webf_carousel_slider/README.md` 与示例（`example/` 或代码生成说明）。
- 破坏性变更必须更新
  `native_uis/webf_carousel_slider/CHANGELOG.md` 并提供迁移说明。
- 理由：保证使用者与绑定层能正确跟进变化。

## Engineering Standards

- Dart/Flutter：Dart `>=3.0.0 <4.0.0`，Flutter `>=3.16.0`，使用
  `flutter_lints`，遵循 Effective Dart。
- TypeScript：`strict: true`，通过 `tsdown` 构建并输出到 `dist/`。
- 模块边界：Flutter 实现在 `native_uis/`，绑定包在 `packages/`，避免跨模块耦合。
- 代码生成：通过 `webf codegen` 生成绑定文件，保留生成文件头部标记。

## Development Workflow & Quality Gates

- 需求/设计阶段必须完成 Constitution Check，记录兼容性与依赖决策。
- 实现顺序：先更新 Dart 行为与配置，再更新类型与绑定并执行 codegen，
  最后同步文档与示例。
- 质量门槛：Dart 变更必须运行 `flutter test`；绑定包变更必须运行
  `npm run build`。
- 破坏性变更必须同步更新 `pubspec.yaml` 与
  `packages/webf-react-carousel-slider/package.json` 的版本号。

## Governance

- 本宪章优先级高于其他开发约定，所有变更需通过 PR 并同步更新相关模板。
- 版本策略遵循语义化版本：重大原则变更为 MAJOR，新原则/新增章节为 MINOR，
  文案澄清为 PATCH。
- 审核要求：每个计划文档必须完成 Constitution Check，代码评审需验证原则合规，
  例外情况必须在计划中明确记录并给出理由。

**Version**: 1.0.2 | **Ratified**: TODO(RATIFICATION_DATE): ratification date not recorded | **Last Amended**: 2026-01-13
