# E-commerce Mobile App - Task 7

This project is a simple e-commerce mobile application built with Flutter. It demonstrates key front-end principles, including UI design based on Figma mockups, state management for a temporary data source, and a complete navigation flow.
## Functionality
The app implements the core CRUD (Create, Read, Update, Delete) operations for products with a focus on the user interface and local state management.
- View Products:The home screen displays a list of all available products.
- View Product Details: Tapping on a product navigates to a dedicated detail screen showing its full information.
- Add Products: Users can navigate to a form to add new products to the list.
- Update Products: From the detail screen, users can navigate to an edit form that comes pre-filled with the product's data.
- Delete Products: Products can be deleted directly from the detail screen.
- Navigation: The app uses named routes for clean and manageable navigation between all screens.
- Data Passing:Data is passed forward to detail/edit screens and results (like updated or deleted items) are passed backward to the home screen to ensure the UI is always in sync.
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

## Additional Information

- Data Source:This project uses a temporary, in-memory list** of products for demonstration purposes. There is no backend or database connection. All added, updated, or deleted products will be lost when the app is restarted.
- CRUD Operations: The Add, Update, and Delete functionalities are fully implemented from a visual and state management perspective, correctly updating the UI in real-time without requiring a database.
- Search Page: The UI for the search page and its filter panel is included, but the search and filter logic is not yet connected to the data source.