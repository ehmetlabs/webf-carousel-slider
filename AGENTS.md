# Repository Guidelines

本仓库是 WebF hybrid UI carousel：Flutter/Dart 自定义元素 + React/Vue TypeScript 包装层。目标是最小变更、保守修复、避免改动生成文件。

## Project Structure

- `native_uis/webf_carousel_slider/`: Flutter 包，包含 WebF 自定义元素实现。
  - `lib/src/`: 组件实现、配置、事件、绑定。
  - `test/`: Dart/Flutter 单元/组件测试。
  - `example/`: 示例应用与 `assets/index.html`。
- `packages/webf-react-carousel-slider/`: React/TS 包装层。
  - `src/index.ts`: 生成文件，禁止手改。
  - `src/types.ts`: 生成文件，禁止手改。
- `packages/webf-vue-carousel-slider/`: Vue/TS 声明包（无构建脚本）。
- 根级文档：`README.md`、`CLAUDE.md`、本文件。

## Build / Test / Lint Commands

### Flutter (native_uis/webf_carousel_slider)

- 安装依赖：
  - `cd native_uis/webf_carousel_slider && flutter pub get`
- 运行全部测试：
  - `cd native_uis/webf_carousel_slider && flutter test`
- 运行单个测试文件（单测入口）：
  - `cd native_uis/webf_carousel_slider && flutter test test/<file>_test.dart`
- 仅运行某个测试名：
  - `cd native_uis/webf_carousel_slider && flutter test --name "<test name>"`

### React package (packages/webf-react-carousel-slider)

- 安装依赖 + 构建：
  - `cd packages/webf-react-carousel-slider && npm install && npm run build`
- 构建脚本：`npm run build` -> `tsdown`

### Vue package (packages/webf-vue-carousel-slider)

- 仅包含类型声明与依赖，无 build/lint/test 脚本。

### Codegen

- 生成文件禁止手改（见下方 Generated Files）。
- 使用 WebF CLI：
  - `webf codegen ... --flutter-package-src=./native_uis/webf_carousel_slider`

### Lint / Format

- Dart lint：`analysis_options.yaml` 使用 `flutter_lints` 默认规则。
- 未发现 ESLint / Prettier / EditorConfig / CI lint 脚本。
- TypeScript 主要依赖 `tsconfig.json` 的 `strict` 约束。

## Code Style & Conventions

### Dart / Flutter

- Lint：`native_uis/webf_carousel_slider/analysis_options.yaml` 引用 `flutter_lints`。
- 命名：
  - 文件：`lower_snake_case`
  - 类型：`UpperCamelCase`
  - 成员/变量/方法：`lowerCamelCase`
- 错误处理：
  - 避免吞异常；必要时记录或向上抛出。
  - 优先与现有 WebF API 兼容保持一致。
- 生成代码：`carousel_slider_bindings_generated.dart` 禁止手改。

### TypeScript (React/Vue packages)

- `strict: true`（React 与 Vue 包均启用）。
- React 包：`jsx: react-jsx`，有本地类型映射到 `@types/react`。
- Vue 包：`noImplicitAny: true`。
- 导出：保持显式导出，命名与 `src/types.ts` 一致。
- 错误处理：无 ESLint 约束，遵循 TS strict，避免 `any` 与静默 catch。

### Imports & Formatting

- 未配置 ESLint/Prettier，保持现有文件风格与排序方式。
- 如需新增规则，先在仓库内统一配置后再应用。

## Generated Files (Do Not Edit)

以下文件为生成产物，禁止直接修改：

- `native_uis/webf_carousel_slider/lib/src/carousel_slider_bindings_generated.dart`
- `packages/webf-react-carousel-slider/src/index.ts`
- `packages/webf-react-carousel-slider/src/types.ts`

修改 API 时：更新源文件 + 重新 codegen，再同步包说明文档。

## Testing Guidelines

- Flutter 改动需在 `native_uis/webf_carousel_slider/test/` 补充或更新测试。
- 无 JS 测试框架；如引入需更新 README 与本文件命令区。
- 测试与构建命令执行结果需在 PR 描述中提供。

## Commit & PR Guidelines

- Commit 格式：`✨ feat(scope): message` / `♻️ refactor(scope): ...` / `📝 docs(scope): ...`
- 语言：中文或英文均可，scope 简短。
- PR 需包含：摘要、测试证据（命令+结果），UI 变更需截图/GIF。

