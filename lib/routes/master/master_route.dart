import 'package:flutter/material.dart';
import 'package:punkapi_beer/repositories/beer_repository.dart';
import 'package:punkapi_beer/routes/detail/detail_route.dart';

import 'widgets/punkapi_card_route.dart';

class MasterRoute extends StatelessWidget {
  static const routeName = '/';

  final BeersRepository beersRepository;

  MasterRoute({required this.beersRepository});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = Image.asset(
      'assets/images/punkapi.png',
      height: 40,
      width: 30,
      fit: BoxFit.fitHeight,
    );

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const Text(
              'Punk API',
              style: TextStyle(
                fontFamily: 'Nerko_One',
                fontSize: 40,
              ),
            ),
            image,
          ],
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: beersRepository.getBeers(itemsPerPage: 80),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final beers = snapshot.data;

          return ListView.builder(
            itemCount: (beers as List).length,
            itemBuilder: (_,index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: PunkApiCard(
                  beer: beers[index],
                  onBeerSelected: (selectedBeer) {
                    Navigator.pushNamed(context, DetailRoute.routeName,
                        arguments: selectedBeer);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}