import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class PetInteractionPage extends ConsumerStatefulWidget {
  const PetInteractionPage({super.key});

  @override
  ConsumerState<PetInteractionPage> createState() => _PetInteractionPageState();
}

class _PetInteractionPageState extends ConsumerState<PetInteractionPage> {
  String? _feedbackMessage;

  @override
  Widget build(BuildContext context) {
    final feederActive = ref.watch(feederControllerProvider);
    final voiceCommand = ref.watch(voiceCommandStateProvider);
    final battery = ref.watch(petDeviceBatteryProvider);
    final heartRate = ref.watch(petHeartRateProvider);
    final temperature = ref.watch(petTemperatureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pet Interaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('🐶 Send a command to your pet device'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(voiceCommandStateProvider.notifier)
                          .receiveCommand('feed');
                      setState(() {
                        _feedbackMessage = 'Sent "feed" command';
                      });
                    },
                    icon: const Icon(Icons.fastfood),
                    label: const Text('Feed Pet'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (feederActive)
              const Text('🦴 Dispensing food...',
                  style: TextStyle(color: Colors.orange)),
            if (_feedbackMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_feedbackMessage!,
                    style: const TextStyle(color: Colors.green)),
              ),
            const Divider(height: 32),
            const Text('📈 Live Pet Data'),
            const SizedBox(height: 8),
            _liveDataTile('Battery', battery.value?.toString() ?? '--',
                icon: Icons.battery_full),
            _liveDataTile('Heart Rate', '${heartRate.value ?? '--'} bpm',
                icon: Icons.favorite),
            _liveDataTile('Temperature',
                '${temperature.value?.toStringAsFixed(1) ?? '--'} °C',
                icon: Icons.thermostat),
            _liveDataTile('Voice', voiceCommand, icon: Icons.record_voice_over),
          ],
        ),
      ),
    );
  }

  Widget _liveDataTile(String label, String value, {required IconData icon}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      trailing:
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
