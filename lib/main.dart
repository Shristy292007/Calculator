import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData.dark(), //
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String expression = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {});
    if (buttonText == "C") {
      output = "0";
      expression = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/" ||
        buttonText == "%") {
      num1 = double.parse(output);
      operand = buttonText;
      expression = "$output $buttonText";
      output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      expression += output;
      Expanded(
        child: Column(
          children: [
            Row(
              children: [
                _buildButton("C"),
                _buildButton("%"),
                _buildButton("/"),
              ],
            ),
            Row(
              children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("*"),
              ],
            ),
          ],
        ),
      );

      if (operand == "+") {
        output = (num1 + num2).toString();
      }
      if (operand == "-") {
        output = (num1 - num2).toString();
      }
      if (operand == "*") {
        output = (num1 * num2).toString();
      }
      if (operand == "/") {
        output = num2 != 0 ? (num1 / num2).toString() : "Error";
      }
      if (operand == "%") {
        output = (num1 % num2).toString();
      }
      // Clean up trailing.0 for clean integers
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      operand = "";
    } else {
      //Handle number inputs
      if (output == "0") {
        output = buttonText;
      } else {
        output = output + buttonText;
      }
    }
  }

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            foregroundColor: textColor,
          ),
          onPressed: () {
            buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          //Display Screen Area
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    expression,
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    output,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Button Pad Layout
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //
                Row(
                  children: [
                    _buildButton("C",color: Colors.redAccent),
                    _buildButton("%", color: Colors.amber[700]),
                     _buildButton("/", color: Colors.amber[700]),
                     _buildButton("*", color: Colors.amber[700]),
                  ],
                ),
                    Row(
                      children: [
                        _buildButton("7"),
                        _buildButton("8"),
                        _buildButton("9"),
                        _buildButton("-", color: Colors.amber[700]),
                      ],
                    ),

                    Row(
                      children: [
                        _buildButton("4"),
                        _buildButton("5"),
                        _buildButton("6"),
                        _buildButton("+", color: Colors.amber[700]),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("1"),
                        _buildButton("2"),
                        _buildButton("3"),
                        _buildButton("=", color: Colors.amber[700]),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("0"),
                        _buildButton("."),
                        _buildButton(
                          "=",
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
          ),
              ],
            ),
          );
  }
}
