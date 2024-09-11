import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/constants/constStrings.dart';
import 'package:untitled4/data/models/characters.dart';
import 'package:untitled4/data/repository/character_repository.dart';
import 'package:untitled4/data/web_services/characters_web.dart';
import 'package:untitled4/presentation/screens/character_details_screen.dart';
import 'package:untitled4/presentation/screens/charchter_screen.dart';

import 'business_logic/cubit/cubit/charchters_cubit.dart';

class AppRoutes {
  late CharacterRepository characterRepository;
  late CharchtersCubit charchtersCubit;
  AppRoutes() {
    characterRepository = CharacterRepository(CharacterWebService());
    charchtersCubit = CharchtersCubit(characterRepository);
  }
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeCharchtersScrenn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charchtersCubit,
            child: CharchterScreen(),
          ),
        );
      case routeCharchterDetailsScreen:
        final character = routeSettings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character));
    }
  }
}
