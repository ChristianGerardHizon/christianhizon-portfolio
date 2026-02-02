# Hi-Zone Laundry - Application Overview

A comprehensive Flutter multi-platform laundry management system supporting Android, iOS, macOS, Linux, Windows, and Web.

---

## Table of Contents

1. [Features](#features)
2. [Core Functionality](#core-functionality)
3. [Domain Models](#domain-models)
4. [Key Screens](#key-screens)
5. [Integrations](#integrations)
6. [Navigation Structure](#navigation-structure)
7. [Architecture Patterns](#architecture-patterns)
8. [Project Structure](#project-structure)
9. [Technology Stack](#technology-stack)

---

## Features

### Primary Features (Main Navigation)

#### Appointments (`/appointments`)
Schedule and manage veterinary appointments.

- **Screens**: Appointments list, detail page, daily view, calendar integration
- **Statuses**: Scheduled, Completed, Missed, Cancelled
- **Controllers**:
  - `appointmentsController` - Main list
  - `paginatedAppointmentsController` - Filtered/paginated
  - `dailyAppointmentsController` - Today's appointments
  - `patientAppointmentsController` - Patient-specific

#### Patients (`/patients`)
Core feature for managing animal patients and medical records.

- **Sub-features**:
  - Patient List & Detail
  - Medical Records (diagnosis, treatment, tests)
  - Treatments tracking
  - Prescriptions per visit
  - Patient Files (documents, images, videos)
- **UI**: 6-tab interface (Overview, Details, Records, Treatments, Appointments, Files)
- **Key Models**: `Patient`, `PatientRecord`, `PatientTreatment`, `PatientPrescriptionItem`, `PatientFile`
- **Patient Files**:
  - Upload images (JPG, PNG, GIF, WEBP, HEIC), videos (MP4, MOV, AVI, WEBM), and PDFs
  - 10MB file size limit with client-side validation
  - Full-screen image viewer with zoom/pan (PhotoView)
  - Video player with playback controls
  - PDF viewer with external app launch
  - File management: upload, view, edit notes, delete

#### Products (`/products`)
Inventory and product management with lot tracking.

- **Sub-features**:
  - Products list with categories
  - Stock lots with FEFO (First-Expire-First-Out) tracking
  - Stock adjustments with audit trail
  - Hierarchical category organization
- **Key Models**: `Product`, `ProductCategory`, `ProductLot`, `ProductAdjustment`

#### Dashboard (`/`)
Home screen with quick summary and today's appointments.

- Responsive layout (single column mobile, two-pane tablet)
- Quick summary cards
- Today's appointments section

---

### Secondary Features

#### Point of Sale / Cashier (`/cashier`)
Complete POS system for processing sales.

- **Features**:
  - Product grid with search and category filtering
  - Shopping cart management
  - Lot selection with FEFO ordering for lot-tracked products
  - Multiple payment methods (cash, card, check, etc.)
  - Receipt generation and printing
- **Components**:
  - `ProductGrid` - Product selection
  - `CartView` - Shopping cart
  - `CheckoutSheet` - Payment processing
  - `LotSelectionSheet` - FEFO lot selection
  - `ReceiptSheet` - Receipt display/print

#### Sales History (`/sales`)
View and manage completed transactions.

- Paginated sales history with search
- Sale status display (pending, completed, refunded, cancelled)
- Detailed sale view with items and payment info

#### Messages (`/messages`)
Communication system for appointments and follow-ups.

- Send appointment reminders
- Message templates for quick messaging
- Template selector in appointment sheets

#### Treatment Plans (`/treatment-plans`)
Plan and track multi-visit treatment courses.

- Create treatment plans with scheduled items
- Track treatment progress per patient
- Reschedule treatment items
- Treatment templates for quick creation

---

### Organization/Admin Features

#### Organization (`/organization`)
3-panel tablet layout for managing organizational settings.

**Layout** (tablet):
- Panel 1 (80px): Navigation rail with icon + text labels
- Panel 2 (320px): List panel (users, roles, or branches)
- Panel 3 (expanded): Detail panel or empty state

**Modes:**
- **Users** (`/organization/users`) - User CRUD, role assignment, branch association
- **Roles** (`/organization/roles`) - Role and permission management (Admin, Veterinarian, Staff, Cashier)
- **Branches** (`/organization/branches`) - Multi-location support with address and contact info

#### System Settings (`/system`)
3-panel tablet layout for system configuration.

**Layout** (tablet):
- Panel 1 (80px): Navigation rail with icon + text labels
- Panel 2 (320px): List panel (species, categories, or templates)
- Panel 3 (expanded): Detail panel or empty state

**Modes:**
- **Species & Breeds** (`/system/species`) - Pet species catalog with breeds linked to species
- **Product Categories** (`/system/product-categories`) - Hierarchical product categories
- **Message Templates** (`/system/message-templates`) - Pre-defined messages for appointments

---

### Authentication (`/auth`)

- Splash screen
- Login page
- Password recovery
- Session management

---

## Core Functionality

Located in `/lib/src/core/`

### Routing (`/core/routing/`)
- GoRouter configuration with auth redirects
- Route files organized by domain
- Shell-based routing with nested subroutes

### PocketBase Integration (`/core/packages/pocketbase/`)
- `pocketbase_provider.dart` - Singleton instance
- `pocketbase_collections.dart` - Collection name constants
- `pb_filter.dart` - Query filter helpers
- `pb_expand.dart` - Relation expansion helpers

### Foundation (`/core/foundation/`)
- `failure.dart` - Standardized error handling
- `type_defs.dart` - Type aliases (`FutureEither<T>`, `Json`)
- `paginated_state.dart` - Pagination state management

### Shared Widgets (`/core/widgets/`)
- `mobile_bottom_nav.dart` - Bottom navigation
- `mobile_drawer.dart` - Mobile drawer
- `tablet_nav_rail.dart` - Tablet navigation rail
- `breadcrumb_nav.dart` - Breadcrumb navigation
- `cached_avatar.dart` - Avatar caching

### Utilities (`/core/utils/`)
- `breakpoints.dart` - Responsive breakpoints
- `currency_format.dart` - Money formatting
- `date_utils.dart` - Date utilities

---

## Domain Models

### 18+ Collections across 6 Domains

#### Organization Domain (3 collections)
| Collection | Description |
|------------|-------------|
| `User` | System users (all types) |
| `UserRole` | Role definitions with permissions |
| `Branch` | Business branches/locations |

#### Patient Domain (8 collections)
| Collection | Description |
|------------|-------------|
| `Patient` | Animal patients with owner info |
| `PatientSpecies` | Pet species catalog |
| `PatientBreed` | Breed catalog |
| `PatientRecord` | Medical visit records |
| `PatientFile` | Patient documents/images |
| `PatientTreatment` | Treatment type catalog |
| `PatientTreatmentRecord` | Treatment tracking |
| `PatientPrescriptionItem` | Medication prescriptions |

#### Product Domain (5 collections)
| Collection | Description |
|------------|-------------|
| `Product` | Products/inventory items |
| `ProductCategory` | Hierarchical categories |
| `ProductStock` | Stock lots with expiration |
| `ProductLot` | Batch/lot numbers (FEFO tracking) |
| `ProductAdjustment` | Stock change audit trail |

#### Appointment Domain (1 collection)
| Collection | Description |
|------------|-------------|
| `AppointmentSchedule` | Appointment bookings |

#### Sales Domain (3 collections)
| Collection | Description |
|------------|-------------|
| `Sale` | Transaction records |
| `SaleItem` | Items in transaction |
| `Cart` / `CartItem` | Shopping cart (temporary) |

#### Treatment Plans Domain (3 collections)
| Collection | Description |
|------------|-------------|
| `TreatmentTemplate` | Pre-defined treatment plans |
| `TreatmentPlan` | Multi-visit treatment course |
| `TreatmentPlanItem` | Individual treatment sessions |

### Enums
- `PatientSex` - male, female
- `PatientFileType` - image, video, document, unknown
- `ProductStatus` - inStock, outOfStock, lowStock, noThreshold
- `ProductAdjustmentType` - product, productStock
- `AppointmentScheduleStatus` - scheduled, completed, missed, cancelled
- `SaleStatus` - pending, completed, refunded, cancelled
- `PaymentMethod` - cash, card, check, etc.
- `ChangeLogType` - create, update, delete

---

## Key Screens

### Authentication
- Splash Screen (`/`)
- Login Screen (`/login/user`)
- Password Recovery (`/recovery`)

### Main Navigation
- **Dashboard**: Home with today's appointments
- **Patients List**: Browse all patients
- **Patient Detail**: 5-tab interface
- **Patient Record Detail**: Medical visit with prescriptions
- **Products List**: Browse products
- **Product Detail**: Stock and adjustments
- **Appointments List**: Filtered appointments
- **Appointment Detail**: Full appointment info
- **Cashier/POS**: Product grid and checkout
- **Sales List**: Transaction history
- **Sale Detail**: Receipt view

### Organization (3-panel layout)
- Users Management (list/detail)
- Roles Management (list/detail)
- Branches Management (list/detail)

### System Settings (3-panel layout)
- Species/Breeds Management (list/detail)
- Product Categories (list/detail)
- Message Templates (list/detail)

### Responsive Behavior
| Breakpoint | Layout |
|------------|--------|
| Mobile (< 600px) | Single-column, bottom nav, drawer |
| Tablet (600-900px) | Master-detail, navigation rail |
| Tablet Large (900-1200px) | Expanded rail, permanent side-by-side |
| Desktop (> 1200px) | Multi-panel, collapsible side menu |

---

## Integrations

### Backend: PocketBase
- **Type**: Open-source backend-as-a-service
- **Features**: Real-time database, authentication, file storage
- **Dev URL**: `http://127.0.0.1:8090`
- **Production**: `https://staging.sannjoseanimalclinic.com`

### State Management: Hooks Riverpod
- `@riverpod` annotation for providers
- `AsyncNotifier` for async state
- `FutureEither<T>` pattern for error handling
- Family providers for parameterized state

### Serialization: dart_mappable
- `@MappableClass()` decorator
- Automatic JSON serialization
- DTOs for API↔Domain mapping

### Forms: flutter_form_builder
- `FormBuilder` widget wrapper
- Specialized fields: TextField, Dropdown, DateTimePicker, ChoiceChips
- `FormBuilderValidators` for validation

### Navigation: GoRouter
- Type-safe routing with `@TypedGoRoute`
- Generated route extensions
- Auth redirect on route change

### Error Handling: fpdart
- `Either<Failure, T>` for error handling
- `TaskEither.tryCatch()` for async operations
- Centralized `Failure` class

---

## Navigation Structure

### Route Hierarchy

```
App Root (Shell)
├── Auth (non-shell)
│   ├── /splash
│   ├── /login/user
│   └── /recovery
│
└── Main Shell (with navigation)
    ├── / (Dashboard)
    ├── /patients
    │   ├── /patients (List)
    │   ├── /patients/:id (Detail)
    │   └── /patients/records/:id (Record Detail)
    ├── /appointments
    │   ├── /appointments (List)
    │   ├── /appointments/:id (Detail)
    │   └── /appointments/calendar
    ├── /products
    │   ├── /products (List)
    │   ├── /products/:id (Detail)
    │   ├── /products/categories
    │   └── /products/adjustments
    ├── /cashier (POS)
    ├── /sales
    │   ├── /sales (List)
    │   └── /sales/:id (Detail)
    ├── /messages
    ├── /organization (3-panel layout)
    │   ├── /organization/users
    │   │   └── /organization/users/:id
    │   ├── /organization/roles
    │   │   └── /organization/roles/:id
    │   └── /organization/branches
    │       └── /organization/branches/:id
    └── /system (3-panel layout)
        ├── /system/species
        │   └── /system/species/:id
        ├── /system/product-categories
        │   └── /system/product-categories/:id
        └── /system/message-templates
            └── /system/message-templates/:id
```

### Navigation Components

| Platform | Component | Description |
|----------|-----------|-------------|
| Mobile | Bottom Nav | 5 primary items |
| Mobile | Drawer | Full menu (7+ sections) |
| Tablet | Navigation Rail | Icons only (72px) |
| Tablet Large | Expanded Rail | Icons + labels (160px) |
| Desktop | Side Menu | Full collapsible menu |

#### 3-Panel Master-Detail Layouts (Tablet)
Organization and System sections use a 3-panel layout:

| Panel | Width | Content |
|-------|-------|---------|
| Panel 1 | 80px | Mode navigation rail (icon + text label) |
| Panel 2 | 320px | List panel with AppBar title and FAB |
| Panel 3 | Expanded | Detail panel or empty state |

- **Organization modes**: Users, Roles, Branches
- **System modes**: Species & Breeds, Product Categories, Message Templates

### Primary Navigation
1. 🏠 Dashboard - `/`
2. 👤 Patients - `/patients`
3. 📅 Appointments - `/appointments`
4. 📦 Products - `/products`

### Secondary Navigation
5. 💰 Sales - `/sales`
6. 🏢 Organization - `/organization`
7. ⚙️ System - `/system`

---

## Architecture Patterns

### Clean Architecture Layers
1. **Data Layer**: Repositories, DTOs, data sources
2. **Domain Layer**: Entities, business models
3. **Presentation Layer**: Pages, controllers, widgets

### State Management Pattern
- **List Controllers**: `@Riverpod(keepAlive: true)` for persistent lists
- **Single Entity Providers**: `@riverpod` for detail views
- **Family Providers**: Parameterized state with `build(String id)`

### Error Handling
- All operations return `FutureEither<T>`
- `TaskEither.tryCatch()` for async error handling
- Centralized `Failure` class

### DTO Pattern
```dart
// Create from PocketBase record
factory Dto.fromRecord(RecordModel record)

// Convert to domain entity
Entity toEntity()

// Static method for create payload
static Json toCreateJson(Entity entity)
```

### Naming Conventions
- **Plural** (`PatientsController`) = manages list
- **Singular** (`patientProvider`) = manages single entity
- Pages: `*_page.dart`
- Sheets: `*_sheet.dart`
- Routes: `*.routes.dart`

---

## Project Structure

```
lib/src/
├── core/
│   ├── routing/           # GoRouter configuration
│   ├── pages/             # Shell page (app_root.dart)
│   ├── widgets/           # Shared UI components
│   ├── packages/          # External integrations
│   ├── foundation/        # Base classes (Failure, type defs)
│   ├── utils/             # Utilities
│   ├── extensions/        # Dart extensions
│   ├── hooks/             # Custom Flutter hooks
│   ├── constants/         # App constants
│   └── assets/i18n/       # Localization
│
└── features/
    ├── auth/              # Authentication
    ├── dashboard/         # Home/dashboard
    ├── patients/          # Patient management
    ├── products/          # Inventory
    ├── appointments/      # Scheduling
    ├── pos/               # Point of sale
    ├── sales/             # Sales history
    ├── messages/          # Messaging
    ├── treatment_plans/   # Treatment planning
    ├── settings/          # System settings (species, categories, templates)
    ├── organization/      # Organization settings (3-panel layout)
    ├── users/             # User management
    └── user_roles/        # Roles/permissions
        │
        └── [feature]/
            ├── data/
            │   ├── repositories/
            │   └── dto/
            ├── domain/
            └── presentation/
                ├── controllers/
                ├── pages/
                └── widgets/
```

---

## Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Backend | PocketBase | BaaS, real-time database |
| Frontend | Flutter | Multi-platform UI |
| State Management | Riverpod + Hooks | Reactive state |
| Navigation | GoRouter | Type-safe routing |
| Forms | flutter_form_builder | Form handling |
| Serialization | dart_mappable | JSON mapping |
| Error Handling | fpdart | Functional Either/Task |
| Storage | flutter_secure_storage | Sensitive data |
| Localization | slang | i18n support |
| Code Gen | build_runner | Automatic generation |

---

## Recent Updates

| Date | Feature | Description |
|------|---------|-------------|
| Jan 24 | 3-Panel Layouts | Organization and System now use 3-panel tablet layouts with nav rail, list, and detail panels |
| Jan 24 | Branches Moved | Branches management moved from System to Organization section |
| Jan 24 | Nav Panel Labels | Navigation panels now show icon + text labels for better clarity |
| Jan 23 | Patient Files | Upload/view images, videos, PDFs with 10MB limit |
| Jan 21 | Lot Tracking | FEFO ordering in cashier |
| Jan 21 | Treatment Plans | Multi-visit treatment with edit |
| Jan 19 | Stock Adjustments | Audit trail for inventory |
| Jan 18 | Message Templates | Appointment message selector |
| Jan 16 | Sale Status | Improved display with icons |
