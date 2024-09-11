import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:untitled4/business_logic/cubit/cubit/charchters_cubit.dart';
import 'package:untitled4/constants/colours.dart';
import 'package:untitled4/data/models/characters.dart';
import 'package:untitled4/presentation/widgets/character_item.dart';

class CharchterScreen extends StatefulWidget {
  const CharchterScreen({super.key});

  @override
  State<CharchterScreen> createState() => _CharchterScreenState();
}

class _CharchterScreenState extends State<CharchterScreen> {
  late List<Character> allCharacter;
  late List<Character> searchedCharacters;
  bool isSearching = false;
  TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharchtersCubit>(context).getAllCharacters();
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            //isSearching = true;
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColour.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: Icon(
            Icons.search,
            color: MyColour.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColour.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColour.myGrey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MyColour.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsSearchedlist(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsSearchedlist(String searchedCharacter) {
    searchedCharacters = allCharacter
        .where((charachter) =>
            charachter.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharchtersCubit, CharchtersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacter = state.charachters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndeicator();
      }
    });
  }

  Widget showLoadingIndeicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColour.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColour.myGrey,
        child: Column(
          children: [
            buildCharachterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharachterList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isNotEmpty
          ? searchedCharacters.length
          : allCharacter.length,
      itemBuilder: (context, index) {
        return CharacterItem(_searchTextController.text.isEmpty
            ? allCharacter[index]
            : searchedCharacters[index]);

        /// NOT DONE YET
      },
    );
  }

  Widget buildAppBarTitle() {
    return Text('Characters', style: TextStyle(color: MyColour.myGrey));
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColour.myWhite,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect.. Check internet',
              style: TextStyle(fontSize: 22, color: MyColour.myGrey),
            ),
            Image.asset('assets/images/offline.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColour.myGrey,
      appBar: AppBar(
        backgroundColor: MyColour.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        leading: isSearching
            ? BackButton(
                color: MyColour.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndeicator(),
      ),

      // buildBlocWidget(),
    );
  }
}
