# TickMe - AI Coding Instructions

## Project Overview
TickMe is a Flutter task tracker app with time tracking capabilities. It uses **Riverpod for state management**, **SQLite for persistence**, and **persistent_bottom_nav_bar_v2 for navigation**. The app tracks time entries by category with start/end times, supports CSV export, and includes localization.

**Architecture Philosophy**: Follows Clean Architecture principles with clear separation of concerns between models, providers, services, and UI layers.

## Architecture & Key Patterns

### State Management - Riverpod with Code Generation
- **Critical**: Use `@riverpod` annotation with `part` files for generated providers
- Generated files go in `providers/generated/` and `models/generated/` (configured in `build.yaml`)
- Run `dart run build_runner build` after adding new providers/models
- Key providers:
  - `TickCategories`: Manages task categories, persisted to SharedPreferences as JSON
  - `DatabaseState`: Manages time entries with SQLite integration, auto-refreshes on time range changes
  - `ActiveTimer`: Tracks currently running timer state

### Database Layer
- **SQLite via sqflite**: Database service in `lib/services/database_service.dart`
- Single table `time_entries` with `categoryId`, `startTime`, `endTime`
- Time entries filtered by date range from `TimeRangeNotifier`
- **Pattern**: Always call `DatabaseService` methods through providers to trigger UI updates

### Models with JSON Serialization
- Use `@JsonSerializable()` for data classes
- Custom serializers for complex types (Color, IconPickerIcon in `TickCategoryModel`)
- Generated files: `part 'generated/model_name.g.dart'`

### Navigation Structure
- **persistent_bottom_nav_bar_v2** with persistent bottom navigation (3 tabs: Home, Stats, Settings)
- Main navigation widget in `app_navigation.dart`: `AppNavigation` wraps `PersistentTabView`
- **Pattern**: Navigation is handled by the bottom nav bar; each tab has its own navigation stack
- Tabs persist state when switching between them

### Localization Setup
- ARB files in `lib/l10n/` with `app_en.arb` as template
- Custom extension: `context.loc.key_name` (see `app_localizations_context.dart`)
- Configured via `l10n.yaml` with code generation

## Development Workflows

### Code Generation Commands
```bash
# Generate providers, models, and localizations
dart run build_runner build

# Watch mode for development
dart run build_runner watch
```

### Project Structure Rules
- **Providers**: Business logic and state management in `lib/providers/`
- **Models**: Data classes with JSON serialization in `lib/models/`
- **Services**: Pure business logic (no UI dependencies) in `lib/services/`
- **Screens**: UI components in `lib/screens/`
- **Common**: Shared utilities, themes in `lib/common/`

### UI Design System - Moon Design (CRITICAL)
- **NEVER use Material or Cupertino widgets** - Moon Design System is mandatory
- Current codebase contains legacy Material widgets that need refactoring
- All new UI components must use Moon widgets from `moon_design` package
- Example pattern: Use `MoonButton` instead of `ElevatedButton`, `MoonTextField` instead of `TextField`

### Key Dependencies & Patterns
- **moon_design**: UI component library - **STRICT REQUIREMENT** for all UI components
- **fl_chart**: For statistics visualization
- **flutter_iconpicker**: Category icon selection with custom icon packs in `lib/common/icon_pack.dart`
- **share_plus**: CSV export sharing functionality
- **uuid**: Generate unique IDs for categories

### Data Flow Pattern
1. UI consumes providers via `ref.watch()`
2. User actions call provider methods via `ref.read().method()`
3. Providers update SQLite via `DatabaseService`
4. Database changes trigger UI rebuilds through provider watchers

### Common Pitfalls to Avoid
- Don't directly manipulate SQLite - always go through `DatabaseState` provider
- Remember to run build_runner after adding `@riverpod` or `@JsonSerializable` annotations
- Use `keepAlive: true` for providers that should persist across widget rebuilds
- Categories are stored in SharedPreferences as JSON, not SQLite

### Testing Requirements
- **Comprehensive Testing**: All new features require tests
  - **Unit Tests**: For providers and services business logic
  - **Widget Tests**: For UI components
  - **Integration Tests**: For complete user flows
- **High Coverage**: Strive for comprehensive test coverage
- Test files follow standard Flutter patterns: `test/` directory structure

### Code Quality Standards
- **Dart Style Guide**: Follow official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- **Linting**: Adheres to `flutter_lints` rules in `analysis_options.yaml`
- **Immutability**: Prefer immutable data structures and classes
- **Comments**: Document complex logic, algorithms, and non-obvious code
- **KISS & DRY**: Keep code simple, avoid duplication with shared components

### Version Control & Commits
- **Conventional Commits**: Use format like `feat:`, `fix:`, `docs:`, `refactor:`
- **Atomic Commits**: Each commit represents a single logical change
- **Code Reviews**: All code must be reviewed before merging to main branch