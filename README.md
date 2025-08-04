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
flutter pub get

---

### 📱 Screenshots

<img width="822" height="1754" alt="image" src="https://github.com/user-attachments/assets/021c87b5-b818-4256-8c62-4671ace752ce" />
<img width="808" height="1758" alt="image" src="https://github.com/user-attachments/assets/76ff3221-8e57-4683-a398-5ee5a479a4af" />
