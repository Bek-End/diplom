import 'package:diplom/main.dart';
import 'package:diplom/screens/theory_screen.dart';
import 'package:diplom/widgets/data_table_widget.dart';
import 'package:diplom/widgets/drop_down_widget.dart';
import 'package:diplom/widgets/my_gradient.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(l10n.finalQualifyingWork),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          Text('\t\t\t\t\t${l10n.annotation}', textAlign: TextAlign.justify),
          const SizedBox(height: 20),
          MaterialButton(
            child: Text(
              l10n.familiarizeYourselfWithTheoreticalMaterials,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const TheoryScreen(),
            )),
          ),
          const SizedBox(height: 20),
          const DropDownWidget(),
          const SizedBox(height: 20),
          const DataTableWidget(),
          const SizedBox(height: 20),
          const MyGradient(),
          const SizedBox(height: 20),
          Text(l10n.thanks),
        ],
      ),
    );
  }
}
