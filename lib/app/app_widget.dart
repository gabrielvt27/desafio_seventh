import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/home');

    return MaterialApp.router(
      title: 'Desafio Seventh',
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),*/
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
