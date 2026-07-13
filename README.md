# E-commerce Mobile App (Clean Architecture)

This project is a simple e-commerce mobile application built with Flutter. It is structured following the principles of **Clean Architecture** to ensure a clean separation of concerns, making the codebase scalable, maintainable, and highly testable.

The application allows users to perform full CRUD (Create, Read, Update, Delete) operations on a list of products.

---

## Architecture Overview

The project is divided into three distinct layers, organized by feature under the `lib/features` directory. This ensures that each feature is a self-contained module.

### 1. Presentation Layer
- Location: `lib/features/product/presentation/`
- Responsibility:Contains all UI-related components, such as pages (widgets) and local UI state management. It is responsible for displaying data to the user and capturing user input. It interacts only with the Domain layer through Use Cases.

### 2. Domain Layer
- Location:`lib/features/product/domain/`
- Responsibility: This is the core of the application, containing the business logic and rules, completely independent of the UI and data sources.
    - Entities: Pure data objects that represent the core business concepts (e.g., `ProductEntity`).
    - Repositories (Abstract):Defines the "contract" or interface for the data layer, specifying *what* data operations are possible without defining *how* they are implemented.
    - Use Cases:Encapsulates a single, discrete business action (e.g., `ViewAllProductsUsecase`, `CreateProductUsecase`).

### 3. Data Layer
- Location: `lib/features/product/data/`
- Responsibility: Responsible for all data retrieval and storage operations.
    - Models:Data Transfer Objects (DTOs) that are responsible for converting data to and from external sources (like JSON). They extend the domain entities.
    - Repositories (Implementation): The concrete implementation of the repository contract defined in the domain layer. This is where the actual data handling logic resides.
    - Data Sources:(Not yet implemented in this version) Would be responsible for the raw data fetching, such as making an HTTP request to an API or querying a local database.

---

## Data Flow

The dependencies in this architecture strictly point inwards, ensuring that the core business logic is completely decoupled.

**`Presentation` -> `Domain` <- `Data`**

1.  A UI event in the **Presentation Layer** calls a **Use Case** from the Domain Layer.
2.  The **Use Case** executes its business logic, calling a method from the abstract **Repository** in the Domain Layer.
3.  The **Data Layer** provides a concrete **Repository Implementation** that fulfills the request, fetching data from a Data Source.
4.  The data flows back out to the UI to be displayed.

---

## How to Run the App

### Prerequisites
- Flutter SDK (version 3.x or higher)
- An active Android emulator or a physical Android device with USB debugging enabled.
- A code editor like Android Studio or VS Code.

### Steps
1.  Clone the repository:
    ```bash
    git clone https://github.com/Edilawit-Manaye/2025-project-phase-mobile-tasks.git
    ```
2.  Navigate into the Flutter project directory:
    ```bash
    cd 2025-project-phase-mobile-tasks/mobile/EdilawitManaye/task6
    ```
3.  Get project dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the application:
    ```bash
    flutter run
    ```

---

## Test Coverage

Unit tests for the `ProductModel` are included to verify the correctness of the `fromJson` and `toJson` conversion logic. To run the tests, execute the following command from the project root:
```bash
flutter test