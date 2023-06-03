import 'dart:math';

class ProgonkaLogic {
  ProgonkaLogic({
    required this.n,
    required this.e,
    required this.v,
    required this.x,
    required this.betta,
    required this.alpha,
    required this.t0,
    required this.t11,
  });

  final int n;
  final int e;

  final double v; // коэффициент вязкости
  final double x; // коэффициент температуропроводности
  final double betta; // коэффициент теплового расширения
  final double alpha; // коэффициент теплоотдачи
  final double g = 9.81; // коэффициент ускорение свободного падения

  final List<double> t0; // температура нагрева
  final List<double> t11; // температура среды
  final List<double> t = []; // результат

  late final double h;
  late final double gr;
  late final double pr;
  late final double delta;

  final double teta = 1; // 
  final int H = 1;

  final List<double> alphaList1 = [0.0];
  final List<double> bettaList1 = [0.0];
  final List<double> alphaList2 = [0.0];
  final List<double> bettaList2 = [1.0]; // const 

  final List<double> a1 = [];
  final List<double> a2 = [];
  final List<double> b1 = [];
  final List<double> b2 = [];
  final List<double> c1 = [];
  final List<double> c2 = [];
  final List<double> f1 = [];
  final List<double> f2 = [];

  void init() {
    _setGr();
    _setPr();
    _setDelta();
    _seth();

    _forward();
    _backward();
    _setT();
  }

  void _setGr() => gr = g * betta * teta * pow(H, 5) / (v * v * e * e);
  void _setPr() => pr = v / x;
  void _setDelta() => delta = H / e;
  void _seth() => h = 1 / n;

  double _w(double H) => pow(1 - H, 2).toDouble();
  double _u(int i) => 1;

  void _forward() {
    final temp = 1 / (pr * gr * delta * delta * h * h);

    for (var i = 0; i < n; i++) {
      final y = i / n;

      a1.add(temp + (_w(y) / 2 * h));
      a2.add(temp + (1 / 2 * h));
      b1.add(-2 * temp - 2 * _u(i));
      b2.add(-2 * temp);
      c1.add(temp - (_w(y) / 2 * h));
      c2.add(temp - (1 / 2 * h));
      f1.add(0);
      f2.add(-1 / (pr * gr * _w(y)));

      final temp1 = 1 / (a1[i] * alphaList1[i] + b1[i]);
      final temp2 = 1 / (a2[i] * alphaList2[i] + b2[i]);

      alphaList1.add(-c1[i] * temp1);
      bettaList1.add(f1[i] - a1[i] * bettaList1[i] * temp1);
      alphaList2.add(-c2[i] * temp2);
      bettaList2.add(f2[i] - a2[i] * bettaList2[i] * temp2);
    }
  }

  void _backward() {
    for (var i = n - 2; i >= 0; i--) {
      t11.insert(0, t11.first * alphaList1[i + 1] + bettaList1[i + 1]);
      t0.insert(0, t0.first * alphaList2[i + 1] + bettaList2[i + 1]);
    }
  }

  void _setT() {
    for (int i = 0; i < n; i++) {
      t.add(t0[i] + t11[i] * e * e / 2);
    }

    // int j = 0;
    // for (int i = -e ~/ 2; i <= e ~/ 2; i++) {
    //   t.add(t0[j] + t11[j] * i * i / 2); //  e или i
    //   j++;
    // }
  }
}
