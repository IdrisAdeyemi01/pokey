import 'package:pokey/src/core/components/app_svg_viewer.dart';
import 'package:pokey/src/core/components/spacing.dart';
import 'package:pokey/src/core/components/status_bar.dart';
import 'package:pokey/src/core/constants/constants.dart';
import 'package:pokey/src/core/router/routes.dart';
import 'package:pokey/src/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartupView extends ConsumerStatefulWidget {
  const StartupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StartupViewState();
}

class _StartupViewState extends ConsumerState<StartupView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => ref.read(navigationService).navigateOffNamed(
            Routes.homeView,
            // arguments: Pokemon(
            //   name: 'name',
            //   id: 1,
            //   types: [],
            //   sprite: 'sprite',
            //   weight: 20,
            //   height: 12,
            //   hp: 20,
            //   attack: 34,
            //   defense: 22,
            //   specialAttack: 11,
            //   specialDefense: 11,
            //   speed: 11,
            // ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Statusbar(
      statusBarColor: AppColors.primary,
      systemNavigationBarColor: AppColors.primary,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimensions.large,
              0,
              Dimensions.large,
              0,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppSvgViewer(
                    assetName: AppSvgs.pokedexIcon,
                    height: 80,
                    width: 80,
                  ),
                  const Spacing.bigWidth(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.pokemon.toUpperCase(),
                          style: textTheme.headline6!.copyWith(
                              letterSpacing: 5, color: AppColors.white),
                        ),
                        Text(
                          AppStrings.pokedex,
                          style: textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
