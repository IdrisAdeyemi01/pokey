import 'package:pokey/src/services/base/failure.dart';
import 'package:pokey/src/services/storage_service/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokey/src/repositories/pokemons_repository.dart';
import 'package:pokey/src/services/network_service/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  final networkService = MockNetworkService();
  final storageService = MockStorageService();
  final pokemonsRepository = PokemonsRepository(
      networkService: networkService, storageService: storageService);

  setUp(() {
    registerFallbackValue(Uri.parse('uri'));
  });

  group('Pokemon Repository', () {
    test('Should return pokemons on success', () async {
      when(() => networkService.get(any())).thenAnswer(
        (_) => Future.value({"results": []}),
      );

      final pokemons = await pokemonsRepository.getPokemons();

      expect(pokemons, equals({'next': null, 'listOfPokemons': []}));
    });

    test('Should throw failure on error', () async {
      when(() => networkService.get(any())).thenThrow(Failure('error'));

      final response = pokemonsRepository.getPokemons();

      expect(response, throwsA(isA<Failure>()));
    });
  });
}
