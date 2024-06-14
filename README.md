# Firebase CRUD Notes App

This is a simple CRUD (Create, Read, Update, Delete) notes application built using Flutter and Firebase Firestore. It allows users to create, view, update, and delete notes.

## Features

- **Create Note**: Add a new note with a title and description.
- **Read Notes**: View all notes saved in Firestore.
- **Update Note**: Edit the title or description of an existing note.
- **Delete Note**: Remove a note from Firestore.

## Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/elnaddar/crud_firebase_notes_app.git
   cd crud_firebase_notes_app
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Set up Firebase:**
   
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android and iOS app to your Firebase project.
   - Follow the instructions to download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the respective directories.

4. **Run the app:**

   ```sh
   flutter run
   ```

## Deployment

The app is deployed using GitHub Pages. You can access it [here](https://elnaddar.github.io/crud_firebase_notes_app/).

## Usage

- Launch the app on your device or emulator.
- Add, view, edit, or delete notes as needed.
- All changes are synchronized with Firebase Firestore.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or suggestions, feel free to open an issue or contact the repository owner.
