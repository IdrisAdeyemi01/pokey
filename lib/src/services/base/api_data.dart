class APIData {
  static const host = 'pokeapi.co';
  static const String scheme = 'https';

  static Uri baseUri() => Uri(scheme: scheme, host: host, path: '');

  static Uri errorUri() => Uri(scheme: scheme, host: host, path: '/nopath');

  static Uri fetchPokemons({required String query}) => Uri(
        scheme: scheme,
        host: host,
        path: 'api/v2/pokemon/',
        query:  query,
      );

  static Uri fetchPokemonsFromUrl(String url) => Uri.parse(url);
}
