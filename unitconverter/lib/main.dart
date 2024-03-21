import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

var data = 0;
var unit = 0;
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

UnitConvertor() {
  int value = unit;
  if (value == 4 || value == 6 || value == 7 || value == 10) {
    data= data*1000;
  } else if (value == 3 || value == 5 || value == 8 || value == 9) {
    data = int.parse((data * 0.001).round().toString());
  } else if (value == 1) {
    data = int.parse((data * 0.01).round().toString());
  } else {
    data = data*100;
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height:30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  hintText:"Enter value",
                  labelText: "Enter value"
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value != "") {
                    data = int.parse(value);
                    setState(() {
                      UnitConvertor();
                    });
                  }
                },
              ),
              DropDownUnit(),
              SizedBox(height: 20,),
              Text("$data", style: TextStyle(fontSize: 20),)
            ],
          ),
        )
      ),
    );
  }
}

class DropDownUnit extends StatefulWidget {
  const DropDownUnit({super.key});

  @override
  State<DropDownUnit> createState() => _DropDownUnitState();
}

class _DropDownUnitState extends State<DropDownUnit> {
  int Invalue=1;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: Invalue,
      items: [
        DropdownMenuItem(child: TextD("from cm to m"), value: 1,),
        DropdownMenuItem(child: TextD("from m to cm"), value: 2,),
        DropdownMenuItem(child: TextD("from m to km"), value: 3,),
        DropdownMenuItem(child: TextD("from km to m"), value: 4,),
        DropdownMenuItem(child: TextD("from l to kl"), value: 5,),
        DropdownMenuItem(child: TextD("from kl to l"), value: 6,),
        DropdownMenuItem(child: TextD("from l to ml"), value: 7,),
        DropdownMenuItem(child: TextD("from ml to l"), value: 8,),
        DropdownMenuItem(child: TextD("from g to kg"), value: 9,),
        DropdownMenuItem(child: TextD("from kg to g"), value: 10,),
      ],
      onChanged: (value) {
        setState(() {
          unit=value!;
          Invalue = value;
          UnitConvertor();
        });
      },
    );
  }
}

TextD(String value) {
  return Text(value, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
}