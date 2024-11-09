import 'package:flutter/material.dart';

class PaymentModel with ChangeNotifier {
  double _nominalBayar = 0;

  double get nominalBayar => _nominalBayar;

  void setNominalBayar(double value) {
    _nominalBayar = value;
    notifyListeners();
  }
}
