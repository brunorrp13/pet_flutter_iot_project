import '../entities/pet.dart';

abstract class PetRepository {
  Future<Pet> fetchPetStatus();
}