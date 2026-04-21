# ScotiabankTestApp

## Overview

This project is a SwiftUI-based iOS application that displays a list of transactions and allows users to view detailed information for each transaction. The app is designed with a focus on scalability, clean architecture, and testability.

---

## Features

* Display a list of transactions loaded from a local JSON file
* Navigate to a transaction detail screen on selection
* Detail screen includes:

  * Confirmation checkmark
  * Transaction details
  * Expandable/collapsible tooltip component
* Close button to dismiss detail view and return to list
* Clean and reusable UI components
* Unit test coverage for core logic

---

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture:

* **Models**: Data structures representing transactions
* **Views**: SwiftUI views for UI rendering
* **ViewModels**: Business logic and state management
* **Services**: Responsible for data loading (local JSON in this case)

### Key Design Decisions

* **Separation of concerns** to ensure maintainability
* **Dependency injection** for improved testability
* **Reusable components** (e.g., TransactionRowView, TooltipView)
* **Lightweight networking abstraction** (even though local JSON is used)

---

## Project Structure

```
.
├── Features/
│   └── Transactions/
│       ├── Views/
│       ├── ViewModels/
│       └── Models/
├── Core/
│   └── Services/
├── Resources/
│   └── transaction-list.json
├── Tests/
└── README.md
```

---

## Technologies Used

* Swift 6
* SwiftUI
* XCTest (Unit Testing)

---

## Data Source

* Transaction data is loaded from a local file:

  * `transaction-list.json`
* A resource loader/service is used to simulate a network layer

---

## How to Run

1. Open the project in **Xcode**
2. Build and run the app on a simulator or physical device

---

## Testing

* Unit tests are included to validate:

  * Data loading
  * ViewModel logic
* Tests can be executed using:

  * `Cmd + U` in Xcode

---

## Notes

* The app is structured to easily replace the local JSON loader with a real API service
* Emphasis has been placed on readability, modularity, and scalability
* Minimal UI complexity with focus on clean layout and usability

---

## Possible Improvements

* Add UI tests
* Integrate real API with error handling
* Add caching layer
* Improve accessibility support
* Enhance animations and transitions

---

## Author

[Thomas Varghese]
# ScotiabankTestApp
Scotiabank assessment
