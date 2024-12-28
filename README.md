# Task Management App

## Overview

This Task Management App is a simple app for managing tasks efficiently.
The app utilizes the BLoC (Business Logic Component) architecture for state management and SQLite for local data persistence.

## Features

- **Create New Task:** Easily add new tasks with titles, descriptions, start and end dates.
- **Edit and Delete Tasks:** Each tasks created can be edited and deleted.
- **Update status Tasks:** Modify the status of each task to track its progress.
- **Sort, filter and Search:** Sort tasks by due date or filter status, and search for specific tasks using keywords.
- **Error Handling:** The app includes error handling mechanisms to gracefully handle and display errors to users.

## Getting Started

## Technical Specifications

This project was developed using the following tools and technologies:

- **Flutter:** Flutter 3.7.12
- **Dart:** Dart 3.0.6
- **Android Studio:** Android Studio Flamingo | 2022.2.1 Patch 2
- **Android SDK:** Android 13 (API level 33)
- **Gradle:** Gradle 8.0
- **Java:** Java 11

### Prerequisites

- Ensure you have Flutter installed on your machine. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- Clone the repository to your local machine.

### Installation

1. Open a terminal and navigate to the project directory.

2. Run the following command to install dependencies:

   ```bash
   flutter pub get


Run the app on an emulator or physical device using the following command:

flutter run

### State Management
The app uses the Bloc architecture for efficient state management. Key Bloc classes include:

TasksBloc: Manages the overall state of tasks in the application.
TasksEvent: Represents events triggering state changes.
TasksState: Represents different states of the tasks, such as loading, success, or failure.


### List of Third-Party Libraries

Here is a list of third-party libraries used in this project:

- **flutter_bloc:** Used for state management with BLoC.
- **sqflite:** Used for local data persistence.
- **path_provider:** Used to obtain the local storage directory.
- **intl:** Used for date and time formatting.
- **get_it:** Used for dependency management.
- **mockito:** Used for unit testing.
- **bloc_test:** Used for integration testing.
- **flutter_test:** Used for UI testing.
- **connectivity_plus:** Used to detect network connectivity changes.
- **sp_util:** Used for shared preferences to store simple data locally.
- **flutter_svg:** Used to display SVG images.
- **table_calendar:** Used to display an interactive calendar widget.
- **top_snackbar_flutter:** Used to display snackbar messages at the top of the screen.
