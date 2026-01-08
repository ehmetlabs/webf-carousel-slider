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
