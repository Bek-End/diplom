import 'package:diplom/blocs/progonka_bloc.dart';
import 'package:diplom/logic/progonka.dart';
import 'package:diplom/main.dart';
import 'package:diplom/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels1 = <String>['№', 'A', 'B', 'C', 'F', 'α', 'β', 'T₀'];
    final labels2 = <String>['№', 'A', 'B', 'C', 'F', 'α', 'β', 'T₁₁'];

    return BlocBuilder<ProgonkaBloc, ProgonkaState>(
      builder: (context, state) {
        if (state is! ProgonkaDataState) return const LoadingWidget();

        final progonka = state.progonka;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${l10n.table} №1'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(width: 2),
                columns: List.generate(
                  labels1.length,
                  (index) => _dataColumn(labels1[index]),
                ),
                rows: List.generate(
                  progonka.n,
                  (index) => _dataRow(progonka, index, 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('${l10n.table} №2'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(width: 2),
                columns: List.generate(
                  labels2.length,
                  (index) => _dataColumn(labels2[index]),
                ),
                rows: List.generate(
                  progonka.n,
                  (index) => _dataRow(progonka, index, 2),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('${l10n.table} №3'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 0,
                border: TableBorder.all(width: 2),
                columns: List.generate(
                  progonka.n + 1,
                  (index) => const DataColumn(label: Text('')),
                ),
                rows: [
                  DataRow(cells: _table3(progonka.n, progonka.t0, 0)),
                  DataRow(cells: _table3(progonka.n, progonka.t11, 1)),
                  DataRow(cells: _table3(progonka.n, progonka.t, 2)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  DataColumn _dataColumn(String text) {
    return DataColumn(
      label: Expanded(
        child: Text(text, style: const TextStyle(fontStyle: FontStyle.italic)),
      ),
    );
  }

  DataRow _dataRow(ProgonkaLogic progonka, int index, int equation) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(progonka.a1[index].toStringAsFixed(10))),
        DataCell(Text(progonka.b1[index].toStringAsFixed(10))),
        DataCell(Text(progonka.c1[index].toStringAsFixed(10))),
        DataCell(Text(progonka.f1[index].toStringAsFixed(10))),
        DataCell(Text(progonka.alphaList1[index].toStringAsFixed(10))),
        DataCell(Text(progonka.bettaList1[index].toStringAsFixed(10))),
        DataCell(Text(equation == 1
            ? progonka.t0[index].toStringAsFixed(10)
            : progonka.t0[index].toStringAsFixed(10))),
      ],
    );
  }

  List<DataCell> _table3(int n, List<double> list, int row) {
    final labels = <String>['T₀', 'T₁₁', 'T'];
    return List.generate(
      n + 1,
      (i) => DataCell(
        Text(
          i == 0 ? labels[row] : (list[i - 1]).toStringAsFixed(10),
          style: i == 0 ? const TextStyle(fontStyle: FontStyle.italic) : null,
        ),
      ),
    );
  }
}
