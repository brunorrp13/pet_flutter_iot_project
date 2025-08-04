import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_iot_pet_app/data/websockets/websocket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'data/repositories/pet_repository_impl.dart';
import 'domain/entities/pet.dart';
import 'domain/usecases/get_pet_status.dart';

part 'providers.g.dart';

final showLocationProvider = StateProvider<bool>((ref) => false);
final showBluetoothRequest = StateProvider<bool>((ref) => false);
final showTemperatureProvider = StateProvider<bool>((ref) => false);
final showHeartRateProvider = StateProvider<bool>((ref) => false);
final showBatteryProvider = StateProvider<bool>((ref) => false);
final showFirmwareProvider = StateProvider<bool>((ref) => false);
final showMqttProvider = StateProvider<bool>((ref) => false);
final showSyncProvider = StateProvider<bool>((ref) => false);
final showVoiceProvider = StateProvider<bool>((ref) => false);

@riverpod
http.Client httpClient(HttpClientRef ref) => http.Client();

/// A simple [Provider] (auto-generated using `@riverpod`)
/// that exposes an implementation of the `PetRepository`.
///
/// Since the repository is a stateless service, this provider is useful
/// for injecting dependencies. It will return the same instance as long as the app
/// is alive or the provider is not disposed manually.
@riverpod
PetRepositoryImpl petRepository(PetRepositoryRef ref) {
  final client = ref.watch(httpClientProvider);
  return PetRepositoryImpl(client);
}

/// A [Provider] that returns an instance of `GetPetStatusUsecase`,
/// which wraps the business logic for fetching pet data.
///
/// This allows you to separate concerns, keeping business logic out of the UI
/// while making the use case easily testable and injectable.
@riverpod
GetPetStatusUsecase getPetStatusUsecase(GetPetStatusUsecaseRef ref) {
  final repo = ref.watch(petRepositoryProvider);
  return GetPetStatusUsecase(repo);
}

/// An [AsyncNotifierProvider] created using `@riverpod class` syntax.
///
/// It manages asynchronous state for a single pet's status,
/// which can be `loading`, `data`, or `error`, using [AsyncValue].
///
/// This is ideal when you want more control over your state
/// (e.g., you want to manually trigger refreshes) compared to [FutureProvider].
///
/// Key advantage:
/// - Maintains internal state and can expose methods (e.g., `refresh()`).
/// - You don't need to pass logic externally to re-fetch data.
@riverpod
class PetStatus extends _$PetStatus {
  @override
  Future<Pet> build() async {
    final usecase = ref.watch(getPetStatusUsecaseProvider);
    return usecase();
  }

  /// A custom method to manually refresh the pet status.
  /// This resets the state to `AsyncLoading` and guards against exceptions.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.watch(getPetStatusUsecaseProvider);
      return usecase();
    });
  }
}

/// A [StateNotifierProvider] built using `@riverpod class` syntax,
/// exposing a simple `bool` state to control visibility of pet status on UI.
///
/// This is useful for basic UI toggles (e.g., show/hide widgets).
/// StateNotifier-like APIs provide methods and full control over transitions.
///
/// This differs from [StateProvider] in that:
/// - You can define complex business logic with methods like `toggle()`.
/// - Better for scenarios where state transitions matter or need tracking.
@riverpod
class IsStatusVisible extends _$IsStatusVisible {
  @override
  bool build() => true;

  /// Toggles the current boolean state (true <-> false)
  void toggle() => state = !state;
}

/// A [FutureProvider] that simulates fetching the pet's GPS location,
/// as if from a smart collar device with GPS.
@riverpod
Future<String> petLocation(PetLocationRef ref) async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return 'Location services are disabled.';
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return 'Location permission denied.';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return 'Location permission permanently denied.';
  }

  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return 'Lat: ${position.latitude}, Long: ${position.longitude}';
}

/// A [StreamProvider] that simulates live temperature sensor data from a smart collar.
///
/// This streams updated values every 2 seconds between 36°C and 38°C.
@riverpod
Stream<double> petTemperature(PetTemperatureRef ref) async* {
  final random = Random();
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    yield 36.0 + random.nextDouble() * 2;
  }
}

/// A [StreamProvider] that simulates pet heart rate (bpm) readings.
///
/// Emits a value every 3 seconds in a range between 60–120 bpm.
@riverpod
Stream<int> petHeartRate(PetHeartRateRef ref) async* {
  final random = Random();
  while (true) {
    await Future.delayed(Duration(seconds: 3));
    yield 60 + random.nextInt(60);
  }
}

