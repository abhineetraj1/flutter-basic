import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(
	debugShowCheckedModeBanner: false,
	home: HomePage(),
	);
}
}

class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
var userInput = '';
var answer = '';
final List<String> buttons = ['C','+/-','%','DEL','7','8','9','/','4','5','6','x','1','2','3','-','0','.','=','+',];

@override
Widget build(BuildContext context) {
	return Scaffold(
	backgroundColor: Colors.black,
	body: Column(
		children: <Widget>[
		Expanded(
			child: Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Container(
					padding: EdgeInsets.all(20),
					alignment: Alignment.centerRight,
					child: Text(
						userInput,
						style: TextStyle(fontSize: 18, color: Colors.white),
					),
					),
					Container(
					padding: EdgeInsets.all(15),
					alignment: Alignment.centerRight,
					child: Text(
						answer,
						style: TextStyle(
							fontSize: 30,
							color: Colors.white,
							fontWeight: FontWeight.bold),
					),
					)
				]),
			),
		),
		Expanded(
			flex: 3,
			child: Container(
			child: GridView.builder(
				itemCount: buttons.length,
				gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
					crossAxisCount: 4),
				itemBuilder: (BuildContext context, int index) {
					if (index == 0) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput = '';
							answer = '0';
						});
						},
						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}
					else if (index == 1) {
					return MyButton(
						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}
					else if (index == 2) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += buttons[index];
						});
						},
						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}
					else if (index == 3) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput =
								userInput.substring(0, userInput.length - 1);
						});
						},
						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}
					else if (index == 18) {
					return MyButton(
						buttontapped: () {
						setState(() {
							equalPressed();
						});
						},
						buttonText: buttons[index],
						color: Colors.orange[700],
						textColor: Colors.white,
					);
					}
					else {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += buttons[index];
						});
						},
						buttonText: buttons[index],
						color: isOperator(buttons[index])
							? const Color.fromARGB(255, 255, 112, 68)
							: Colors.white,
						textColor: isOperator(buttons[index])
							? Colors.white
							: Colors.black,
					);
					}
				}),
			),
		),
		],
	),
	);
}

bool isOperator(String x) {
	if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
	return true;
	}
	return false;
}
void equalPressed() {
	String finaluserinput = userInput;
	finaluserinput = userInput.replaceAll('x', '*');

	Parser p = Parser();
	Expression exp = p.parse(finaluserinput);
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toString();
}
}

class MyButton extends StatelessWidget {
final color;
final textColor;
final buttonText;
final buttontapped;
MyButton({this.color, this.textColor, this.buttonText, this.buttontapped});
@override
Widget build(BuildContext context) {
	return GestureDetector(
	onTap: buttontapped,
	child: Padding(
		padding: const EdgeInsets.all(10),
		child: ClipRRect(
		borderRadius: BorderRadius.circular(100),
		child: Container(
			color: color,
			child: Center(
			child: Text(
				buttonText,
				style: TextStyle(
				color: textColor,
				fontSize: 21,
				fontWeight: FontWeight.bold,
				),
			),
			),
		),
		),
	),
	);
}
}
