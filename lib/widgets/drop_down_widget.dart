import 'dart:math';

import 'package:diplom/blocs/progonka_bloc.dart';
import 'package:diplom/logic/progonka.dart';
import 'package:diplom/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final _viscosity = [17.4 * pow(10, -6), 894 * pow(10, -6)];
  final _thermalDiffusivity = [19 * pow(10, -6), 0.143 * pow(10, -6)];
  final _extensions = [150 * pow(10, -6), 150 * pow(10, -6)];
  final _heatTransfer = [15, 3150];

  late final List<List<num>> _valueList;
  late final List<TextEditingController> _controllerList;
  final _nController = TextEditingController();
  final _eController = TextEditingController();
  final _t0Controller = TextEditingController();
  final _t11Controller = TextEditingController();
  final _viscosityController = TextEditingController();
  final _thermalDiffusivityController = TextEditingController();
  final _extensionsController = TextEditingController();
  final _heatTransferController = TextEditingController();

  @override
  void initState() {
    _valueList = [_viscosity, _thermalDiffusivity, _extensions, _heatTransfer];
    _controllerList = [
      _nController,
      _eController,
      _t0Controller,
      _t11Controller,
      _viscosityController,
      _thermalDiffusivityController,
      _extensionsController,
      _heatTransferController,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final labels = [
      l10n.iterations,
      l10n.horizontalDimension,
      l10n.heatingTemperature,
      l10n.ambientTemperature,
      l10n.viscosity,
      l10n.thermalDiffusivity,
      l10n.thermalExpansion,
      l10n.heatDissipation,
    ];

    return BlocBuilder<ProgonkaBloc, ProgonkaState>(
      builder: (context, state) {
        if (state is! ProgonkaDataState) return const SizedBox.shrink();

        _nController.text = state.progonka.n.toString();
        _eController.text = state.progonka.e.toString();
        _t0Controller.text = state.progonka.t0.last.toString();
        _t11Controller.text = state.progonka.t11.last.toString();
        _viscosityController.text = state.progonka.v.toString();
        _thermalDiffusivityController.text = state.progonka.x.toString();
        _extensionsController.text = state.progonka.betta.toString();
        _heatTransferController.text = state.progonka.alpha.toString();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              labels.length,
              (index) {
                final hasDropDown = index >= 4;
                return _DropDownFieldItem(
                  list: hasDropDown ? _valueList[index - 4] : [],
                  label: labels[index],
                  controller: _controllerList[index],
                  hasDropDown: hasDropDown,
                  onTap: (int i) => hasDropDown
                      ? _controllerList[index].text =
                          _valueList[index - 4][i].toString()
                      : null,
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final t0 = double.parse(_t0Controller.text);
                final t11 = double.parse(_t11Controller.text);
                context.read<ProgonkaBloc>().add(ProgonkaDataEvent(
                      ProgonkaLogic(
                        n: int.parse(_nController.text),
                        e: int.parse(_eController.text),
                        v: double.parse(_viscosityController.text),
                        x: double.parse(_thermalDiffusivityController.text),
                        betta: double.parse(_extensionsController.text),
                        alpha: double.parse(_heatTransferController.text),
                        t0: [t0, t0],
                        t11: [t11, t11],
                      ),
                    ));
              },
              child: Text(l10n.calculate),
            ),
          ],
        );
      },
    );
  }
}

class _DropDownFieldItem extends StatelessWidget {
  final List<num> list;
  final String label;
  final bool hasDropDown;
  final TextEditingController controller;
  final Function(int i) onTap;
  const _DropDownFieldItem({
    required this.list,
    required this.label,
    required this.hasDropDown,
    required this.controller,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 2.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(label),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          if (hasDropDown)
            DropdownButton<num>(
              underline: const ColoredBox(color: Colors.transparent),
              elevation: 16,
              onChanged: (num? _) {},
              items: List.generate(list.length, (index) {
                return DropdownMenuItem<num>(
                  value: list[index],
                  child: Text(index == 0 ? l10n.atmosphere : l10n.water),
                  onTap: () => controller.text = list[index].toString(),
                );
              }),
            ),
        ],
      ),
    );
  }
}
