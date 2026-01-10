# Folder Structure

This document describes the architecture and folder organization for the SanJoseVet Flutter application.

---

## Overview

The project follows a **feature-based clean architecture** with three distinct layers:

```
lib/
├── main.dart                 # App entry point
└── src/
    ├── core/                 # Shared functionality across features
    └── features/             # Feature modules organized by domain
```

---

## Architecture Layers

### Layer Responsibilities

| Layer | Purpose | Contains |
|-------|---------|----------|
| **Data** | External data access | Repositories, data sources, API clients |
| **Domain** | Business entities | Models, entities, value objects |
| **Presentation** | UI and state | Controllers, pages, widgets |

### Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         PRESENTATION                            │
│  ┌─────────────┐    ┌──────────────┐    ┌─────────────────┐    │
│  │   Pages     │ ◄─►│  Controllers │ ◄─►│    Widgets      │    │
│  └─────────────┘    └──────────────┘    └─────────────────┘    │
│         │                  │                                    │
│         └──────────────────┼────────────────────────────────────┤
│                            │                                    │
│                            ▼                                    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                      DOMAIN                              │   │
│  │  ┌───────────────┐    ┌───────────────┐                 │   │
│  │  │    Models     │    │    Entities   │                 │   │
│  │  └───────────────┘    └───────────────┘                 │   │
│  └─────────────────────────────────────────────────────────┘   │
│                            │                                    │
│                            ▼                                    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                       DATA                               │   │
│  │  ┌───────────────┐    ┌───────────────┐                 │   │
│  │  │  Repositories │ ◄─►│  PocketBase   │                 │   │
│  │  └───────────────┘    └───────────────┘                 │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Feature Module Structure

Each feature follows the same three-layer pattern:

```
features/
└── [domain]/
    └── [feature]/
        ├── data/
        │   └── [feature]_repository.dart
        ├── domain/
        │   └── [feature].dart
        └── presentation/
            ├── controllers/
            │   └── [feature]_controller.dart
            ├── pages/
            │   ├── [feature]_page.dart
            │   └── [feature]_form_page.dart
            └── widgets/
                └── [feature]_card.dart
```

### Example: Patients Feature

```
features/
└── patients/
    └── patients/
        ├── data/
        │   └── patient_repository.dart      # PocketBase CRUD operations
        ├── domain/
        │   └── patient.dart                 # Patient entity with dart_mappable
        └── presentation/
            ├── controllers/
            │   └── patient_controller.dart  # Riverpod AsyncNotifier
            ├── pages/
            │   ├── patients_page.dart       # List view
            │   ├── patient_page.dart        # Detail view
            │   └── patient_form_page.dart   # Create/Edit form
            └── widgets/
                ├── patient_card.dart        # List item widget
                └── patient_details_view.dart
```

---

## Layer Details

### Data Layer

The data layer handles all external data operations.

```
data/
└── [feature]_repository.dart
```

**Repository Pattern:**

```dart
class PatientRepository implements PBRepository<Patient> {
  final PocketBase pb;

  @override
  String get collectionName => Patient.collectionName;

  @override
  Future<Either<Failure, List<Patient>>> getAll() async {
    try {
      final records = await pb.collection(collectionName).getFullList();
      return Right(records.map((r) => PatientMapper.fromMap(r.toJson())).toList());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Patient>> create(Patient entity) async { ... }

  @override
  Future<Either<Failure, Patient>> update(Patient entity) async { ... }

  @override
  Future<Either<Failure, void>> delete(String id) async { ... }
}
```

**Key Concepts:**
- Implements `PBRepository<T>` interface
- Returns `Either<Failure, T>` for error handling
- Uses PocketBase client for backend operations
- Maps between PocketBase records and domain entities

---

### Domain Layer

The domain layer contains business entities and models.

```
domain/
└── [feature].dart
```

**Entity Pattern:**

```dart
@MappableClass()
class Patient extends PbRecord with PatientMappable {
  static const String collectionName = 'patients';

  final String name;
  final String species;      // FK -> Species
  final String? breed;       // FK -> Breed
  final String owner;        // FK -> User
  final DateTime? birthDate;
  final Gender gender;
  final String? notes;

  const Patient({
    required super.id,
    required super.created,
    required super.updated,
    required this.name,
    required this.species,
    this.breed,
    required this.owner,
    this.birthDate,
    required this.gender,
    this.notes,
  });
}
```

**Key Concepts:**
- Uses `@MappableClass()` from dart_mappable for serialization
- Extends `PbRecord` base class for PocketBase compatibility
- Static `collectionName` for repository reference
- Enums for fixed values (Gender, Status, etc.)

---

### Presentation Layer

The presentation layer handles UI and state management.

```
presentation/
├── controllers/      # State management
├── pages/            # Full-screen UI
└── widgets/          # Reusable components
```

#### Controllers

**AsyncNotifier Pattern:**

```dart
@riverpod
class PatientController extends _$PatientController {
  @override
  Future<List<Patient>> build() async {
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.getAll();
    return result.fold(
      (failure) => throw failure,
      (patients) => patients,
    );
  }

  Future<void> create(Patient patient) async {
    state = const AsyncLoading();
    final result = await ref.read(patientRepositoryProvider).create(patient);
    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }
}
```

**Key Concepts:**
- Uses `@riverpod` annotation for code generation
- Extends generated `_$ControllerName` class
- `build()` method for initial data loading
- State management via `AsyncValue<T>`

#### Pages

**List Page Pattern:**

