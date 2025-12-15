# smart_education_system

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



=======================


🚀 Flutter Project Setup & Run Guide


📁 Step 1: Create a New Flutter Project
flutter create productlisting

📦 Step 2: Add Dependencies
Use the following command to add the GetX package for state management and navigation:

flutter pub add get

Step 3: Get All Packages
After adding dependencies, run:

flutter pub get


Step 4: Launch Emulator

Check and launch available Android emulators:
flutter emulators --launch Pixel_7


Step 5: Run the Flutter App
Run the application on the launched emulator:

flutter run -d emulator-5554


Step 6: Reload Options During Development

| Action      | Description                                   | Command |
| :---------- | :-------------------------------------------- | :------ |
| Soft Reload | Reloads UI changes (faster)                   | `r`     |
| Hot Reload  | Reloads with more depth (logic/state updates) | `R`     |


Step 7: Clean & Rebuild Project

If you face dependency or build errors, clean and rebuild your project:

flutter clean
flutter pub get

Step 8: Build Release APK
To generate a release version of your app (for distribution or upload):

flutter build apk --release