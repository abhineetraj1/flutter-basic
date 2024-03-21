import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
    );
  }
}

var survey = [false,false,false,false,false];
List query_list = [["The checkered flag signifies the end of a Formula 1 race. How many times is it waved by the race marshal to signal the finish?",["Once","Twice (Correct)","Three times","Continuously throughout the final lap"],1],["What is the penalty for exceeding the track limits in Formula 1?",["Deduction of championship points","Mandatory pit stop (Correct)","Disqualification from the race","Loss of starting position for the next race"],2],["Which of the following types of tires offer the most grip but wear out the fastest in Formula 1?",["Wet weather tires","Intermediate tires","Soft tires (Correct)","Hard tires"],3],["During a safety car deployment in F1, which of the following statements is true?",["Only the race leader is allowed to overtake slower cars.","All cars must maintain their positions on track.","Backmarkers can overtake the safety car to rejoin the lead group. (Correct)","Drivers can make pit stops freely behind the safety car."],2],["DRS (Drag Reduction System) can only be activated by a driver within a designated zone on the track. This zone is typically located:",["Before a corner to gain speed for entry","Immediately after a corner for faster acceleration (Correct)","In the middle of a long straight for maximum effect","Only on the starting straight"],2]];

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 250,),
              Image.asset("assets/formula1.png"),
              SizedBox(height: 300,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.9,
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                    return QuizWindow();
                  })));
                }, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Start Quiz", style: TextStyle(fontSize: 20),),
                ), style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuizWindow extends StatelessWidget {
  const QuizWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Quiz App", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                for (List i in query_list) QuizContainer(i[0],i[1],i[2],query_list.indexOf(i)),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () {
                  var n =0;
                  for(bool i in survey) if (i == true) n=n+1;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ResultWindow("$n");
                  }));
                }, child: Text("Evaluate", style: TextStyle(fontSize: 18),), style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      )
    );
  }
}

class QuizContainer extends StatefulWidget {
  final String question;
  final int resultIndex;
  final List options;
  final int correctOption;
  QuizContainer(this.question, this.options, this.correctOption, this.resultIndex);

  @override
  State<QuizContainer> createState() => _QuizContainerState();
}

class _QuizContainerState extends State<QuizContainer> {
  var optionSelected =5;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20,blurStyle: BlurStyle.outer)]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft,child: Text(widget.question, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              for (String i in widget.options) Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() { 
                      optionSelected =(optionSelected != widget.options.indexOf(i)) ? widget.options.indexOf(i) : 5;
                      survey[widget.resultIndex] = optionSelected == widget.correctOption;
                    });
                  },
                  child: AnimatedContainer(duration: Duration(milliseconds: 300,),
                    decoration: BoxDecoration(
                      color: optionSelected==widget.options.indexOf(i)?Colors.black:Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(child: Text(["A","B","C","D"][widget.options.indexOf(i)]+")", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: optionSelected==widget.options.indexOf(i)? Colors.white : Colors.black),)),
                          SizedBox(width: 10,),
                          SizedBox(width: MediaQuery.sizeOf(context).width*0.65,child: Text(i, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: optionSelected==widget.options.indexOf(i)? Colors.white : Colors.black),))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ResultWindow extends StatelessWidget {
  final String score;
  ResultWindow(this.score);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height *0.35,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(200), boxShadow: [BoxShadow(color: Colors.black, blurStyle: BlurStyle.outer, blurRadius: 15)]),
              child: Center(
                child: SizedBox(
                  height: 50,
                  child: Column(
                    children: [
                      Text(score, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("Out of 5", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StartPage();
              }));
            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Retry", style: TextStyle(fontSize: 20),),
            ), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
            ),)
          ],
        )),
      ),
    );
  }
}