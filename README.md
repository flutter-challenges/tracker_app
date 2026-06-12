# Tracker App

A professional Flutter application for managing live tracking sessions, adding participants, updating scores, and determining the winner in real time.

## Overview

This project showcases a clean and scalable Flutter architecture using:
- Flutter + Dart
- Bloc / Cubit for state management
- ScreenUtil for responsive and adaptive UI design
- A layered folder structure: data, managers, and presentation

The application follows a simple and efficient user flow:
1. Start a new session
2. Add participants
3. Switch between players
4. Increase scores interactively
5. Finish the session and reveal the winner

---

## App Flow

The application is designed around a clear state-driven flow:

- Initial state: the user sees the start screen.
- Active state: the session begins and the score tracker becomes interactive.
- Ended state: the final winner is calculated and shown in a dialog.

The current flow of the application is organized as follows:

1. App starts from the main entry point.
2. The root widget initializes the app and loads the tracker view.
3. The session view uses a Cubit to manage the lifecycle of the current session.
4. The user starts a session, adds participants, and updates scores.
5. When the session ends, the app calculates the winner and shows a result dialog.

### Flow Summary

```text
main.dart
  -> TrackerApp
    -> TrackerAppView
      -> BlocProvider(GameSessionCubit)
        -> TrackerInitialView
        -> TrackerActiveView
          -> AddPersonTextField
          -> PersonsSwitchersWidget
          -> SessionTimer
          -> ArrowWidget
```

This flow makes the app easy to understand, extend, and maintain.

---

## Project Structure

The project follows a modular organization to keep logic, UI, and data clearly separated.

```text
lib/
  main.dart
  tracker_app/
    tracker_app.dart
    session_feature/
      data/
        models/
          session_model.dart
      managers/
        game_session_cubit/
          game_session_cubit_cubit.dart
          game_session_cubit_state.dart
      presentation/
        views/
          tracker_app_view.dart
          tracker_active_view.dart
          tracker_initial_view.dart
        widgets/
          add_person_text_field.dart
          arrow_widget.dart
          person_tacker.dart
          persons_switchers_widget.dart
          session_timer.dart
```

### Folder Responsibilities

- data/models
  Stores the session model that holds participants, scores, start/end time, and winner data.

- managers/game_session_cubit
  Contains the Cubit and state classes responsible for session lifecycle, score updates, player switching, and session termination.

- presentation/views
  Contains the main UI screens for the initial and active session states.

- presentation/widgets
  Contains reusable UI widgets such as the timer, participant controls, arrows, and score display elements.

---

## Tech Stack & Packages

| Package | Purpose |
|---|---|
| flutter | Core Flutter framework for building the app UI |
| flutter_bloc | Bloc-based UI state management and reactive rendering |
| bloc | Core state management package used by Cubit |
| flutter_screenutil | Responsive UI scaling across multiple device sizes |
| cupertino_icons | Default iOS-style icon set |
| flutter_test | Testing support for widget and integration validation |
| flutter_lints | Official linting rules for clean and consistent code |

---

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Run the app

```bash
flutter run
```

### 3. Run tests

```bash
flutter test
```

---

## Current Notes

- The current version uses an in-memory session flow and does not yet persist session data to a database or remote backend.
- The architecture is designed to be easy to extend for future features such as:
  - session history
  - local storage
  - export/share results
  - animations and better dashboard design

---

## Recommended Development Approach

For future improvements, follow this pattern:
1. Update or extend the Cubit logic in the managers layer.
2. Keep UI changes inside the presentation layer.
3. Keep session data models in the data layer.
4. Test the main session behavior before adding new features.

This structure keeps the codebase clean, maintainable, and ready for future feature expansion.
