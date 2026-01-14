# Repository Guidelines

## Project Structure & Module Organization
- `lib/` contains all Dart source. Entry point is `lib/main.dart`.
- `lib/src/core/` holds shared app infrastructure (routing, widgets, utils, models).
- `lib/src/features/` is organized by domain modules (patients, products, appointments, etc.) with `data/`, `domain/`, and `presentation/` layers.
- `assets/` contains static assets and icons.
- `test/` mirrors the `lib/` structure for unit/widget tests.
- `docs/` includes architecture references (entities, UI, folder structure).

## Build, Test, and Development Commands
```bash
# Install dependencies
 dart pub get

# Code generation (mappers, routes, etc.)
 dart run build_runner build --delete-conflicting-outputs

# Generate localization files
 dart run slang

# Run the app (device/emulator)
 flutter run

# Run tests
 flutter test

# Static analysis and formatting
 dart analyze
 dart format lib/
```
Use `flutter run` for local development; run `build_runner` and `slang` after model/route/i18n updates.

## Coding Style & Naming Conventions
- Formatting: use `dart format lib/` before committing.
- Linting: follow `flutter_lints` and `custom_lint` (`analysis_options.yaml`), and address `dart analyze` warnings.
- File naming: `snake_case.dart` (e.g., `patients_controller.dart`).
- Pages: `*_page.dart`; controllers: `*_controller.dart`; widgets: `*_widget.dart`.
- Controllers are plural when they manage lists (e.g., `patients_controller.dart`, `patient_records_controller.dart`).
- Single-entity providers use singular naming and live in `*_provider.dart` (e.g., `patient_provider.dart`, `patient_record_provider.dart`).
- Feature folders use `snake_case` and follow the `data/`, `domain/`, `presentation/` pattern.

## Provider Setup
- Use `@riverpod` for providers and `@Riverpod` when keep-alive is needed.
- Keep list controllers and single-entity providers in separate files with their own `part` directives.
- Provider names should mirror singular/plural intent (e.g., `patientRecordsControllerProvider` vs `patientRecordProvider`).

## Testing Guidelines
- Framework: Flutter test runner (`flutter test`).
- Location: `test/` mirrors `lib/` paths.
- Naming: `*_test.dart` for unit/widget tests.
- Add tests for new logic in repositories, controllers, and utilities.

## Commit & Pull Request Guidelines
- Commits follow Conventional Commits (e.g., `feat: ...`, `fix: ...`, `refactor: ...`, `docs: ...`, `chore: ...`).
- PRs should include a clear summary, linked issue (if applicable), and a note of tests run.
- Include screenshots or screen recordings for UI changes.

## Agent-Specific Notes
- See `CLAUDE.md` for code patterns (Riverpod, routing, models) when making architectural changes.