/// A [StreamProvider] that gets IoT battery level for a device.
///
// Decreases over time to simulate power usage.
@riverpod
Stream<int> petDeviceBattery(PetDeviceBatteryRef ref) async* {
  if (!await ensureBluetoothReady()) return;

  // Check if Bluetooth is on
  if (!await FlutterBluePlus.isSupported) {
    print('Bluetooth not supported on this device');
    return;
  }

  if (!(FlutterBluePlus.adapterState == BluetoothAdapterState.on)) {
    print('Bluetooth is off. Please enable it.');
    return;
  }

  // Optionally request permissions (Android 12+ needs this)
  await FlutterBluePlus
      .turnOn(); // Prompts user to turn on Bluetooth (Android only)

  BluetoothDevice? device;

  // Start scanning
  await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

  await for (final scanResult in FlutterBluePlus.scanResults) {
    for (final result in scanResult) {
      // Filter by name or id if necessary
      // if (result.device.name == 'YourPetDevice') {
      device = result.device;
      break;
      // }
    }
    if (device != null) break;
  }

  await FlutterBluePlus.stopScan();

  if (device == null) {
    print('Device not found');
    return;
  }

  // Connect
  await device.connect(autoConnect: false);

  // Discover services
  final services = await device.discoverServices();

  // UUIDs
  final batteryServiceUuid = Guid('0000180f-0000-1000-8000-00805f9b34fb');
  final batteryLevelCharUuid = Guid('00002a19-0000-1000-8000-00805f9b34fb');

  BluetoothCharacteristic? batteryChar;

  for (final service in services) {
    if (service.serviceUuid == batteryServiceUuid) {
      for (final characteristic in service.characteristics) {
        if (characteristic.characteristicUuid == batteryLevelCharUuid) {
          batteryChar = characteristic;
          break;
        }
      }
    }
  }

  if (batteryChar == null) {
    throw Exception('Battery characteristic not found');
  }

  await batteryChar.setNotifyValue(true);

  final subscription = batteryChar.onValueReceived.listen((value) {
    if (value.isNotEmpty) {
      ref.state = AsyncData(value[0]);
    }
  });

  ref.onDispose(() async {
    await subscription.cancel();
    await device?.disconnect();
  });

  // Initial value read
  final initialValue = await batteryChar.read();
  if (initialValue.isNotEmpty) {
    yield initialValue[0];
  }

  // Keep stream open indefinitely, updates come via notifications
  await for (final _ in batteryChar.onValueReceived) {
    // Already handled in the listener above.
  }
}

/// A [StateNotifierProvider] that simulates a smart feeder controller.
///
/// When triggered, it sets the state to `true` (feeding),
/// then returns to `false` after 2 seconds.
@riverpod
class FeederController extends _$FeederController {
  @override
  bool build() => false;

  void dispenseFood() {
    state = true;
    Future.delayed(Duration(seconds: 2), () => state = false);
  }
}

/// A [NotifierProvider] to simulate voice command input,
/// which can be used to trigger smart actions like feeding.
///
/// Stores the latest command received.
@riverpod
class VoiceCommandState extends _$VoiceCommandState {
  @override
  String build() => 'Awaiting command';

  void receiveCommand(String command) {
    state = 'Received: "$command"';
    if (command.toLowerCase().contains('feed')) {
      ref.read(feederControllerProvider.notifier).dispenseFood();
    }
  }
}

/// A [NotifierProvider] that simulates an MQTT connection status.
///
/// You can trigger connection and disconnection manually.
@riverpod
class MqttStatus extends _$MqttStatus {
  @override
  String build() => 'Disconnected';

  Future<void> connect() async {
    state = 'Connecting...';
    await Future.delayed(Duration(seconds: 1));
    state = 'Connected to mqtt://broker.hivemq.com';
  }

  void disconnect() => state = 'Disconnected';
}

/// A [FutureProvider] that simulates the firmware version of the IoT pet device.
@riverpod
Future<String> firmwareVersion(FirmwareVersionRef ref) async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'v1.2.4';
}

/// A [NotifierProvider] that simulates sync operations to the cloud.
///
/// Can be triggered to show syncing state.
@riverpod
class SyncStatus extends _$SyncStatus {
  @override
  String build() => 'Idle';

  Future<void> syncToCloud() async {
    state = 'Syncing...';
    await Future.delayed(Duration(seconds: 2));
    state = 'Synced successfully';
  }
}

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final service = WebSocketService('wss://ws.postman-echo.com/raw');
  ref.onDispose(service.dispose);
  return service;
});

final messageControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

@riverpod
GraphQLClient graphQLClient(GraphQLClientRef ref) {
  final httpLink = HttpLink('https://countries.trevorblades.com/');

  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  );
}

@riverpod
Future<List<Map<String, dynamic>>> countries(CountriesRef ref) async {
  final client = ref.watch(graphQLClientProvider);

  const query = r'''
    query {
      countries {
        code
        name
        capital
      }
    }
  ''';

  final result = await client.query(QueryOptions(document: gql(query)));

  if (result.hasException) {
    throw result.exception!;
  }

  final countries = result.data?['countries'] as List<dynamic>;

  return countries.cast<Map<String, dynamic>>();
}

Future<bool> ensureBluetoothReady() async {
  final isSupported = await FlutterBluePlus.isSupported;
  if (!isSupported) {
    print('Bluetooth not supported');
    return false;
  }

  if (Platform.isAndroid) {
    final perms = await [
      Permission.bluetoothConnect,
      Permission.locationWhenInUse
    ].request();
    if (perms[Permission.bluetoothConnect] != PermissionStatus.granted ||
        perms[Permission.locationWhenInUse] != PermissionStatus.granted) {
      print('Permissions not granted');
      return false;
    }
    await FlutterBluePlus.turnOn();
  } else if (Platform.isIOS) {
    final status = await Permission.locationWhenInUse.request();
    if (status != PermissionStatus.granted) {
      print('Location permission required');
      return false;
    }
  }

  final adapterState = await FlutterBluePlus.adapterState.first;
  if (adapterState != BluetoothAdapterState.on) {
    print('Bluetooth is off');
    return false;
  }

  return true;
}
