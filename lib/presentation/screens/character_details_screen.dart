import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/constants/colours.dart';
import 'package:untitled4/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final Character character;
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColour.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.id.toString(),
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColour.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColour.myWhite,
              fontSize: 18,
            ),
          ),
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColour.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget ShowSHinyText() {
    return Center(
      child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Horizon",
            color: Colors.yellow,
            shadows: [
              Shadow(blurRadius: 7, color: Colors.yellow, offset: Offset(1, 0))
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText('Developed'),
              RotateAnimatedText('By'),
              RotateAnimatedText('Mohamed Araby'),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColour.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Name: ', character.name),
                    buildDivider(315),
                    characterInfo('Specie/Type: ', character.species),
                    buildDivider(250),
                    characterInfo('Gender: ', character.gender),
                    buildDivider(300),
                    characterInfo('Status: ', character.status),
                    buildDivider(300),
                    characterInfo('Created: ', character.created),
                    buildDivider(300),
                    SizedBox(
                      height: 20,
                    ),
                    ShowSHinyText(),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              )
            ]),
          )
        ],
      ),
    );
  }
}
