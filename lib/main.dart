import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String displayText = '0';
  String firstOperand = '';
  String secondOperand = '';
  String operator = '';
  bool isSecondOperand = false;

  void onButtonClick(String value) {
    setState(() {
      if (value == 'AC') {
        displayText = '0';
        firstOperand = '';
        secondOperand = '';
        operator = '';
        isSecondOperand = false;
      } else if (value == 'C') {
        if (isSecondOperand) {
          secondOperand = '';
          displayText = firstOperand;
        } else {
          firstOperand = '';
          displayText = '0';
        }
      } else if (value == '⌫') {
        if (displayText.isNotEmpty && displayText != '0') {
          displayText = displayText.substring(0, displayText.length - 1);
          if (displayText.isEmpty) {
            displayText = '0';
          }
        }
      } else if ('0123456789.'.contains(value)) {
        if (isSecondOperand) {
          secondOperand += value;
          displayText = secondOperand;
        } else {
          firstOperand += value;
          displayText = firstOperand;
        }
      } else if ('+-×÷%'.contains(value)) {
        if (firstOperand.isNotEmpty) {
          operator = value;
          isSecondOperand = true;
        }
      } else if (value == '=') {
        if (firstOperand.isNotEmpty && secondOperand.isNotEmpty && operator.isNotEmpty) {
          double num1 = double.parse(firstOperand);
          double num2 = double.parse(secondOperand);
          double result = 0;

          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case '×':
              result = num1 * num2;
              break;
            case '÷':
              result = num1 / num2;
              break;
            case '%':
              result = num1 % num2; // Modulus operation
              break;
          }

          displayText = result.toString();
          firstOperand = result.toString();
          secondOperand = '';
          operator = '';
          isSecondOperand = false;
        }
      }
    });
  }

  Widget buildButton(String label, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => onButtonClick(label),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
        backgroundColor: Color(0x40000000),
        title: Text(
          'Calculator',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Calculator',
                applicationVersion: 'Version 1.3.0',
                applicationIcon: Icon(Icons.calculate),
                children: [
                  Text("Developer: Sahil Sachin Dudhal"),
                  GestureDetector(
                    onTap: () {
                      print("GitHub Username: SAHILDUDHAL21");
                    },
                    child: Text(
                      "GitHub: SAHILDUDHAL21",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("LinkedIn Username: sahil-dudhal-1b11b925a");
                    },
                    child: Text(
                      "LinkedIn: sahil-dudhal-1b11b925a",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text("This is an FOSS (Free and Open Source Software) app."),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              color: Colors.black,
              padding: EdgeInsets.all(20),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('', Colors.transparent),
                    buildButton('', Colors.transparent),
                    buildButton('', Colors.transparent),
                    buildButton('', Colors.transparent),
                  ],
                ),
                Row(
                  children: [
                    buildButton('AC', Color(0x80750E21)),
                    buildButton('C', Color(0x409E4784)),
                    buildButton('⌫', Color(0x409E4784)),
                    buildButton('÷', Color(0x409EC8B9)),
                  ],
                ),
                Row(
                  children: [
                    buildButton('7', Color(0x40116D6E)),
                    buildButton('8', Color(0x40116D6E)),
                    buildButton('9', Color(0x40116D6E)),
                    buildButton('×', Color(0x409EC8B9)),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4', Color(0x40116D6E)),
                    buildButton('5', Color(0x40116D6E)),
                    buildButton('6', Color(0x40116D6E)),
                    buildButton('-', Color(0x409EC8B9)),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1', Color(0x40116D6E)),
                    buildButton('2', Color(0x40116D6E)),
                    buildButton('3', Color(0x40116D6E)),
                    buildButton('+', Color(0x409EC8B9)),
                  ],
                ),
                Row(
                  children: [
                    buildButton('.', Color(0x409EC8B9)),
                    buildButton('0', Color(0x40116D6E)),
                    buildButton('=', Color(0xFF183D3D)),
                    buildButton('%', Color(0x409EC8B9)), // Modulus button
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