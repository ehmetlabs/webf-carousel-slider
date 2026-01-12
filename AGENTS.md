# Repository Guidelines

This repository provides a WebF hybrid UI carousel: a Flutter/Dart custom element and a React/TypeScript wrapper. Keep changes scoped to the relevant module and update docs/tests when APIs change.

## Project Structure & Module Organization

- `native_uis/webf_carousel_slider/`: Flutter package that implements the WebF custom element.
  - `lib/src/`: Core implementation, config, event handling, and bindings.
  - `test/`: Dart/Flutter unit and widget tests.
  - `example/`: Demo app and `assets/index.html`.
- `packages/webf-react-carousel-slider/`: TypeScript wrapper package.
  - `src/index.ts`: generated entry file.
  - `src/types.ts`: generated type declarations.
  - `tsup.config.ts`: bundling configuration.
- Root-level docs live in `CLAUDE.md` and module READMEs.

## Build, Test, and Development Commands

- Flutter deps: `cd native_uis/webf_carousel_slider && flutter pub get`
- Flutter tests: `cd native_uis/webf_carousel_slider && flutter test`
- React/TS build: `cd packages/webf-react-carousel-slider && npm install && npm run build`
- Codegen (from README): `webf codegen ... --flutter-package-src=./native_uis/webf_carousel_slider`

## Coding Style & Naming Conventions

- Dart follows `flutter_lints`; keep files `lower_snake_case`, types `UpperCamelCase`, members `lowerCamelCase`.
- TypeScript uses `tsconfig.json` with `strict: true`; keep exports explicit and align with existing naming in `src/types.ts`.
- Generated files are marked in headers (e.g., `src/index.ts`, `src/types.ts`, `carousel_slider_bindings_generated.dart`)—avoid manual edits; regenerate instead.

## Testing Guidelines

- Primary tests are in `native_uis/webf_carousel_slider/test/` and run via `flutter test`.
- If you add new Dart behavior, add or update tests in the same module.
- No JS test runner is configured; include setup notes if you introduce one.

## Commit & Pull Request Guidelines

- Commit history uses emoji + conventional style: `✨ feat(scope): message`, `♻️ refactor(scope): ...`, `📝 docs(scope): ...`. Messages can be Chinese or English; keep scope short.
- PRs should include: concise summary, test evidence (commands + results), and screenshots/GIFs for UI changes. Update README/API docs when public behavior changes.

## Agent-Specific Notes

- Prefer minimal changes (KISS/YAGNI) and keep shared logic centralized (DRY).
- When touching WebF APIs or bindings, verify compatibility in both Dart and TypeScript layers.

<!-- webf-agents:init start -->
## WebF Claude Code Skills

Source: `@openwebf/claude-code-skills@1.0.2`

### Skills
- `webf-api-compatibility` — Check Web API and CSS feature compatibility in WebF - determine what JavaScript APIs, DOM methods, CSS properties, and layout modes are supported. Use when planning features, debugging why APIs don't work, or finding alternatives for unsupported features like IndexedDB, WebGL, float layout, or CSS Grid. (`.codex/skills/webf-api-compatibility/SKILL.md`)
- `webf-async-rendering` — Understand and work with WebF's async rendering model - handle onscreen/offscreen events and element measurements correctly. Use when getBoundingClientRect returns zeros, computed styles are incorrect, measurements fail, or elements don't layout as expected. (`.codex/skills/webf-async-rendering/SKILL.md`)
- `webf-hybrid-ui-dev` — Develop custom native/hybrid UI libraries based on Flutter widgets for WebF. Create reusable component libraries that wrap Flutter widgets as web-accessible custom elements. Use when building UI libraries, wrapping Flutter packages, or creating native component systems. (`.codex/skills/webf-hybrid-ui-dev/SKILL.md`)
- `webf-infinite-scrolling` — Create high-performance infinite scrolling lists with pull-to-refresh and load-more capabilities using WebFListView. Use when building feed-style UIs, product catalogs, chat messages, or any scrollable list that needs optimal performance with large datasets. (`.codex/skills/webf-infinite-scrolling/SKILL.md`)
- `webf-native-plugin-dev` — Develop custom WebF native plugins based on Flutter packages. Create reusable plugins that wrap Flutter/platform capabilities as JavaScript APIs. Use when building plugins for native features like camera, payments, sensors, file access, or wrapping existing Flutter packages. (`.codex/skills/webf-native-plugin-dev/SKILL.md`)
- `webf-native-plugins` — Install WebF native plugins to access platform capabilities like sharing, payment, camera, geolocation, and more. Use when building features that require native device APIs beyond standard web APIs. (`.codex/skills/webf-native-plugins/SKILL.md`)
- `webf-native-ui` — Setup and use WebF's Cupertino UI library to build native iOS-style UIs with pre-built components instead of crafting everything with HTML/CSS. Use when building iOS apps, adding native UI components, or improving UI performance. (`.codex/skills/webf-native-ui/SKILL.md`)
- `webf-quickstart` — Get started with WebF development - setup WebF Go, create a React/Vue/Svelte project with Vite, and load your first app. Use when starting a new WebF project, onboarding new developers, or setting up development environment. (`.codex/skills/webf-quickstart/SKILL.md`)
- `webf-routing-setup` — Setup hybrid routing with native screen transitions in WebF - configure navigation using WebF routing instead of SPA routing. Use when setting up navigation, implementing multi-screen apps, or when react-router-dom/vue-router doesn't work as expected. (`.codex/skills/webf-routing-setup/SKILL.md`)

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
