import 'package:flutter/material.dart';
import 'package:flutter_iot_pet_app/presentation/pages/pet_interaction_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _textFieldController = ref.watch(messageControllerProvider);

    final countriesAsync = ref.watch(countriesProvider);

    final petAsync = ref.watch(petStatusProvider);
    final isStatusVisible = ref.watch(isStatusVisibleProvider);

    // Toggle states
    final showLocation = ref.watch(showLocationProvider);
    final showTemperature = ref.watch(showTemperatureProvider);
    final showHeartRate = ref.watch(showHeartRateProvider);
    final showBattery = ref.watch(showBatteryProvider);
    final showFirmware = ref.watch(showFirmwareProvider);
    final showMQTT = ref.watch(showMqttProvider);
    final showSync = ref.watch(showSyncProvider);
    final showVoice = ref.watch(showVoiceProvider);

    // Data
    final petLocation = ref.watch(petLocationProvider);
    final petTemperature = ref.watch(petTemperatureProvider);
    final petHeartRate = ref.watch(petHeartRateProvider);
    final petBattery = ref.watch(petDeviceBatteryProvider);
    final firmwareVersion = ref.watch(firmwareVersionProvider);
    final mqttStatus = ref.watch(mqttStatusProvider);
    final syncStatus = ref.watch(syncStatusProvider);
    final voiceCommand = ref.watch(voiceCommandStateProvider);

    // WebSocket
    final wsService = ref.watch(webSocketServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Random Dog')),
      body: petAsync.when(
        data: (pet) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PetInteractionPage()),
                    );
                  },
                  child: const Text('Open Pet Interaction'),
                ),
                Text('Type your message'),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _textFieldController,
                ),
                SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: () {
                    wsService.send(_textFieldController.text);
                  },
                  child: const Text('Send WebSocket Message'),
                ),
                SizedBox(
                  height: 18,
                ),
                StreamBuilder<String>(
                  stream: wsService.messages,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Waiting for WebSocket...');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text('Received: ${snapshot.data}');
                    } else {
                      return const Text('No data received yet');
                    }
                  },
                ),
                SizedBox(
                  height: 36,
                ),
                Text('GraphQl country capitals list'),
                countriesAsync.when(
                  data: (countries) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    height: 200, // ajuste a altura conforme necessário
                    child: SingleChildScrollView(
                      child: Column(
                        children: countries
                            .map((c) => Text('${c['name']} - ${c['capital']}'))
                            .toList(),
                      ),
                    ),
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),
                SizedBox(
                  height: 36,
                ),
                Image.network(
                  pet.imageUrl,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text(pet.name),
                if (isStatusVisible)
                  Text('Status: ${pet.status}',
                      style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show Status'),
                    Switch(
                      value: isStatusVisible,
                      onChanged: (_) =>
                          ref.read(isStatusVisibleProvider.notifier).toggle(),
                    ),
                  ],
                ),
                const Divider(height: 40),
                Text('🐾 IoT Pet Device Info'),
                const SizedBox(height: 10),
                if (showLocation)
                  Text('📍 Location: ${petLocation.value ?? ''}'),
                if (showTemperature)
                  Text(
                      '🌡️ Temp: ${petTemperature.value?.toStringAsFixed(1) ?? ''} °C'),
                if (showHeartRate)
                  Text('❤️ Heart Rate: ${petHeartRate.value ?? ''} bpm'),
                if (showBattery)
                  Text('🔋 Battery: ${petBattery.value ?? ''} %'),
                if (showFirmware)
                  Text('📦 Firmware: ${firmwareVersion.value ?? ''}'),
                if (showVoice) Text('🔊 Voice Command: $voiceCommand'),
                if (showMQTT) Text('🟢 MQTT: $mqttStatus'),
                if (showSync) Text('☁️ Sync: $syncStatus'),
                const SizedBox(height: 20),
                _iotToggleButton(
                  context,
                  label: 'Location',
                  icon: Icons.location_on,
                  isActive: showLocation,
                  onToggle: () => ref
                      .read(showLocationProvider.notifier)
                      .state = !showLocation,
                ),
                _iotToggleButton(
                  context,
                  label: 'Temperature',
                  icon: Icons.thermostat,
                  isActive: showTemperature,
                  onToggle: () => ref
                      .read(showTemperatureProvider.notifier)
                      .state = !showTemperature,
                ),
                _iotToggleButton(
                  context,
                  label: 'Heart Rate',
                  icon: Icons.favorite,
                  isActive: showHeartRate,
                  onToggle: () => ref
                      .read(showHeartRateProvider.notifier)
                      .state = !showHeartRate,
                ),
                _iotToggleButton(
                  context,
                  label: 'Battery',
                  icon: Icons.battery_std,
                  isActive: showBattery,
                  onToggle: () => ref.read(showBatteryProvider.notifier).state =
                      !showBattery,
                ),
                _iotToggleButton(
                  context,
                  label: 'Firmware',
                  icon: Icons.memory,
                  isActive: showFirmware,
                  onToggle: () => ref
                      .read(showFirmwareProvider.notifier)
                      .state = !showFirmware,
                ),
                _iotToggleButton(
                  context,
                  label: 'MQTT',
                  icon: Icons.cloud,
                  isActive: showMQTT,
                  onToggle: () {
                    ref.read(showMqttProvider.notifier).state = !showMQTT;
                    if (!showMQTT)
                      ref.read(mqttStatusProvider.notifier).connect();
                  },
                ),
                _iotToggleButton(
                  context,
                  label: 'Sync',
                  icon: Icons.sync,
                  isActive: showSync,
                  onToggle: () {
                    ref.read(showSyncProvider.notifier).state = !showSync;
                    if (!showSync)
                      ref.read(syncStatusProvider.notifier).syncToCloud();
                  },
                ),
                _iotToggleButton(
                  context,
                  label: 'Voice',
                  icon: Icons.record_voice_over,
                  isActive: showVoice,
                  onToggle: () {
                    ref.read(showVoiceProvider.notifier).state = !showVoice;
                    if (!showVoice) {
                      ref
                          .read(voiceCommandStateProvider.notifier)
                          .receiveCommand('feed');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(petStatusProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _iotToggleButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: onToggle,
        icon: Icon(icon, color: isActive ? Colors.white : null),
        label: Text(label,
            style: TextStyle(color: isActive ? Colors.white : null)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.blue : null,
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    );
  }
}
