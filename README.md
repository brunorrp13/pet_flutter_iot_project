# 🐾 Flutter IoT Pet App

A feature-rich Flutter app simulating an IoT-enabled pet monitoring and interaction experience. Built with Riverpod, WebSockets, GraphQL, Bluetooth, and device sensors, this app is a great starting point for building real-time, interactive Flutter + IoT applications.

---

## 📦 Features

- 🐶 **Pet Status Monitoring**
  - Name, status, and profile image (randomized from Dog CEO API)
- 📍 **Live IoT Device Data**
  - Battery level (via simulated Bluetooth device)
  - Heart rate and temperature (streamed in real-time)
  - GPS location using `geolocator`
  - Firmware version simulation
- 🔊 **Voice Command Simulation**
  - "Feed" command with state transitions
- 📡 **MQTT Sync Simulation**
  - Manual connect/disconnect with status indicator
- ☁️ **Cloud Sync Simulation**
- 💬 **WebSocket Communication**
  - Send/receive real-time messages
- 🌐 **GraphQL Country List**
  - Fetches countries and capitals using the `countries.trevorblades.com` API
- 🧪 **Modular and Testable Architecture**
  - Riverpod-powered, clean separation of concerns (Repository, UseCase, Providers, Widgets)

---

## 🔧 Tech Stack

| Area              | Package / Technology                          |
|-------------------|-----------------------------------------------|
| **State Mgmt**    | [Riverpod](https://riverpod.dev/)             |
| **Bluetooth**     | [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus) |
| **GraphQL**       | [graphql_flutter](https://pub.dev/packages/graphql_flutter) |
| **WebSocket**     | [web_socket_channel](https://pub.dev/packages/web_socket_channel) |
| **Permissions**   | [permission_handler](https://pub.dev/packages/permission_handler) |
| **Location**      | [geolocator](https://pub.dev/packages/geolocator) |
| **UI**            | Material Design, Responsive Layouts           |

---

## 🚀 Getting Started

### 1. Prerequisites

- Flutter 3.10+
- Dart 3.x
- Android/iOS emulator or real device with Bluetooth

### 2. Install Dependencies

```bash
flutter pub get```

---

### 3. 📱 Screenshots

<img width="364" height="822" alt="image" src="https://github.com/user-attachments/assets/acffc3ea-7adf-40bf-9c39-7c748ea1fb6a" />

<img width="384" height="816" alt="image" src="https://github.com/user-attachments/assets/f13edfc0-ab5c-4bcf-81dc-043a347a2fe2" />
