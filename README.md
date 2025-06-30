# TickMe - Task Tracker App

**A simple task tracker app designed for ease of use.**

This project uses Riverpod as its state management solution.

## Getting Started

### Prerequisites

* Dart SDK (version 3.0 or higher)
* Riverpod library
* Database (likely SQLite, based on the code)

### Project Setup

1. **Clone the Repository:**

    ```bash
    git clone git@github.com:smaltravel/tickme.git
    cd tickme
    ```

2. **Set up the Environment:**
    * Ensure you have Dart installed and configured correctly.
    * The project utilizes Riverpod, so ensure you're familiar with its concepts.

## Project Structure

The project is structured with the following key files and directories:

* `lib/`: Contains the core application logic.
* `lib/services/`: Contains services that encapsulate business logic.
* `lib/providers/`: Contains Riverpod providers for state management.
* `lib/screens/`: Contains UI screens.
* `lib/l10n/`: Contains localization files.

## Key Features

* **Task Management:**  The core functionality allows you to define tasks with start and end times.
* **Category Support:** Tasks can be categorized, providing organization. (Implemented with a `TickCategoriesStorage` provider).
* **CSV Export:**  A function to export the task data to a CSV file.

## Riverpod Providers (Important)

The project leverages Riverpod for state management.  Here are some key providers you'll encounter:

* `TickCategoriesProvider`:  Manages the list of available task categories. (derived from `tick_categories_provider.g.dart`)
* `TimeRangeNotifier`: Manages the Start and End Time of the tasks. (derived from `time_range_provider.g.dart`)
* `CsvExportService`: Handles the export of task data to a CSV file.
* `sharedPreferencesProvider` This provider should be used to store the supported locales, and potentially other settings.

## Contributing

We welcome contributions to this project!  Please follow these guidelines:

1. Create an issue to discuss your proposed changes.
2. Fork the repository.
3. Make your changes.
4. Submit a pull request.
