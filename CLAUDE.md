# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/claude-code) when working with code in this repository.

## Project Overview

This is **sannjosevet** - a Flutter multi-platform veterinary/pet care management system. The application supports Android, iOS, macOS, Linux, Windows, and Web platforms.

## Tech Stack

- **Language:** Dart
- **Framework:** Flutter
- **State Management:** Hooks Riverpod
- **Navigation:** GoRouter with go_router_builder
- **Backend:** PocketBase (BaaS)
- **Serialization:** dart_mappable
- **Forms:** flutter_form_builder
- **Localization:** slang/slang_flutter

## Architecture

The project follows a **feature-based clean architecture**:

```
lib/src/
├── core/           # Shared functionality (routing, widgets, utils, models)
└── features/       # Feature modules (patients, products, appointments, etc.)
    └── [feature]/
        ├── data/           # Repositories, data sources
        ├── domain/         # Models, entities
        └── presentation/
            ├── controllers/  # Riverpod providers/notifiers
            ├── pages/        # Full-screen UI
            └── widgets/      # Feature-specific widgets
```

## Common Commands

```bash
# Install dependencies
dart pub get

# Run code generation (mappers, serializers, routes)
dart run build_runner build --delete-conflicting-outputs

# Generate localization files
dart run slang

# Run the app
flutter run

# Run tests
flutter test

# Analyze code
dart analyze

# Format code
dart format lib/
```

## Key Patterns

### State Management
- Use `@riverpod` annotation for providers
- AsyncNotifier for async state with loading/error handling
- Controllers extend `AsyncNotifier<T>` or use `Notifier<T>`

### Routing
- Routes defined in `lib/src/core/routing/`
- Each feature has its own `*.routes.dart` file
- Use `@TypedGoRoute` annotation with go_router_builder

### Models
- Use `@MappableClass()` decorator from dart_mappable
- Extend `PBObject` for PocketBase models
- Include `collectionName` static constant

### Forms
- Use `FormBuilderTextField`, `FormBuilderDropdown`, etc.
- Wrap forms in `FormBuilder` widget
- Access form state via `FormBuilder.of(context)`

### Error Handling
- Use `Failure` class from `core/foundation/failure.dart`
- Return `Either<Failure, T>` for operations that can fail (using fpdart)

## File Naming Conventions

- Feature directories: `snake_case`
- Dart files: `snake_case.dart`
- Pages: `*_page.dart`
- Widgets: `*_widget.dart` or descriptive name
- Controllers: `*_controller.dart`
- Models: `*_model.dart` or entity name

## Testing

Tests are located in `/test` directory mirroring the `lib/` structure.

## Important Directories

- `/lib/src/core/widgets/` - Reusable UI components
- `/lib/src/core/routing/` - All route definitions
- `/lib/src/core/packages/` - Package integrations (PocketBase, storage)
- `/assets/` - Static assets and icons
- `/server/` - Backend server configurations

## Documentation

Detailed documentation is available in the `/docs` directory:

- **[Entities](docs/entities.md)** - All domain models with fields, relationships, and collection names (18 collections, 5 enums)
- **[Folder Structure](docs/folder_structure.md)** - Architecture layers, feature module structure, DTOs, repositories, and code patterns
- **[UI Structure](docs/ui.md)** - Responsive layouts, navigation hierarchy, routing structure, and component architecture
