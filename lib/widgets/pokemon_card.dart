import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pokemon/blocs/pokemo_bloc.dart';
import 'package:pokemon/pages/detail_screen.dart';
import 'package:pokemon/resources/app_colors.dart';
import 'package:pokemon/services/locator.dart';
import 'package:pokemon/services/navigation_service.dart';
import 'package:pokemon/widgets/type_card.dart';

class PokeCard extends StatelessWidget {
  final dynamic poke;
  final BuildContext context;

  const PokeCard(this.poke, this.context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            locator<NavigationService>()
                .navigateTo(PokeDetailScreen.routeName)
                .then(
                  (value) =>
                      context.read<PokemonBloc>().add(GetPokemonData(poke.id)),
                );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
            margin: EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
              color: setCardColor(poke.type1.toString()),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: setCardColor(poke.type1.toString()).withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#' + poke.id.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      toBeginningOfSentenceCase(poke.name)!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        if (poke.type1 != null) TypeCard(poke.type1),
                        SizedBox(width: 5),
                        if (poke.type2 != null) TypeCard(poke.type2),
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: -35,
                  bottom: -50,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/pokeLoad.gif',
                    image: poke.sprite,
                    imageScale: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
