import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../../domain/entities/pet.dart';
import '../../domain/repositories/pet_repository.dart';

class PetRepositoryImpl implements PetRepository {
  final _random = Random();
  final http.Client client;

  PetRepositoryImpl(this.client);

  final _names = [
    'Buddy',
    'Luna',
    'Charlie',
    'Max',
    'Bella',
    'Rocky',
    'Coco',
    'Milo',
    'Daisy',
    'Zoe',
  ];

  final _statuses = [
    'Happy',
    'Hungry',
    'Sleeping',
    'Playing',
    'Excited',
    'Scared',
    'Tired',
    'Curious',
    'Alert',
    'Relaxed',
  ];

  @override
  Future<Pet> fetchPetStatus() async {
    final response =
        await client.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    final name = _names[_random.nextInt(_names.length)];
    final status = _statuses[_random.nextInt(_statuses.length)];

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final imageUrl = data['message'];
      return Pet(name: name, status: status, imageUrl: imageUrl);
    } else {
      throw Exception('Failed to fetch pet status');
    }
  }
}
