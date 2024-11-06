# practitioner_app using flutter

This project's goal is to create a basic holistic wellness application using flutter for practitioners who offers holistic services to its people. This consist of two main screens:

- Offerings List Screen
- Add/edit offering screen

Each practitioners can add offerings and will be shown to its user. Each offering should have:

- Practitioner Name (TextField)
- Title (TextField)
- Description (TextArea)
- Category (Dropdown with options like spiritual, mental, emotional)
- Duration (Textfield) or selectable options like 30 min or 1 hours
- Type (Radio buttons or toggle for in Person and Online)
- Price (Numeric Input)

## Architecture

**Architecture**: The structured framework that defines the organization, components, and relationships within a software system, guiding its development and maintenance.

### Why to use architectures

- **Separation of Concerns**: Distinct components for UI, logic, and data, reducing complexity.
- **Maintainability**: Easier updates and bug fixes with minimal risk of new issues.
- **Scalability**: Supports growth in features and user base without significant rewrites.
- **Testability**: Simplifies unit and integration testing of components.
- **Collaboration**: Provides a common understanding for team members, aiding onboarding.
- **Reusability**: Components can be reused, saving development time and effort.
- **Enhanced Performance**: Optimizes data flow and resource usage.
- **Adaptability**: Easier integration of new technologies and tools.
- **Documentation and Clarity**: Improves code understanding and maintenance.

In my research, I came across several architectures. After examining them, I have summarized the key ones below. While there are other notable architectures, these are the most popular and widely used for scalable mobile application development in startups.

#### 1. MVVM (Model-View-ViewModel)

**Description:** MVVM separates the UI (View) from the business logic (ViewModel), making the code modular and testable. In Flutter, this architecture is often implemented with Provider or Riverpod for state management.

#### 2. BLoC (Business Logic Component)

**Description:** BLoC architecture, powered by Streams and the `bloc` package, separates UI from business logic in a reactive, event-driven pattern. BLoC’s use of streams allows for efficient state management, making it suitable for applications that require responsiveness and real-time data updates.

#### 3. Clean Architecture

**Description:** Clean Architecture promotes a strict separation between different layers of the application (Entities, Use Cases, Interface Adapters, and Frameworks). This architecture makes the codebase highly modular, flexible, and testable, which can ease future changes and scaling efforts.

#### 4. Redux

**Description:** Redux is a unidirectional data flow architecture that uses a single store for centralized state management. It’s well-known for its predictability and debuggability, providing a clear structure that scales well for larger applications.

#### 5. Provider with MVVM

**Description:** The Provider package is commonly used for state management in Flutter, especially when paired with MVVM. It allows for efficient dependency injection and state handling, which enhances modularity and scalability in the codebase.

We can use any of the architecture listed above. But,
in my opinion **provider with MVVM** is the architecture that we have to use for making flutter mobile applications especially for the startups. Also, **clean architecture** is a good choice.

1.  Scalable architecture
2.  Simplicity and reliability
3.  Testability & Modularity
4.  Scalability and flexibility
5.  Efficient state management
6.  Easy to learn

## Third-party packages

- `provider:` - used for the state management
- `cupertino_icons:` - for using the icons
- `flutter_form_builder:` - for building forms in the edit offering screen
- `form_builder_validators:` - used for validating the forms used in the add/edit offering screen.
## Screenshots:

### Add Offering Screen
![1. Add Offering](https://github.com/user-attachments/assets/6b673cb1-0343-48d7-acfb-793b06381b9f)

### Display Offering List
![2. Display Offering List](https://github.com/user-attachments/assets/24f900c7-10f7-4dcd-99ca-56ea06863d29)

### Edit Offering Screen
![3. Edit Offering](https://github.com/user-attachments/assets/f554b10e-5ea9-47c9-91f5-c8aac321c378)

### Edit Offering Details
![4. Edit Offering Details](https://github.com/user-attachments/assets/344d5261-c03c-4b59-aeff-9a9445f46bc0)

### Offering Edited
![5. Offering Edited](https://github.com/user-attachments/assets/96dd9861-b8a2-48ee-aabd-1785df364b87)

### Delete Offering
![6. Delete Offering](https://github.com/user-attachments/assets/72872334-ad20-4fd0-9104-f43982e4e6ad)

### Theme Selection
![7. Theme Selection](https://github.com/user-attachments/assets/47652f86-fdd4-4064-838f-c350288d5fe0)

### Directory Structure
![Directory Structure](https://github.com/user-attachments/assets/1136221b-5e51-45f7-8f3d-8ef7b435b677)



## References:

- [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles by Robert C. Martin (Uncle Bob).
- [A Viable Architecture choice](https://medium.com/capyba/a-viable-architecture-choice-for-real-world-projects-in-flutter-579c8f715a1f) for real world projects in Flutter
