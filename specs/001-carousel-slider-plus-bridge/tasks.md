---

description: "Task list template for feature implementation"
---

# Tasks: Carousel Slider JS Bridge Parity

**Input**: Design documents from `/specs/001-carousel-slider-plus-bridge/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are REQUIRED for changes to Dart behavior in `native_uis/webf_carousel_slider/`.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Mobile**: `native_uis/webf_carousel_slider/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create API inventory for carousel_slider_plus in `specs/001-carousel-slider-plus-bridge/api-inventory.md`
- [x] T002 Create API coverage checklist template in `specs/001-carousel-slider-plus-bridge/api-coverage.md`
- [x] T003 [P] Snapshot current JS bindings in `native_uis/webf_carousel_slider/lib/src/carousel_slider.d.ts` (supports FR-001/FR-002)
- [x] T004 [P] Snapshot current JS item bindings in `native_uis/webf_carousel_slider/lib/src/carousel_slider_item.d.ts` (supports FR-001/FR-002)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 Build source-to-bridge mapping table in `specs/001-carousel-slider-plus-bridge/api-coverage.md` (source API ↔ JS API)
- [x] T006 [P] Identify missing/extra APIs and annotate gaps in `specs/001-carousel-slider-plus-bridge/api-coverage.md`
- [x] T007 Define verification steps per API in `specs/001-carousel-slider-plus-bridge/api-coverage.md`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - JS API 原样可用 (Priority: P1) 🎯 MVP

**Goal**: JS 侧完整暴露 carousel_slider_plus 公共接口、参数与事件且命名一致。

**Independent Test**: 基于 `api-coverage.md` 逐项验证调用与事件触发。

### Tests for User Story 1 (REQUIRED) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T008 [P] [US1] Add API parity tests in `native_uis/webf_carousel_slider/test/carousel_slider_api_parity_test.dart` (include negative assertions that legacy names are not exposed + default values)
- [x] T009 [P] [US1] Add event payload tests in `native_uis/webf_carousel_slider/test/carousel_slider_events_test.dart`

### Implementation for User Story 1

- [x] T012 [US1] Update slider bindings implementation in `native_uis/webf_carousel_slider/lib/src/carousel_slider.dart`
- [x] T013 [US1] Update item bindings implementation in `native_uis/webf_carousel_slider/lib/src/carousel_slider_item.dart`
- [x] T014 [US1] Update options mapping in `native_uis/webf_carousel_slider/lib/src/config/carousel_config.dart`
- [x] T015 [US1] Update event dispatch to match source semantics in `native_uis/webf_carousel_slider/lib/src/event/event_manager.dart`
- [x] T010 [US1] Align slider TypeScript definitions in `native_uis/webf_carousel_slider/lib/src/carousel_slider.d.ts`
- [x] T011 [US1] Align item TypeScript definitions in `native_uis/webf_carousel_slider/lib/src/carousel_slider_item.d.ts`
- [x] T011a [US1] Remove legacy/alias API names from `native_uis/webf_carousel_slider/lib/src/carousel_slider.d.ts`, `native_uis/webf_carousel_slider/lib/src/carousel_slider_item.d.ts`, and related Dart bindings

**Checkpoint**: User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - 行为一致且无额外封装 (Priority: P2)

**Goal**: 消除额外封装/转移/转换，确保行为语义与原始组件一致。

**Independent Test**: 对照原始 API 语义文档验证关键行为不被转换或篡改。

### Tests for User Story 2 (REQUIRED) ⚠️

- [x] T016 [P] [US2] Add behavior consistency tests in `native_uis/webf_carousel_slider/test/carousel_slider_behavior_test.dart` (覆盖关键行为清单 + 默认值 + 边界组合)
- [x] T016a [P] [US2] Add edge-case behavior tests in `native_uis/webf_carousel_slider/test/carousel_slider_edge_cases_test.dart` (unsupported params failure mode, event order/frequency, out-of-order calls)

### Implementation for User Story 2

- [x] T017 [US2] Audit and simplify enum conversion in `native_uis/webf_carousel_slider/lib/src/utils/enum_converter.dart`
- [x] T018 [US2] Audit and simplify type conversion in `native_uis/webf_carousel_slider/lib/src/utils/type_converter.dart`
- [x] T019 [US2] Audit and simplify item parsing in `native_uis/webf_carousel_slider/lib/src/utils/carousel_items_parser.dart`

