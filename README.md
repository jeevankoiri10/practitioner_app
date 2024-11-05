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

### 1. MVVM (Model-View-ViewModel)

**Description:** MVVM separates the UI (View) from the business logic (ViewModel), making the code modular and testable. In Flutter, this architecture is often implemented with Provider or Riverpod for state management.

**When to Use:** Apps with moderate to complex UI interactions where separation of UI and business logic is beneficial. MVVM provides flexibility and is easy to scale.

### 2. BLoC (Business Logic Component)

**Description:** BLoC architecture, powered by Streams and the `bloc` package, separates UI from business logic in a reactive, event-driven pattern. BLoC’s use of streams allows for efficient state management, making it suitable for applications that require responsiveness and real-time data updates.

**When to Use:** Applications with complex state management and asynchronous data flows, such as e-commerce apps or chat applications, where responsiveness is key.

### 3. Clean Architecture

**Description:** Clean Architecture promotes a strict separation between different layers of the application (Entities, Use Cases, Interface Adapters, and Frameworks). This architecture makes the codebase highly modular, flexible, and testable, which can ease future changes and scaling efforts.

**When to Use:** Large applications with complex business logic and high scalability needs, such as fintech or healthtech apps, where maintainability and adaptability are crucial.

### 4. Redux

**Description:** Redux is a unidirectional data flow architecture that uses a single store for centralized state management. It’s well-known for its predictability and debuggability, providing a clear structure that scales well for larger applications.

**When to Use:** Apps requiring consistent global state across multiple screens, such as social media or productivity apps. Redux is particularly useful in applications that need a single source of truth.

### 5. Provider with MVVM

**Description:** The Provider package is commonly used for state management in Flutter, especially when paired with MVVM. It allows for efficient dependency injection and state handling, which enhances modularity and scalability in the codebase.

**When to Use:** Ideal for apps that need scalable, easy-to-understand state management without the complexity of BLoC or Redux. It’s suited for startups looking for a simpler solution that still offers structure and testability.

## Third-party packages used

- `provider:` - used for the state management
- `cupertino_icons:` - for using the icons
- `flutter_form_builder:` - for building forms in the edit offering screen
- `form_builder_validators:`

## References:

- [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles by Robert C. Martin (Uncle Bob).
-
