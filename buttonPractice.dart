import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int number1 = 0;
  int number2 = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Natalie's Button Test"),
        ),
        body: Column(
          children: [
           displayContainer("harold"),
           displayContainer("the hedgechog"),
           displayContainer("bob"),
           displayNumber(1, number1),
           displayNumber(2, number2),
           displayHarold(),
           makeButton(),
           makeButton2(),
           resetNumbersButton(),
           buttonRow(),
           rowText,
          ],
        ),
      ), 
    );
  }
  Widget rowText = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("hello"),
          Text("my name is"),
          Text("Harold"),
        ],
      ),
    );

  Widget buttonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          makeButton(),
          makeButton2(),
          resetNumbersButton(),
        ],
    )
  );
  } 

  Widget displayNumber(int label, int number) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Text("Number $label: $number"), 
    );
  }
  Widget displayHarold(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Text("harold"),
    );
  }
  Widget displayContainer(String s){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      child: Text(s),
    );
  }
  Widget makeButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Number 1'),
        color: Colors.yellow,
        textColor: Colors.blue,
        onPressed: increment1,
      ),
    );
  }
  void increment1(){
    setState(() {
      number1 = number1 + 1;
    });
    
  }
  Widget makeButton2() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Number 2'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: increment2,
      ),
    );
  }
  void increment2(){
    setState(() {
      number2 = number2 + 1;
    });
  }
  Widget resetNumbersButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Reset'),
        color: Colors.blue,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            number1 = 0;
            number2 = 0;  
          });
          
          },
      ),
    );
  }
}


