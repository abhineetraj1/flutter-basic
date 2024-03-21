import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}
var Sldate=DateTime.now().toString().split(" ")[0];
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
    );
  }
}
var list =[];
class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String data = "No data";
  Future _getTasks() async{
    var storage= new FlutterSecureStorage();
    var e = await storage.read(key:"tasks");
    setState(() {
      data=e??"No data";
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTasks();
    for (String i in data.split("%%")) {
      if (i != "" && i != "No data") {
        list.add(i.split("%"));
      }
    }
    print(list);
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return AddTask();
          }));
        },child: Icon(Icons.add, color: Colors.black,), backgroundColor: Colors.white,),
        appBar: AppBar(title: Center(child: Text("To do list")), backgroundColor: Colors.black, elevation: 0,),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(data == "" || data == "No data" ? "No data" :"", style: TextStyle(color: Colors.white, fontSize: 20)),
                if (data != "" && data != "No data") for (String i in data.split("%%")) if (i != "No data" && i!="") Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                        boxShadow: [BoxShadow(color: Colors.white, blurStyle: BlurStyle.outer, blurRadius: 5)]
                      ),
                      width: MediaQuery.sizeOf(context).width*0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Deadline: "+i.split("%")[1].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),),
                                IconButton(onPressed: () {
                                  var storage = new FlutterSecureStorage();
                                  Future GTk() async {
                                    print(data);
                                    data = data.replaceAll("%%"+i,"");
                                    await storage.write(key: "tasks", value: data);
                                  }
                                  GTk();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return Index();
                                  }));
                                }, icon: Icon(Icons.delete, color: Colors.white,))
                              ],
                            ),
                            Align(alignment: Alignment.centerLeft,child: Text(i.split("%")[0].toString(), style: TextStyle(color: Colors.white),))
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
      ),
    );
  }
}

class AddTask extends StatelessWidget {
  var a = TextEditingController();
  var storage = new FlutterSecureStorage();
  AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Index();
          }));
        },child: Icon(Icons.arrow_back, color: Colors.black,), backgroundColor: Colors.white,),
        backgroundColor: const Color.fromARGB(255, 96, 96, 96),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white, width: 2)
                  ),
                  fillColor: Colors.white,
                  hintText: "Enter task",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Enter task",
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                controller: a,
              ),
              SelectDate(),
              ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black
              ),onPressed: () {
                Future _UpdateStorage() async {
                  var t = await storage.read(key: "tasks");
                  if (t== null) {
                    t="";
                  }
                  var g = await storage.write(key: "tasks", value:t+"%%"+a.text+"%"+Sldate);
                }
                if (a.text != "") {
                  _UpdateStorage();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Index();
                  }));
                }
              }, child: Text("Add task"))
            ],
          ),
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  var date=DateTime.now();
  bool isVisible =true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Visibility(
            visible: isVisible,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  isVisible=!isVisible;
                });
              },
              child: Text(date.toString().split(" ")[0], style: TextStyle(color: Colors.black),),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 218, 214, 214)
              ),
              child: TableCalendar(firstDay: DateTime.now(),focusedDay: date, lastDay: DateTime.utc(2100,1,1),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    isVisible=!isVisible;
                    date = selectedDay;
                    Sldate= selectedDay.toString().split(" ")[0];
                  });
                },
              ),),
          )
        ],
      ),
    );
  }
}