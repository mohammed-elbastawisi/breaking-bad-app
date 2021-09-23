import 'package:bloc_app/data/model/character.dart';
import 'package:bloc_app/data/model/quote.dart';
import 'package:bloc_app/data/web_services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final character = await characterWebServices.getAllCharacters();
    return character.map((char) => Character.fromJson(char)).toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final characterQuotes =
        await characterWebServices.getCharacterQuotes(charName);
    return characterQuotes
        .map((charQoute) => Quote.fromJson(charQoute))
        .toList();
  }
}
