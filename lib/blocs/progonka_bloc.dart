import 'dart:math';

import 'package:diplom/logic/progonka.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgonkaBloc extends Bloc<ProgonkaEvent, ProgonkaState> {
  ProgonkaBloc() : super(ProgonkaLoadingState()) {
    on<ProgonkaInitEvent>((event, emit) async {
      final progonka = ProgonkaLogic(
        n: 10,
        e: 10,
        v: 17.4 * pow(10, -6),
        x: 19.0 * pow(10, -6),
        betta: 150.0 * pow(10, -6),
        alpha: 15.0,
        t0: [7727.0, 7727.0],
        t11: [0.0, 0.0],
      )..init();
      emit(ProgonkaDataState(progonka));
    });

    on<ProgonkaDataEvent>((event, emit) async {
      event.progonka.init();
      emit(ProgonkaDataState(event.progonka));
    });
  }
}

abstract class ProgonkaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgonkaInitEvent extends ProgonkaEvent {}

class ProgonkaDataEvent extends ProgonkaEvent {
  final ProgonkaLogic progonka;
  ProgonkaDataEvent(this.progonka);

  @override
  List<Object?> get props => [super.props, progonka];
}

abstract class ProgonkaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgonkaLoadingState extends ProgonkaState {}

class ProgonkaDataState extends ProgonkaState {
  final ProgonkaLogic progonka;
  ProgonkaDataState(this.progonka);

  @override
  List<Object?> get props => [super.props, progonka];
}