## WebF Notes

- WebF 异步布局：测量尺寸需等待 `onscreen` 事件。
- 变更 WebF API 或 bindings 时，需同时验证 Dart + TS 层兼容。

## External Agent Notes

- 保持变更最小化（KISS/YAGNI），避免顺手重构。
- 不要在修复 Bug 时顺带做大范围重构。
- 不要提交生成文件修改，除非由 codegen 自动产出。

<!-- webf-agents:init start -->
## WebF Claude Code Skills

Source: `@openwebf/claude-code-skills@1.0.2`

### Skills
- `webf-api-compatibility` — Check Web API and CSS feature compatibility in WebF - determine what JavaScript APIs, DOM methods, CSS properties, and layout modes are supported. Use when planning features, debugging why APIs don't work, or finding alternatives for unsupported features like IndexedDB, WebGL, float layout, or CSS Grid. (`.codex/skills/webf-api-compatibility/SKILL.md`)
- `webf-async-rendering` — Understand and work with WebF's async rendering model - handle onscreen/offscreen events and element measurements correctly. Use when getBoundingClientRect returns zeros, computed styles are incorrect, measurements fail, or elements don't layout as expected. (`.codex/skills/webf-async-rendering/SKILL.md`)
- `webf-hybrid-ui-dev` — Develop custom native/hybrid UI libraries based on Flutter widgets for WebF. Create reusable component libraries that wrap Flutter widgets as web-accessible custom elements. Use when building UI libraries, wrapping Flutter packages, or creating native component systems. (`.codex/skills/webf-hybrid-ui-dev/SKILL.md`)
- `webf-infinite-scrolling` — Create high-performance infinite scrolling lists with pull-to-refresh and load-more capabilities using WebFListView. Use when building feed-style UIs, product catalogs, chat messages, or any scrollable list that needs optimal performance with large datasets. (`.codex/skills/webf-infinite-scrolling/SKILL.md`)
- `webf-native-plugin-dev` — Develop custom WebF native plugins based on Flutter packages. Create reusable plugins that wrap Flutter/platform capabilities as JavaScript APIs. Use when building plugins for native features like camera, payments, sensors, file access, or wrapping existing Flutter packages. (`.codex/skills/webf-native-plugin-dev/SKILL.md`)
- `webf-native-plugins` — Install WebF native plugins to access platform capabilities like sharing, payment, camera, geolocation, and more. Use when building features that require native device APIs beyond standard web APIs. (`.codex/skills/webf-native-plugins/reference.md`)
- `webf-native-ui` — Setup and use WebF's Cupertino UI library to build native iOS-style UIs with pre-built components instead of crafting everything with HTML/CSS. Use when building iOS apps, adding native UI components, or improving UI performance. (`.codex/skills/webf-native-ui/reference.md`)
- `webf-quickstart` — Get started with WebF development - setup WebF Go, create a React/Vue/Svelte project with Vite, and load your first app. Use when starting a new WebF project, onboarding new developers, or setting up development environment. (`.codex/skills/webf-quickstart/reference.md`)
- `webf-routing-setup` — Setup hybrid routing with native screen transitions in WebF - configure navigation using WebF routing instead of SPA routing. Use when setting up navigation, implementing multi-screen apps, or when react-router-dom/vue-router doesn't work as expected. (`.codex/skills/webf-routing-setup/examples.md`)

### References
- `webf-api-compatibility`: `.codex/skills/webf-api-compatibility/alternatives.md`, `.codex/skills/webf-api-compatibility/reference.md`
- `webf-async-rendering`: `.codex/skills/webf-async-rendering/examples.md`
- `webf-hybrid-ui-dev`: `.codex/skills/webf-hybrid-ui-dev/example-input.md`, `.codex/skills/webf-hybrid-ui-dev/typescript-guide.md`
- `webf-infinite-scrolling`: `.codex/skills/webf-infinite-scrolling/examples.md`
- `webf-native-plugins`: `.codex/skills/webf-native-plugins/reference.md`
- `webf-native-ui`: `.codex/skills/webf-native-ui/reference.md`
- `webf-quickstart`: `.codex/skills/webf-quickstart/reference.md`
- `webf-routing-setup`: `.codex/skills/webf-routing-setup/cross-platform.md`, `.codex/skills/webf-routing-setup/examples.md`
<!-- webf-agents:init end -->

