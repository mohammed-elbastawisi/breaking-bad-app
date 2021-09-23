import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/model/character.dart';
import 'package:bloc_app/data/model/quote.dart';
import 'package:bloc_app/data/repository/character_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  // List<Character> character = [];
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  void getAllCharacters() {
    characterRepository.getAllCharacters().then((char) {
      emit(CharactersLoaded(char));
      // this.character = char;
    });
    // return character;
  }

  void getCharacterQuotes(String charName) {
    characterRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
