# Todo Analytics App (Flutter + Firebase)

## Overview

This repository contains a simple mobile Todo application built with Flutter. The primary goal of the project is to demonstrate **mobile analytics instrumentation**, **user behavior tracking**, and **metric calculation** using **Firebase Analytics**.

The emphasis of this task is on analytics design and validation rather than advanced UI design or backend integration.

---

## Objectives

This project demonstrates how to:

- Integrate a mobile analytics tool (Firebase Analytics)
- Track user interactions and navigation flows
- Track core business actions across a task lifecycle
- Measure session behavior
- Compute meaningful product metrics
- Interpret analytics data to derive product insights

---

## Tech Stack

- Flutter (mobile application framework)
- Firebase Analytics (user behavior tracking)
- Android physical device for testing and validation

Desktop platforms are intentionally excluded, as Firebase Analytics is not supported on Flutter desktop targets.

---

## Application Features

### Core Features

- Add tasks
- Update task titles
- Complete and uncomplete tasks
- Delete tasks
- Developer metrics screen

### UX Decisions

- Completed tasks are treated as immutable and cannot be edited
- Task completion is modeled as a state change rather than deletion

---

## Analytics Instrumentation

Analytics concerns are separated into four distinct layers.

### 1. App Lifecycle Tracking

Tracked using Flutter lifecycle observers:

- app\_opened
- session\_start
- session\_end

These events are used to calculate:

- Average session length
- App open frequency

---

### 2. Navigation Tracking

Navigation tracking is implemented using a global `NavigatorObserver`, allowing automatic screen view logging without coupling analytics logic to UI widgets.

Tracked screens include:

- TaskList
- AddTask
- Metrics

---

### 3. UI Interaction Events

UI interaction events represent **user intent**, not business outcomes.

Examples include:

- open\_add\_task
- toggle\_task\_completion
- update\_task
- delete\_task
- open\_metrics

These events indicate what the user attempted to do.

---

### 4. Business (Task Lifecycle) Events

Business events represent **confirmed state changes** and are emitted only after successful operations.

Tracked events include:

- task\_added
- task\_updated
- task\_completed
- task\_deleted

These events represent actual value-generating actions within the app.

---

## Metric Calculation

To avoid relying solely on Firebase dashboards, key metrics are calculated locally from raw event data. This approach improves transparency and makes metrics easier to validate during development.

### Metrics Implemented

**Average Session Length**

```
(total session duration) / (number of sessions)
```

**Feature Adoption Rate**

```
task_added_count / total_interactions
```

**Frequency Score**

```
number of app launches within a defined time window
```

---

## Analytics Validation

Analytics behavior was validated using the following approach:

- Firebase DebugView for real-time event inspection
- Testing on a real Android device
- Explicitly enabling analytics debug mode via ADB

```bash
adb shell setprop debug.firebase.analytics.app <applicationId>
```

This setup was used to confirm event firing, parameters, and session boundaries.

---

## Insights and Observations

### User Flow

Observed navigation patterns indicate that most users follow the flow:

TaskList → AddTask → TaskList

Some users drop off on the AddTask screen, indicating potential friction during task creation.

### Key Insight

Users who complete at least one task early in their first session tend to continue using the application.

### Suggested Improvement

To reduce initial friction, the following improvements are suggested:

- Automatically focus the task input field on first launch
- Provide an example placeholder such as “Buy groceries” to guide first-time users

---

## Security and Repository Hygiene

The following files are intentionally excluded from version control:

- android/app/google-services.json
- Generated build and cache files

Firebase secrets are never committed to the repository.

---

## How to Run (Android)

1. Configure Firebase using the FlutterFire CLI
2. Connect an Android device with USB debugging enabled
3. Run the application:

```bash
flutter pub get
flutter run
```

4. Enable Firebase Analytics DebugView:

```bash
adb shell setprop debug.firebase.analytics.app <applicationId>
```

---

## Task Completion Status

All development requirements from the task specification have been implemented:

- Mobile application implemented
- Firebase Analytics integrated
- User interaction and navigation tracking
- Task lifecycle event tracking
- Session and frequency metrics
- Analytics validation and insight generation

---

##

