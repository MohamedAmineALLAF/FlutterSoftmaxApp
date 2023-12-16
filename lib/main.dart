import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softmax Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SoftmaxCalculator(),
    );
  }
}

class SoftmaxCalculator extends StatefulWidget {
  @override
  _SoftmaxCalculatorState createState() => _SoftmaxCalculatorState();
}

class _SoftmaxCalculatorState extends State<SoftmaxCalculator> {
  final x1Controller = TextEditingController();
  final x2Controller = TextEditingController();
  final x3Controller = TextEditingController();
  final x4Controller = TextEditingController();

  List<double> probabilities = [0.0, 0.0, 0.0, 0.0];

  void calculateSoftmax() {
    double x1 = double.tryParse(x1Controller.text) ?? 0;
    double x2 = double.tryParse(x2Controller.text) ?? 0;
    double x3 = double.tryParse(x3Controller.text) ?? 0;
    double x4 = double.tryParse(x4Controller.text) ?? 0;

    var inputs = [x1, x2, x3, x4];
    var maxVal = inputs.reduce(max);
    var exps = inputs.map((val) => exp(val - maxVal)).toList();
    var sumExps = exps.reduce((sum, val) => sum + val);
    var softmax = exps.map((val) => val / sumExps).toList();

    setState(() {
      probabilities = softmax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Softmax Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildRoundedTextField(x1Controller, 'x1'),
            _buildResultText(probabilities[0]),
            _buildRoundedTextField(x2Controller, 'x2'),
            _buildResultText(probabilities[1]),
            _buildRoundedTextField(x3Controller, 'x3'),
            _buildResultText(probabilities[2]),
            _buildRoundedTextField(x4Controller, 'x4'),
            _buildResultText(probabilities[3]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSoftmax,
              child: Text('Softmax'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(
      TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  Widget _buildResultText(double probability) {
    return Text(
      'P: ${probability.toStringAsFixed(2)}',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}
