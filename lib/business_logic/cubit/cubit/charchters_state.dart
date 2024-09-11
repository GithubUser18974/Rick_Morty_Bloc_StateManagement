part of 'charchters_cubit.dart';

@immutable
sealed class CharchtersState {}

class CharchtersInitial extends CharchtersState {}

class CharactersLoaded extends CharchtersState {
  final List<Character> charachters;
  CharactersLoaded(this.charachters);
}
