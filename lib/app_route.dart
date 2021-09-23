import 'package:bloc_app/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_app/constant/strings.dart';
import 'package:bloc_app/data/model/character.dart';
import 'package:bloc_app/data/repository/character_repository.dart';
import 'package:bloc_app/data/web_services/character_web_services.dart';
import 'package:bloc_app/presentation/screens/character_details_screen.dart';
import 'package:bloc_app/presentation/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRoute() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contect) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(characterRepository),
            child: CharacterDetailsScree(character: character),
          ),
        );
    }
  }
}
