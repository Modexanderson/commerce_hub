# 🛒 Commerce Hub

**Commerce Hub** is a full-featured shopping application built with **Flutter**. It showcases products, categories, banners, and payment options using clean architecture and reusable UI components. The app integrates asset images, animations, and Firebase for backend functionality.

---

## 🌟 Features

* 🔥 Stunning product & category banners
* 👕 Product listings with detailed pages
* 🛍️ Add to cart and order flow
* 🔐 Firebase integration (Auth, Firestore)
* 📦 Order success and tracking screens
* 💳 Payment options (Visa, PayPal, Apple Pay, etc.)
* 🖼️ Smooth onboarding with splash images

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Dart
* Firebase CLI (optional, for deployment or rules management)

### Installation

```bash
git clone https://github.com/Modexanderson/commerce_hub.git
cd commerce_hub
flutter pub get
```

### Firebase Setup

* Add your own `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the appropriate directories.
* Use `flutterfire configure` or replace values in `firebase_options.dart` accordingly.

---

## 📂 Project Structure

```
lib/
├── components/         # Reusable UI widgets
├── exceptions/         # Custom exceptions
├── helpers/            # Utility functions
├── models/             # Data models
├── screens/            # All UI screens (Home, Detail, Cart, etc.)
├── services/           # Firebase and backend services
├── theme/              # Theming and styling
├── wrappers/           # Layout wrappers and layout logic
├── app.dart            # App configuration
├── main.dart           # Entry point
```

---

## 📷 Screenshots

Place your images in `assets/images/` and reference them like this:

```markdown
![Home](assets/images/Image%20Banner%203.png)
![Product Detail](assets/images/Image%20Popular%20Product%201.png)
```

Ensure these are declared in your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

> 📌 Note: Screenshots will display properly if this repository is public. If private, host images externally (e.g., Imgur, Dropbox) or keep the repo public for sharing.

---

## 🧰 Tech Stack

* Flutter
* Firebase (Auth, Firestore)
* Dart
* Provider (for state management)

---

## ✅ TODO

* [ ] Complete payment gateway integration
* [ ] Add wishlist feature
* [ ] Add localization and RTL support
* [ ] Unit and widget testing

---

## 📬 Contact

Made with ❤️ by [Modexanderson](https://github.com/Modexanderson). Connect if you'd like to collaborate or give feedback!
