import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class CalcButton extends StatefulWidget {
  @override
  _CalcButtonState createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  double _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue,
      hideExpression: false,
      hideSurroundingBorder: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        print("$key\t$value\t$expression");
      },
      onTappedDisplay: (value, details) {
        print("$value\t${details.globalPosition}");
      },
      theme: const CalculatorThemeData(
        borderColor: Color(0xFF337A6F),
        borderWidth: 2,
        displayColor: Color(0xFF337A6F),
        displayStyle: TextStyle(fontSize: 50, color: Colors.white),
        expressionColor: Color(0xFF337A6F),
        expressionStyle: TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.white,
        operatorStyle: TextStyle(fontSize: 30, color: Color(0xFF337A6F)),
        commandColor: Colors.white,
        commandStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF337A6F)),
        numColor: Color(0xFF337A6F),
        numStyle: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text('      s m a t p a d    CAL'),
          elevation: 0.0,
        ),
        body: calc);
  }
}