**Checkpoint**: User Story 2 should be independently testable

---

## Phase 5: User Story 3 - 维护者可验证完整覆盖 (Priority: P3)

**Goal**: 提供可核对的 API 覆盖清单与验证步骤。

**Independent Test**: 维护者按清单逐项核验所有 API 均可用。

### Implementation for User Story 3

- [x] T020 [US3] Finalize coverage checklist with status columns in `specs/001-carousel-slider-plus-bridge/api-coverage.md`
- [x] T021 [US3] Add example call snippets per API in `specs/001-carousel-slider-plus-bridge/api-coverage.md`

**Checkpoint**: User Story 3 should be independently testable

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T022 [P] Update API documentation in `native_uis/webf_carousel_slider/README.md`
- [x] T023 [P] Update example usage in `native_uis/webf_carousel_slider/example/assets/index.html`
- [x] T024 Run WebF codegen for bindings (if .d.ts changed) and verify generated files: `packages/webf-react-carousel-slider/src/index.ts`, `packages/webf-react-carousel-slider/src/types.ts`, `native_uis/webf_carousel_slider/lib/src/carousel_slider_bindings_generated.dart`, `native_uis/webf_carousel_slider/lib/src/carousel_slider_item_bindings_generated.dart`
- [x] T024a Run `npm run build` in `packages/webf-react-carousel-slider/` if bindings/types changed
- [x] T025 Run `flutter test` for `native_uis/webf_carousel_slider/`
- [ ] T026 Run quickstart validation steps from `specs/001-carousel-slider-plus-bridge/quickstart.md`
- [ ] T027 [P] 记录性能验证方法与阈值并执行验证与结果记录（默认配置连续滑动 10 次；使用 Flutter Performance Overlay 或 DevTools 统计，90% 帧时间 < 16.7ms；目标 60 fps）写入 `specs/001-carousel-slider-plus-bridge/api-coverage.md`
- [x] T028 [P] Verify no new runtime dependencies were added by diffing `native_uis/webf_carousel_slider/pubspec.yaml` and `packages/webf-react-carousel-slider/package.json`, then record impact assessment in `specs/001-carousel-slider-plus-bridge/api-inventory.md`
- [x] T029 [P] Record official API source links and version snapshot in `specs/001-carousel-slider-plus-bridge/api-inventory.md`
- [x] T030 Update `native_uis/webf_carousel_slider/CHANGELOG.md` with breaking changes summary and migration notes
- [x] T033 Record WebF compatibility checks for any new DOM/CSS/JS API usage (with support references) in `specs/001-carousel-slider-plus-bridge/api-coverage.md`
- [x] T034 Document strict original-name policy and legacy API removal in `native_uis/webf_carousel_slider/README.md` (avoid duplicating CHANGELOG)
- [x] T035 Update versions in `native_uis/webf_carousel_slider/pubspec.yaml` and `packages/webf-react-carousel-slider/package.json` for breaking changes

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent but validates behavior from US1
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent documentation/validation work

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- 先更新 Dart 行为与配置（carousel_slider.dart / carousel_slider_item.dart / config / event / utils）
- 再更新 TypeScript 定义与绑定并执行 codegen
- 最后同步文档与示例
- Story complete before moving to next priority

### Parallel Opportunities

- T003 and T004 can run in parallel
- T008 and T009 can run in parallel
- T016 can run in parallel with non-overlapping file edits from T017–T019
- T022 and T023 can run in parallel

---

## Parallel Example: User Story 1

```bash
# Launch tests together:
Task: "Add API parity tests in native_uis/webf_carousel_slider/test/carousel_slider_api_parity_test.dart"
Task: "Add event payload tests in native_uis/webf_carousel_slider/test/carousel_slider_events_test.dart"

# Launch definition updates together:
Task: "Align slider TypeScript definitions in native_uis/webf_carousel_slider/lib/src/carousel_slider.d.ts"
Task: "Align item TypeScript definitions in native_uis/webf_carousel_slider/lib/src/carousel_slider_item.d.ts"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently
3. Add User Story 2 → Test independently
4. Add User Story 3 → Verify coverage checklist

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
