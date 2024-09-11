import 'package:flutter/material.dart';
import 'package:untitled4/constants/colours.dart';
import 'package:untitled4/constants/constStrings.dart';
import 'package:untitled4/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  CharacterItem(this.character);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColour.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeCharchterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.id.toString(),
            child: Container(
              color: MyColour.myGrey,
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.name}',
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColour.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
