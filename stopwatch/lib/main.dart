import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
var data =0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool action = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (action != true) {
        data = data +1;
        setState(() {
          action=action;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 200,),
                Text(data.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: () {
                        setState(() {
                          action=!action;
                        });
                      }, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(action?"Start":"Stop", style: TextStyle(fontSize: 18),),
                      ),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                      ElevatedButton(onPressed: () {
                        setState(() {
                          data =0;
                          action=true;
                        });
                      }, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Reset", style: TextStyle(fontSize: 18),),
                      ),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                    ],
                  ),
                ),
                SizedBox(height: 200,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}