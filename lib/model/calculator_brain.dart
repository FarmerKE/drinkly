import 'package:flutter/material.dart';

class Calculator with ChangeNotifier {
  final double budget;
  final double transportBudget;
  final double foodBudget;
  final double drinkPrice;

  Calculator({
    this.budget,
    this.transportBudget,
    this.foodBudget,
    this.drinkPrice,
  });

  double _drinkVariable;

  String calculateVariable(budget, transportBudget, foodBudget, drinkPrice) {
    _drinkVariable = (budget - transportBudget - foodBudget) / drinkPrice;
    return _drinkVariable.toStringAsFixed(0);
  }
}
