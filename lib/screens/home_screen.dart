import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../components/adspace.dart';

import '../provider/drinking_model.dart';

import '../model/calculator_brain.dart';

import '../screens/result_screen.dart';
import '../screens/tic_tac_toe_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _form = GlobalKey<FormState>();

  final _transportBudgetFocusNode = FocusNode();
  final _foodBudgetFocusNode = FocusNode();
  final _drinkPriceFocusNode = FocusNode();
  var drinkDetails = Drinkly(
    budget: 0,
    transportBudget: 0,
    foodBudget: 0,
    drinkPrice: 0,
  );

  @override
  void dispose() {
    _transportBudgetFocusNode.dispose();
    _foodBudgetFocusNode.dispose();
    _drinkPriceFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print(drinkDetails.budget);
    print(drinkDetails.transportBudget);
    print(drinkDetails.foodBudget);
    print(drinkDetails.drinkPrice);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: (Provider.of<Calculator>(context).calculateVariable(
            drinkDetails.budget,
            drinkDetails.transportBudget,
            drinkDetails.foodBudget,
            drinkDetails.drinkPrice,
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('drinkly'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          'The premiere "How many drinks can I buy tonight?" app. Designed to explain the functional use of the formula "y=mx+c" in a real world enviroment.',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Start \nGame',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.3,
                              color: Colors.grey[200],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Icon tapped');
                              Navigator.pushNamed(context, TicTacToe.id);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.games_rounded,
                                    size: 40.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Tic-Tac-Toe',
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Value';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Please enter value greater than 0';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_transportBudgetFocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: 'What is your night budget mah dude?',
                              labelText: 'Budget',
                            ),
                            onSaved: (value) {
                              drinkDetails = Drinkly(
                                budget: double.parse(value),
                                transportBudget: drinkDetails.transportBudget,
                                foodBudget: drinkDetails.foodBudget,
                                drinkPrice: drinkDetails.drinkPrice,
                              );
                            },
                          ),
                          TextFormField(
                            focusNode: _transportBudgetFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Value';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              if (double.parse(value) < 0) {
                                return 'Please enter value greater than 0';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_foodBudgetFocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: 'What is your logistics cost?',
                              labelText: 'Transport Budget',
                            ),
                            onSaved: (value) {
                              drinkDetails = Drinkly(
                                budget: drinkDetails.budget,
                                transportBudget: double.parse(value),
                                foodBudget: drinkDetails.foodBudget,
                                drinkPrice: drinkDetails.drinkPrice,
                              );
                            },
                          ),
                          TextFormField(
                            focusNode: _foodBudgetFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Value';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              if (double.parse(value) < 0) {
                                return 'Please enter value greater than 0';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_drinkPriceFocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: 'As you eat, what\'s the damage?',
                              labelText: 'Food Budget',
                            ),
                            onSaved: (value) {
                              drinkDetails = Drinkly(
                                budget: drinkDetails.budget,
                                transportBudget: drinkDetails.transportBudget,
                                foodBudget: double.parse(value),
                                drinkPrice: drinkDetails.drinkPrice,
                              );
                            },
                          ),
                          TextFormField(
                            focusNode: _drinkPriceFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Value';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Please enter value greater than 0';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'What is your favorite drink price?',
                              labelText: 'Drink Price',
                            ),
                            onSaved: (value) {
                              drinkDetails = Drinkly(
                                budget: drinkDetails.budget,
                                transportBudget: drinkDetails.transportBudget,
                                foodBudget: drinkDetails.foodBudget,
                                drinkPrice: double.parse(value),
                              );
                            },
                          ),
                          SizedBox(height: 30.0),
                          GestureDetector(
                            onTap: () {
                              _saveForm();
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.purple,
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  AdSpace(
                    url: 'https://myinsure.africa/',
                    imageURL: 'assets/images/cr.jpg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
