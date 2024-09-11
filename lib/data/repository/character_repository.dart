import 'package:untitled4/data/models/characters.dart';

import '../web_services/characters_web.dart';

class CharacterRepository {
  final CharacterWebService characterWebService;

  CharacterRepository(this.characterWebService);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebService.getAllCharacters();
    var mylist =
        characters.map((character) => Character.fromJson(character)).toList();
    print('Repository ***************************');
    print(mylist);
    print('Repository ***************************');
    return mylist;
  }
}
