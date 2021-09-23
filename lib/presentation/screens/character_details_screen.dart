import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_app/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_app/constant/my_colors.dart';
import 'package:bloc_app/data/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScree extends StatefulWidget {
  final Character character;

  const CharacterDetailsScree({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScree> createState() => _CharacterDetailsScreeState();
}

class _CharacterDetailsScreeState extends State<CharacterDetailsScree> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(widget.character.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.only(
                      top: 14, left: 14, right: 14, bottom: 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      characterInfo(
                          'Job : ', widget.character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo('Appeared in : ',
                          widget.character.categoryForTwoSeries),
                      buildDivider(250),
                      characterInfo('Seasons : ',
                          widget.character.appearanceOfSeasons.join(' / ')),
                      buildDivider(280),
                      characterInfo(
                          'Status : ', widget.character.statusIfDeadOrAlive),
                      buildDivider(300),
                      widget.character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Saul Seasons : ',
                              widget.character.betterCallSaulAppearance
                                  .join(" / ")),
                      widget.character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo(
                          'Actor/Actress : ', widget.character.acotrName),
                      buildDivider(235),
                      SizedBox(height: 20),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (ctx, state) => checkIfQuotesAreLoaded(state),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .51),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * .75,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.character.nickName,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        background: Hero(
          tag: widget.character.charId,
          child: Image.network(
            widget.character.image,
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
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: MyColors.myWhite,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              color: MyColors.myWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      thickness: 2,
      color: MyColors.myYellow,
      endIndent: endIndent,
      height: 30,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return buildProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(QuotesLoaded state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomIndexOfQuote = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText(
                quotes[randomIndexOfQuote].quote,
                speed: Duration(milliseconds: 150),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
}
