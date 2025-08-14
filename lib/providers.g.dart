// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$httpClientHash() => r'514f1fa634105c7b80c084a766e4cf2b3adf45d3';

/// See also [httpClient].
@ProviderFor(httpClient)
final httpClientProvider = AutoDisposeProvider<http.Client>.internal(
  httpClient,
  name: r'httpClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$httpClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HttpClientRef = AutoDisposeProviderRef<http.Client>;
String _$petRepositoryHash() => r'263acddd6b82188eb7edb8cd152549464e88404c';

/// A simple [Provider] (auto-generated using `@riverpod`)
/// that exposes an implementation of the `PetRepository`.
///
/// Since the repository is a stateless service, this provider is useful
/// for injecting dependencies. It will return the same instance as long as the app
/// is alive or the provider is not disposed manually.
///
/// Copied from [petRepository].
@ProviderFor(petRepository)
final petRepositoryProvider = AutoDisposeProvider<PetRepositoryImpl>.internal(
  petRepository,
  name: r'petRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$petRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PetRepositoryRef = AutoDisposeProviderRef<PetRepositoryImpl>;
String _$getPetStatusUsecaseHash() =>
    r'c19c0f4754442b7f26a0d5785809c7bbcdd901e3';

/// A [Provider] that returns an instance of `GetPetStatusUsecase`,
/// which wraps the business logic for fetching pet data.
///
/// This allows you to separate concerns, keeping business logic out of the UI
/// while making the use case easily testable and injectable.
///
/// Copied from [getPetStatusUsecase].
@ProviderFor(getPetStatusUsecase)
final getPetStatusUsecaseProvider =
    AutoDisposeProvider<GetPetStatusUsecase>.internal(
  getPetStatusUsecase,
  name: r'getPetStatusUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPetStatusUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPetStatusUsecaseRef = AutoDisposeProviderRef<GetPetStatusUsecase>;
String _$petLocationHash() => r'130d8de99326a64a61639b2e11b28badb4c387a1';

/// A [FutureProvider] that simulates fetching the pet's GPS location,
/// as if from a smart collar device with GPS.
///
/// Copied from [petLocation].
@ProviderFor(petLocation)
final petLocationProvider = AutoDisposeFutureProvider<String>.internal(
  petLocation,
  name: r'petLocationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PetLocationRef = AutoDisposeFutureProviderRef<String>;
String _$petTemperatureHash() => r'a5e4a5d20ede295f70d6ceaba2a833b0455db26b';

/// A [StreamProvider] that simulates live temperature sensor data from a smart collar.
///
/// This streams updated values every 2 seconds between 36°C and 38°C.
///
/// Copied from [petTemperature].
@ProviderFor(petTemperature)
final petTemperatureProvider = AutoDisposeStreamProvider<double>.internal(
  petTemperature,
  name: r'petTemperatureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$petTemperatureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PetTemperatureRef = AutoDisposeStreamProviderRef<double>;
String _$petHeartRateHash() => r'8dc872fafe51dea84c2c76a3f4d349114f5bbc03';

/// A [StreamProvider] that simulates pet heart rate (bpm) readings.
///
/// Emits a value every 3 seconds in a range between 60–120 bpm.
///
/// Copied from [petHeartRate].
@ProviderFor(petHeartRate)
final petHeartRateProvider = AutoDisposeStreamProvider<int>.internal(
  petHeartRate,
  name: r'petHeartRateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petHeartRateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PetHeartRateRef = AutoDisposeStreamProviderRef<int>;
String _$petDeviceBatteryHash() => r'c4a10292c223c4b42c41484fb95c0fcf7b404537';

/// A [StreamProvider] that gets IoT battery level for a device.
///
///
/// Copied from [petDeviceBattery].
@ProviderFor(petDeviceBattery)
final petDeviceBatteryProvider = AutoDisposeStreamProvider<int>.internal(
  petDeviceBattery,
  name: r'petDeviceBatteryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$petDeviceBatteryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PetDeviceBatteryRef = AutoDisposeStreamProviderRef<int>;
String _$firmwareVersionHash() => r'bad0ca161673d3a77b34e6ea31088e70a7cfd373';

/// A [FutureProvider] that simulates the firmware version of the IoT pet device.
///
/// Copied from [firmwareVersion].
@ProviderFor(firmwareVersion)
final firmwareVersionProvider = AutoDisposeFutureProvider<String>.internal(
  firmwareVersion,
  name: r'firmwareVersionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firmwareVersionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirmwareVersionRef = AutoDisposeFutureProviderRef<String>;
String _$graphQLClientHash() => r'e6ec68745c5c402a6c83f68466777d2d191a6e42';

/// A [GraphQLClientProvider] that consults a http public link to get data with queries.
///
/// Can be called directly.
///
/// Copied from [graphQLClient].
@ProviderFor(graphQLClient)
final graphQLClientProvider = AutoDisposeProvider<GraphQLClient>.internal(
  graphQLClient,
  name: r'graphQLClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$graphQLClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GraphQLClientRef = AutoDisposeProviderRef<GraphQLClient>;
String _$countriesHash() => r'dcbdb428e791cd3d2855ceab668281b65ef1fbd0';

/// See also [countries].
@ProviderFor(countries)
final countriesProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  countries,
  name: r'countriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CountriesRef = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$petStatusHash() => r'9c63e876b507f15ab8a2ea0f6a3f4815f0628ee8';

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
///
/// Copied from [PetStatus].
@ProviderFor(PetStatus)
final petStatusProvider =
    AutoDisposeAsyncNotifierProvider<PetStatus, Pet>.internal(
  PetStatus.new,
  name: r'petStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PetStatus = AutoDisposeAsyncNotifier<Pet>;
String _$isStatusVisibleHash() => r'ee53c2f1c771334b455b29a4736c65f1a3019ffd';

/// A [StateNotifierProvider] built using `@riverpod class` syntax,
/// exposing a simple `bool` state to control visibility of pet status on UI.
///
/// This is useful for basic UI toggles (e.g., show/hide widgets).
/// StateNotifier-like APIs provide methods and full control over transitions.
///
/// This differs from [StateProvider] in that:
/// - You can define complex business logic with methods like `toggle()`.
/// - Better for scenarios where state transitions matter or need tracking.
///
/// Copied from [IsStatusVisible].
@ProviderFor(IsStatusVisible)
final isStatusVisibleProvider =
    AutoDisposeNotifierProvider<IsStatusVisible, bool>.internal(
  IsStatusVisible.new,
  name: r'isStatusVisibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isStatusVisibleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsStatusVisible = AutoDisposeNotifier<bool>;
String _$feederControllerHash() => r'6dea04d66be69fc4678e186ffc481e66e43e9b58';

/// A [StateNotifierProvider] that simulates a smart feeder controller.
///
/// When triggered, it sets the state to `true` (feeding),
/// then returns to `false` after 2 seconds.
///
/// Copied from [FeederController].
@ProviderFor(FeederController)
final feederControllerProvider =
    AutoDisposeNotifierProvider<FeederController, bool>.internal(
  FeederController.new,
  name: r'feederControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feederControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FeederController = AutoDisposeNotifier<bool>;
String _$voiceCommandStateHash() => r'ceedbefdfc90293f449979e65cc4cb4f3b756b08';

/// A [NotifierProvider] to simulate voice command input,
/// which can be used to trigger smart actions like feeding.
///
/// Stores the latest command received.
///
/// Copied from [VoiceCommandState].
@ProviderFor(VoiceCommandState)
final voiceCommandStateProvider =
    AutoDisposeNotifierProvider<VoiceCommandState, String>.internal(
  VoiceCommandState.new,
  name: r'voiceCommandStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceCommandStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceCommandState = AutoDisposeNotifier<String>;
String _$mqttStatusHash() => r'd4f993dcf08051fb097e37c5636da0c0a994b1cb';

/// A [NotifierProvider] that simulates an MQTT connection status.
///
/// You can trigger connection and disconnection manually.
///
/// Copied from [MqttStatus].
@ProviderFor(MqttStatus)
final mqttStatusProvider =
    AutoDisposeNotifierProvider<MqttStatus, String>.internal(
  MqttStatus.new,
  name: r'mqttStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mqttStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MqttStatus = AutoDisposeNotifier<String>;
String _$syncStatusHash() => r'bb530961c032f3b9ad80e6d96ab27ac2677a66f6';

/// A [NotifierProvider] that simulates sync operations to the cloud.
///
/// Can be triggered to show syncing state.
///
/// Copied from [SyncStatus].
@ProviderFor(SyncStatus)
final syncStatusProvider =
    AutoDisposeNotifierProvider<SyncStatus, String>.internal(
  SyncStatus.new,
  name: r'syncStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncStatus = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
