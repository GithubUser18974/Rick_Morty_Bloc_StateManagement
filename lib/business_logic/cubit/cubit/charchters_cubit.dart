import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled4/data/models/characters.dart';

import '../../../data/repository/character_repository.dart';

part 'charchters_state.dart';

class CharchtersCubit extends Cubit<CharchtersState> {
  final CharacterRepository characterRepository;
  List<Character> myCharacters = [];
  CharchtersCubit(this.characterRepository) : super(CharchtersInitial());
  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((character) {
      emit(CharactersLoaded(character));
      this.myCharacters = character;
    });
    print('*****************************************');
    print(myCharacters);
    print('*****************************************');
    return myCharacters;
  }
}