## Active Technologies
- Dart >=3.0.0 <4.0.0, Flutter >=3.16.0; TypeScript strict mode + webf ^0.24.2; carousel_slider_plus ^7.1.1 (001-carousel-slider-plus-bridge)

## Recent Changes
- 001-carousel-slider-plus-bridge: Added Dart >=3.0.0 <4.0.0, Flutter >=3.16.0; TypeScript strict mode + webf ^0.24.2; carousel_slider_plus ^7.1.1

<skills_system priority="1">

## Available Skills

<!-- SKILLS_TABLE_START -->
<usage>
When users ask you to perform tasks, check if any of the available skills below can help complete the task more effectively. Skills provide specialized capabilities and domain knowledge.

How to use skills:
- Invoke: Bash("openskills read <skill-name>")
- The skill content will load with detailed instructions on how to complete the task
- Base directory provided in output for resolving bundled resources (references/, scripts/, assets/)

Usage notes:
- Only use skills listed in <available_skills> below
- Do not invoke a skill that is already loaded in your context
- Each skill invocation is stateless
</usage>

<available_skills>

<skill>
<name>webf-api-compatibility</name>
<description>Check Web API and CSS feature compatibility in WebF - determine what JavaScript APIs, DOM methods, CSS properties, and layout modes are supported. Use when planning features, debugging why APIs don't work, or finding alternatives for unsupported features like IndexedDB, WebGL, float layout, or CSS Grid.</description>
<location>project</location>
</skill>

<skill>
<name>webf-async-rendering</name>
<description>Understand and work with WebF's async rendering model - handle onscreen/offscreen events and element measurements correctly. Use when getBoundingClientRect returns zeros, computed styles are incorrect, measurements fail, or elements don't layout as expected.</description>
<location>project</location>
</skill>

<skill>
<name>webf-hybrid-ui-dev</name>
<description>Develop custom native/hybrid UI libraries based on Flutter widgets for WebF. Create reusable component libraries that wrap Flutter widgets as web-accessible custom elements. Use when building UI libraries, wrapping Flutter packages, or creating native component systems.</description>
<location>project</location>
</skill>

<skill>
<name>webf-infinite-scrolling</name>
<description>Create high-performance infinite scrolling lists with pull-to-refresh and load-more capabilities using WebFListView. Use when building feed-style UIs, product catalogs, chat messages, or any scrollable list that needs optimal performance with large datasets.</description>
<location>project</location>
</skill>

<skill>
<name>webf-native-plugin-dev</name>
<description>Develop custom WebF native plugins based on Flutter packages. Create reusable plugins that wrap Flutter/platform capabilities as JavaScript APIs. Use when building plugins for native features like camera, payments, sensors, file access, or wrapping existing Flutter packages.</description>
<location>project</location>
</skill>

<skill>
<name>webf-native-plugins</name>
<description>Install WebF native plugins to access platform capabilities like sharing, payment, camera, geolocation, and more. Use when building features that require native device APIs beyond standard web APIs.</description>
<location>project</location>
</skill>

<skill>
<name>webf-native-ui</name>
<description>Setup and use WebF's Cupertino UI library to build native iOS-style UIs with pre-built components instead of crafting everything with HTML/CSS. Use when building iOS apps, adding native UI components, or improving UI performance.</description>
<location>project</location>
</skill>

<skill>
<name>webf-quickstart</name>
<description>Get started with WebF development - setup WebF Go, create a React/Vue/Svelte project with Vite, and load your first app. Use when starting a new WebF project, onboarding new developers, or setting up development environment.</description>
<location>project</location>
</skill>

<skill>
<name>webf-routing-setup</name>
<description>Setup hybrid routing with native screen transitions in WebF - configure navigation using WebF routing instead of SPA routing. Use when setting up navigation, implementing multi-screen apps, or when react-router-dom/vue-router doesn't work as expected.</description>
<location>project</location>
</skill>

<skill>
<name>release-branch-notes</name>
<description>Create a release/x.y.z branch in a Git repo and generate Release Notes from the latest tag to HEAD, grouped as Features/Fixes/Breaking and written to CHANGELOG.md. Use for automated release branch creation, release notes generation, and changelog updates.</description>
<location>global</location>
</skill>

</available_skills>
<!-- SKILLS_TABLE_END -->

</skills_system>
