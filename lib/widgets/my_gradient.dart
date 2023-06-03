import 'package:diplom/blocs/progonka_bloc.dart';
import 'package:diplom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyGradient extends StatelessWidget {
  const MyGradient({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ProgonkaBloc, ProgonkaState>(
      builder: (context, state) {
        if (state is! ProgonkaDataState) return const SizedBox.shrink();

        final progonka = state.progonka;
        final e = progonka.e;
        final xList = List.generate(e + 1, (index) => index - e ~/ 2);
        return SfCartesianChart(
          title: ChartTitle(text: l10n.result),
          series: <ChartSeries<double, int>>[
            SplineAreaSeries(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.5),
                    Colors.red.withOpacity(0.8),
                  ]),
              dataSource: xList.map((e) => e.toDouble()).toList(),
              xValueMapper: (_, index) => xList[index],
              yValueMapper: (_, __) => 1,
            )
          ],
        );
      },
    );
  }
}
