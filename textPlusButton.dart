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
  final myController = TextEditingController();

@override
void dispose(){
  myController.dispose();
  super.dispose();
}

void translator(){
    if (myController.text == "dog"){
      myController.text = "perro";
    }
    else{
      myController.text = "no se";
    }
  }
  Widget translateButton(BuildContext context){
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('Translate'),
        color: Colors.yellow,
        textColor: Colors.blue,


        onPressed: () {
            /*return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("ehllo")
              );
            },
          );*/
        },
      ),
    );
  }
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Natalie's Button Test"),
        ),
        body: Column(
          children: [
           Text("Number 1"),
           buttonRow1(),
           Text("Number 2"),
           buttonRow2(),
           Text("Reset"),
           buttonRow3(),
           translateRow(context),
           
          ],
        ),
        floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          translator();
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("loooop")
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
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

  Widget translateRow(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          translateButton(context),
          Container(
            width:300.0,
            child: TextField(
            controller: myController,
          ),
          )
          
        ],
      )
    );
  }

  Widget buttonRow1(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(number1.toString()),
          addButton1(),
          substractButton1(),
        ],
    )
   );
  }

  Widget buttonRow2(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(number2.toString()),
          addButton2(),
          substractButton2(),
          addTwoButton(),
          subtractTwoButton(),
        ],
    )
  );
  }  

  Widget buttonRow3(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          resetNumberOneButton(),
          resetNumberTwoButton(),
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
  Widget addButton1() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('+'),
        color: Colors.yellow,
        textColor: Colors.blue,
        onPressed: increment1,
      ),
    );
  }

  Widget addButton2() {
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('+'),
        color: Colors.yellow,
        textColor: Colors.blue,
        onPressed: increment2,
      ),
    );
  }
  void increment1(){
    setState(() {
      number1 = number1 + 1;
    });
  }
  void decrement1(){
    setState(() {
      number1 = number1 - 1;
    });
  }
  Widget substractButton1() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('-'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: decrement1,
      ),
    );
  }
  Widget substractButton2() {
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('-'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: decrement2,
      ),
    );
  }
  void increment2(){
    setState(() {
      number2 = number2 + 1;
    });
  }
  void decrement2(){
    setState(() {
      number2 = number2 -1 ;
    });
  }
  

  Widget resetNumberOneButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Reset Number 1'),
        color: Colors.blue,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            number1 = 0;  
          });
          
          },
      ),
    );
  }
  Widget resetNumberTwoButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Reset Number 2'),
        color: Colors.blue,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            number2 = 0;  
          });
          
          },
      ),
    );
  }







  Widget subtractTwoButton(){
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('-2'),
        color: Colors.blue,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            number2 = number2 - 2;
          });
          
          },
      ),
    );
  }
  Widget addTwoButton(){
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('+2'),
        color: Colors.blue,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            number2 = number2 + 2;
          });
          
          },
      ),
    );
  }  
}
