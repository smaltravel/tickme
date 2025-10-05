# Gemini CLI Instructions

## 1. Project Overview

This is a Flutter project for "TickMe," a time-tracking and personal time management application. The goal is to build a high-quality application following best practices in software development.

## 2. Architecture & Design

- **Clean Architecture:** We adhere to Clean Architecture principles to separate concerns and create a scalable and maintainable codebase.
- **State Management:** We use Riverpod for state management. All new features should use Riverpod providers for managing the application state.
- **Directory Structure:** Maintain the existing directory structure by separating code into `models`, `providers`, `screens`, `services`, and `common`.

## 3. UI/UX

- **Design System:** We strictly follow the [Moon design system](https://github.com/coingaming/moon_flutter).
- **No Material/Cupertino:** Do not use generic Material or Cupertino widgets. All UI components should be from the Moon design system library.
- **UI Refactoring:** The current UI contains Material Design elements that need to be refactored. All new or modified UI code must use the Moon design system.

## 4. Coding Style & Quality

- **Dart Style:** Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style).
- **Linting:** Adhere to the linting rules defined in `analysis_options.yaml`.
- **Immutability:** Prefer immutable data structures and classes where possible.
- **Comments:** Add comments to explain complex logic, algorithms, or any non-obvious parts of the code.

## 5. Testing

- **Comprehensive Testing:** All new features must be accompanied by tests. This includes:
    - **Unit Tests:** For business logic in providers and services.
    - **Widget Tests:** For UI components.
    - **Integration Tests:** For user flows and end-to-end testing.
- **High Code Coverage:** Strive for high test coverage to ensure the reliability of the application.

## 6. Commits & Version Control

- **Conventional Commits:** Use conventional commit messages (e.g., `feat:`, `fix:`, `docs:`, `refactor:`). This helps in generating changelogs and understanding the history of the project.
- **Atomic Commits:** Each commit should represent a single logical change.

## 7. General Best Practices

- **Keep it Simple (KISS):** Write simple, clear, and concise code.
- **Don't Repeat Yourself (DRY):** Avoid code duplication by using shared widgets, functions, and services.
- **Code Reviews:** All code should be reviewed before being merged into the main branch.