```dart
class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: patientsAsync.when(
        data: (patients) => ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) => PatientCard(patient: patients[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorWidget(error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/patients/form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Form Page Pattern:**

```dart
class PatientFormPage extends HookConsumerWidget {
  final String? patientId; // null for create, id for edit

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      appBar: AppBar(
        title: Text(patientId == null ? 'New Patient' : 'Edit Patient'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _save(context, ref, formKey),
          ),
        ],
      ),
      body: FormBuilder(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FormBuilderTextField(
              name: 'name',
              decoration: const InputDecoration(labelText: 'Name'),
              validator: FormBuilderValidators.required(),
            ),
            // ... more fields
          ],
        ),
      ),
    );
  }
}
```

#### Widgets

**Card Widget Pattern:**

```dart
class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;

  const PatientCard({
    super.key,
    required this.patient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.pets)),
        title: Text(patient.name),
        subtitle: Text('${patient.species} - ${patient.breed ?? "Unknown"}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap ?? () => context.push('/patients/${patient.id}'),
      ),
    );
  }
}
```

---

## Core Module Structure

The core module contains shared functionality:

```
core/
├── assets/
│   └── i18n/                    # Localization files
│       ├── strings.i18n.json
│       └── strings_es.i18n.json
│
├── controllers/                 # Global state providers
│   ├── auth_controller.dart
│   └── theme_controller.dart
│
├── extensions/                  # Dart extensions
│   ├── context_extensions.dart
│   └── string_extensions.dart
│
├── hooks/                       # Custom Flutter hooks
│   └── use_debounce.dart
│
├── models/                      # Shared models
│   ├── failure.dart             # Error handling
│   ├── pb_record.dart           # PocketBase base class
│   └── pb_repository.dart       # Repository interface
│
├── packages/                    # Third-party integrations
│   ├── pocketbase/
│   │   └── pb_provider.dart
│   └── storage/
│       └── storage_provider.dart
│
├── pages/                       # Global pages
│   ├── app_root.dart            # Main shell
│   └── error_page.dart
│
├── routing/                     # Navigation
│   ├── router.dart              # GoRouter configuration
│   └── routes/                  # Route definitions by domain
│       ├── _root.routes.dart
│       ├── organization.routes.dart
│       ├── patients.routes.dart
│       ├── products.routes.dart
│       └── system.routes.dart
│
├── utils/                       # Utilities
│   ├── constants.dart
│   ├── validators.dart
│   └── formatters.dart
│
└── widgets/                     # Shared UI components
    ├── adaptive_shell.dart
    ├── loading_overlay.dart
    ├── error_view.dart
    └── form_fields/
        ├── date_picker_field.dart
        └── dropdown_field.dart
```

---

## Domain Groups

Features are organized into domain groups:

```
features/
├── organization/           # Business structure
│   ├── branches/
│   ├── users/
│   └── user_roles/
│
├── patients/               # Patient management
│   ├── patients/
│   ├── patient_records/
│   ├── patient_files/
│   ├── prescriptions/
│   └── config/
│       ├── species/
│       ├── breeds/
│       └── treatments/
│
├── products/               # Inventory management
│   ├── products/
│   ├── product_categories/
│   ├── inventories/
│   ├── product_stocks/
│   └── stock_adjustments/
│
├── appointments/           # Scheduling
│   └── appointments/
│
├── sales/                  # Point of sale
│   └── cashier/
│
└── system/                 # System configuration
    ├── settings/
    └── change_logs/
```

---

## Routing Structure

Routes are organized by domain with type-safe navigation:

```dart
// router.dart
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AdaptiveShell(child: child),
      routes: [
        ...organizationRoutes,
        ...patientRoutes,
        ...productRoutes,
        ...appointmentRoutes,
        ...salesRoutes,
        ...systemRoutes,
      ],
    ),
  ],
);

// patients.routes.dart
@TypedGoRoute<PatientsRoute>(
  path: '/patients',
  routes: [
    TypedGoRoute<PatientRoute>(path: ':id'),
    TypedGoRoute<PatientFormRoute>(path: 'form'),
  ],
)
class PatientsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const PatientsPage();
}
```

---

## File Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Features | `snake_case` | `patient_records/` |
| Files | `snake_case.dart` | `patient_card.dart` |
| Pages | `*_page.dart` | `patients_page.dart` |
| Forms | `*_form_page.dart` | `patient_form_page.dart` |
| Widgets | Descriptive name | `patient_card.dart` |
| Controllers | `*_controller.dart` | `patient_controller.dart` |
| Repositories | `*_repository.dart` | `patient_repository.dart` |
| Models | Entity name | `patient.dart` |
| Routes | `*.routes.dart` | `patients.routes.dart` |

---

## Code Generation

The project uses build_runner for code generation:

```bash
# Run all generators
dart run build_runner build --delete-conflicting-outputs
```

**Generated Files:**
- `*.mapper.dart` - dart_mappable serialization
- `*.g.dart` - Riverpod providers
- `*.routes.dart` - Type-safe routes
- `strings.g.dart` - Localization

**Generator Annotations:**
- `@MappableClass()` - Entity serialization
- `@riverpod` - Provider generation
- `@TypedGoRoute` - Route generation

---

## Summary

| Aspect | Pattern |
|--------|---------|
| Architecture | Feature-based Clean Architecture |
| State Management | Riverpod with AsyncNotifier |
| Navigation | GoRouter with type-safe routes |
| Backend | PocketBase (BaaS) |
| Serialization | dart_mappable |
| Forms | flutter_form_builder |
| Error Handling | Either<Failure, T> |
| Localization | slang |
