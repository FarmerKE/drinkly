import 'package:flutter/material.dart';

class Drinkly with ChangeNotifier {
  final double budget;
  final double transportBudget;
  final double foodBudget;
  final double drinkPrice;

  Drinkly({
    @required this.budget,
    @required this.transportBudget,
    @required this.foodBudget,
    @required this.drinkPrice,
  });
}
