import 'package:diplom/blocs/progonka_bloc.dart';
import 'package:diplom/main.dart';
import 'package:diplom/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgonkaBloc()..add(ProgonkaInitEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculation of free convection near extreme temperatures',
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        home: const MainScreen(),
      ),
    );
  }
}
