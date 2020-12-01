import 'package:drinkly/model/calculator_brain.dart';
import 'package:drinkly/provider/drinking_model.dart';
import 'package:drinkly/screens/tic_tac_toe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Calculator(),
        ),
        ChangeNotifierProvider.value(
          value: Drinkly(
            budget: 0,
            transportBudget: 0,
            foodBudget: 0,
            drinkPrice: 0,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'drinkly app',
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ResultScreen.id: (context) => ResultScreen(),
          TicTacToe.id: (context) => TicTacToe(),
        },
      ),
    );
  }
}

// GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);

//           if (!currentFocus.hasPrimaryFocus) {
//             currentFocus.unfocus();
//           }
//         }
