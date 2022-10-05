import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:punkapi_beer/repositories/beer_repository.dart';
import 'package:punkapi_beer/routes/detail/detail_route.dart';
import 'package:punkapi_beer/routes/master/master_route.dart';
import 'package:punkapi_beer/theme.dart';

class PunkApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: MasterRoute.routeName,
      routes: <String, WidgetBuilder>{
        MasterRoute.routeName: (_) => MasterRoute(
          beersRepository: BeersRepository(
            client: http.Client(),
          ),
        ),
        DetailRoute.routeName: (_) => DetailRoute(),
      },
    );
  }
}