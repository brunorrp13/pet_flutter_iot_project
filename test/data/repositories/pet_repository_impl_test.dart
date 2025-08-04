import 'dart:convert';
import 'package:flutter_iot_pet_app/data/repositories/pet_repository_impl.dart';
import 'package:flutter_iot_pet_app/domain/entities/pet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../mocks/mocks.mocks.dart';

void main() {
  group('PetRepositoryImpl', () {
    late MockClient mockClient;
    late PetRepositoryImpl repository;

    setUp(() {
      mockClient = MockClient();
      repository = PetRepositoryImpl(mockClient);
    });

    test('returns a Pet when the http call completes successfully', () async {
      when(mockClient.get(Uri.parse('https://dog.ceo/api/breeds/image/random')))
          .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'message':
                      'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg'
                }),
                200,
              ));

      final pet = await repository.fetchPetStatus();

      expect(pet, isA<Pet>());
      expect(pet.imageUrl, contains('dog.ceo'));
      expect(pet.name, isNotEmpty);
      expect(pet.status, isNotEmpty);
    });

    test('throws an exception when http call fails', () async {
      when(mockClient.get(Uri.parse('https://dog.ceo/api/breeds/image/random')))
          .thenAnswer((_) async => http.Response('Not found', 404));

      expect(repository.fetchPetStatus(), throwsException);
    });
  });
}
