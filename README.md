# 📝 Flutter Todo List

A professional task management application built with Flutter, featuring a clean architecture and industry best practices for state management and UI/UX.

---

## 📂 Project Structure

The project is organized into layers to ensure maintainability and scalability, as seen in the directory tree:

* **`lib/models/`**: Contains the `Todo` data class and logic for task objects.
* **`lib/pages/`**: Houses the main screens of the application, such as `TodoListPage`.
* **`lib/repositories/`**: Dedicated to data persistence and management (the bridge between UI and storage).
* **`lib/widgets/`**: Reusable UI components, including the custom `TodoListItem`.
* **`lib/main.dart`**: The entry point of the Flutter application.

---

## 🚀 Getting Started

### Prerequisites
* **Flutter SDK** installed (Stable channel).
* **Android/iOS Emulator** or a physical testing device.

### Installation
1.  **Clone the repository**
    ```bash
    git clone [https://github.com/anwar-machado/Flutter.git](https://github.com/anwar-machado/Flutter.git)
    ```
2.  **Navigate to the project folder**
    ```bash
    cd projects
    ```
3.  **Install dependencies**
    ```bash
    flutter pub get
    ```
4.  **Launch the application**
    ```bash
    flutter run
    ```

---

## 🛠️ Key Features & Technical Implementation

* **Flutter Slidable**: Integrated for intuitive "swipe-to-delete" actions on tasks.
* **Basic Clean Architecture**: Separation of concerns between UI, Models, and Repositories to keep code organized.
* **Form Validation**: Implementation of `GlobalKey<FormState>` to prevent empty task entries and improve UX.
* **Custom Widgets**: Modularized UI components for better code readability and reusability.

---

## 👤 Author

* **Anwar Machado** - [GitHub Profile](https://github.com/anwar-machado)

---

## 📈 Roadmap (Upcoming Improvements)
* [ ] Implement persistent storage using `shared_preferences`.
* [ ] Add Light and Dark mode support.
* [ ] Include a "Undo" feature after deleting a task.