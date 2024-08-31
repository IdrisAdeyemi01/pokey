import 'package:pokey/src/core/router/routes.dart';
import 'package:pokey/src/core/theme/app_theme.dart';
import 'package:pokey/src/features/pokemons/model/favourite_pokemon.dart';
import 'package:pokey/src/services/navigation_service/navigation_service.dart';
import 'package:pokey/src/services/snackbar_service/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/features/startup/view/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FavouritePokemonAdapter());
  await Hive.openBox<FavouritePokemon>('favouritePokemons');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokey',
      theme: AppTheme.lightTheme,
      home: const StartupView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.watch(navigationService).navigatorKey,
      scaffoldMessengerKey: ref.watch(snackbarService).scaffoldMessengerKey,
    );
  }
}
