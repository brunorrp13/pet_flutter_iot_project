import '../entities/pet.dart';
import '../repositories/pet_repository.dart';

class GetPetStatusUsecase {
  final PetRepository repository;

  GetPetStatusUsecase(this.repository);

  Future<Pet> call() => repository.fetchPetStatus();
}