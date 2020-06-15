import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
List <Person> personList = new List();
List <String> playerNamesList = new List();
int numberOfPlayers;
bool isVisible = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'GamePerson',
      home: MyCustomApp(),
      );
  }
}
class MyCustomApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyCustomApp> {
  int number = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("GamePerson"),
        ),
        body: Column(
          children: [
           displayContainer("Welcome to GamePerson!"),
           displayContainer("How many players will be joining?"),
           buttonRow(),
           playerNamesScreenButton(context),
          ],
        ),
    );
  }
  

  Widget buttonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          incrementButton(),
          Text('$number'),
          decrementButton(),
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
  
  Widget displayContainer(String s){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      child: Text(s),
    );
  }
  Widget incrementButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('+'),
        color: Colors.yellow,
        textColor: Colors.blue,
        onPressed: increment,
      ),
    );
  }
  Widget decrementButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('-'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: decrement,
      ),
    );
  }
  void increment(){
    setState(() {
      if (number < 5){
        number = number + 1;
      }
    });
    
  }
  
  void decrement(){
    setState(() {
      if(number > 1){
        number = number - 1;
      }
      
    });
  }

  Widget playerNamesScreenButton(BuildContext context){
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        child: Text('Proceed'),
        color: Colors.lightBlueAccent,
        textColor: Colors.black,
        onPressed:(){
          numberOfPlayers = number;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerNamesScreen()),
            );
        }
      ),
  );
  } 
  
}







class PlayerNamesScreen extends StatefulWidget {
  @override
  _PlayerNamesScreenState createState() => _PlayerNamesScreenState();
}


class _PlayerNamesScreenState extends State<PlayerNamesScreen> {
  //final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllers.forEach((c) => c.dispose());
    super.dispose();
  }
  @override
  
  List<Widget> _children = [];
  List<TextEditingController> _controllers = [];
  bool pressed = false;
  


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Player Names"),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: _add)],
      ),
      body: Column(
        children:[
          Expanded(
            child: ListView(children: _children), 
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
              child: Text('Next'),
              color: Colors.yellow,
              textColor: Colors.blue,
              onPressed:(){
                setState(() {
                  List<String> controllerText = [];
                  for (TextEditingController c in _controllers){
                    controllerText.add(c.text);
                  }
                  allPlayerGame(controllerText);
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArmyInfoScreen()),
                  );
                  
                });
              }
            ) 
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: FlatButton( 
              child: Text('Exit'),
              color: Colors.yellow,
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          )
        ]
      ,)
     
         
      
    );
  }

  void _add() {
    
    if (pressed == false){
      for (int i = 0; i < numberOfPlayers; i++){
        _controllers.add(new TextEditingController());
        setState(() {
          _children = List.from(_children)
          ..add(TextFormField(
          decoration: InputDecoration(hintText: "Player ${i+1}'s name"),
          controller: _controllers[i],
          ));
        });
      } 
    }
    pressed = true;
      

  }
  
  void allPlayerGame(playerNamesList){
    
    personList.clear();

    //Creates a list of weapon names 
    List<String> weaponList = new List();
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
    if (numberOfPlayers == 1){
      playerNamesList.add("Computer");
    }
    for(int n = 0; n < playerNamesList.length; n++){
      String name = playerNamesList[n];
      Random index = new Random();
      int age = index.nextInt(100)+1;
      String eyecolor = Nation.colorList[index.nextInt(Nation.colorList.length)];
      int height = index.nextInt(7)+1;
      String superpower = Nation.superpowerList[index.nextInt(Nation.superpowerList.length)]; 
      int health = 15;
      int defense = index.nextInt(11);
      String weapon = weaponList[index.nextInt(weaponList.length)];
      //generate a person for every player
      personList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon, null));
      
      //generates a nation for every person
      personList[n].nation = Nation(personList[n], "bob", 3);
      personList[n].nation.generateArmy();
    }  
    
  }

}

class ArmyInfoScreen extends StatefulWidget{
  @override
  _ArmyInfoScreenState createState() => _ArmyInfoScreenState();
}

class _ArmyInfoScreenState  extends State<ArmyInfoScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Army Info"),
      ),
      body: ListView(
        children:[
          displayArmyInfo(),
          beginButton(),
          
        ],
      ),
      
    );

  }

  Widget beginButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('BEGIN'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GamePlayScreen()),
          );
        }
      ),
    );
  }
  Widget displayArmyInfo(){
    String armyInfoString = "";
    
    for (int p = 0; p < personList.length; p++){
      armyInfoString += ("Player ${p + 1}: " + personList[p].introduceString());
      armyInfoString += "\n";
      armyInfoString += (personList[p].nation.nationInfo());
      armyInfoString += "\n";
    }
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(armyInfoString)
    );
  }
}

//class Dropdown extends StatelessWidget{

//}

class GamePlayScreen extends StatefulWidget{
  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen>{
  int playerTurn = 1;
  bool gameOver = false;
  bool pressed = false;
  String status  = "";


  List<Widget> widgetList = [];
  List <String> playerList = [];

  
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  
  String _selectedPlayer;
 
  @override
  void initState() {
    for (Person p in personList){
      playerList.add(p.name);
    }
    loadData();
    //_dropdownMenuItems = buildDropdownMenuItems(playerList);
   
    _selectedPlayer = _dropdownMenuItems[0].value;
    isVisible = false;


    super.initState();
  }
 
  List<DropdownMenuItem<String>> buildDropdownMenuItems(playerList) {
    List<DropdownMenuItem<String>> items = List();
        for(String p in playerList){
          items.add(
          DropdownMenuItem(
            child: Text(p),
            value: p,
          ),
        );
       }
     
      return items;
      
  } 

  onChangeDropdownItem(String selectedPlayer) {
    setState(() {
      _selectedPlayer = selectedPlayer;
    });
  }
  
  void loadData(){
      _dropdownMenuItems = [];
      _dropdownMenuItems = playerList.map((val) => new DropdownMenuItem<String>(
        child: new Text(val),
        value: val,
      )).toList();
      _selectedPlayer = _dropdownMenuItems[0].value;
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GamePerson"),
      ),
      body: Column(
        children:[
          Text("Player $playerTurn (${personList[playerTurn-1].name}): What would you like to do?"),
          buttonRow(),
          Text(status),
          Visibility(
            visible: isVisible == true,
            child: DropdownButton(
                    value: _selectedPlayer,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
            ),
          ),
          Visibility(
            visible: isVisible == true,
            child: confirmButton(),
          ),
          Visibility(
            visible: gameOver == true,
            child: restartButton(context),
          ),
        ],
      ),
    );

  }
   Widget buttonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          attackButton(),
          eatButton(),
          passButton(),
          
        ],
      )
    );
  } 


  Widget attackButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Attack'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
          if (pressed == false){
            if (gameOver == true){
              status = "GAME OVER. Return to beginning.";
              return;
            }
            if (personList[playerTurn-1].nation.armyList.length == 0 || personList[playerTurn-1].health <= 0){
              status = "Player $playerTurn (${personList[playerTurn-1].name}) is dead. Turn is skipped.";
              pressed = false;
              playerTurn++;
              return;
            }
            if (numberOfPlayers > 2){ 
              pressed = true;
              playerList.remove(personList[playerTurn-1].name);
              loadData();
              status = "";
              toggleVisbility();
              playerList.add((personList[playerTurn-1].name)); 
            }
            else{//there are 2 players
              if (gameOver == true){
                status = "GAME OVER. Return to beginning.";
                return;
              }
              status = "";
            
              if(playerTurn == 1){
                personList[playerTurn-1].nation.nationAttack(personList[playerTurn].nation, 10);
              }
              else{//playerTurn = 2
                personList[playerTurn-1].nation.nationAttack(personList[playerTurn-2].nation, 10);
              }
              personList.forEach((p) => status += p.nation.armyHealthString() + "\n");
            
              if(personList[0].nation.armyList.length == 0){
                status += ("\n" + personList[1].nation.leader.name + "'s army is victorious!!");
                gameOver = true;
              }
              if(personList[1].nation.armyList.length == 0){
                status += ("\n" + personList[0].nation.leader.name + "'s army is victorious!!");
                gameOver = true;
              }
              
              
              playerTurn++;
              if (playerTurn > personList.length)playerTurn = 1;
            }
          }
          });


          }
          
        ),
      );
    }
          
        

  Widget eatButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Eat'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            loadData();
            if(isVisible == true){
              toggleVisbility();
              pressed = false;
            }
            if (gameOver == true){
              status = "GAME OVER. Return to beginning.";
              return;
            }
            if (personList[playerTurn-1].nation.armyList.length == 0 || personList[playerTurn-1].health <= 0){
        
              status = "Player $playerTurn (${personList[playerTurn-1].name}) is dead. Turn is skipped.";
              playerTurn++;
              return;
            }
            status = "";
            personList[playerTurn-1].nation.feedArmy();
            status += personList[playerTurn-1].nation.nationInfo();

            playerTurn++;
            if (playerTurn > personList.length)playerTurn = 1;
          });
        }
      ),
    );
  }

  Widget passButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Pass'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: (){
          loadData();
          if(isVisible == true){
            toggleVisbility();
            pressed = false;
          }
          if (gameOver == true){
            status = "GAME OVER. Return to beginning.";
            return;
          }
          if (personList[playerTurn-1].nation.armyList.length == 0 || personList[playerTurn-1].health <= 0){
            setState(() {
              status = "Player $playerTurn (${personList[playerTurn-1].name}) is dead. Turn is skipped.";
              playerTurn++;
              
            });
            return;
          }
         setState(() {
            status = "";
            status += "Player $playerTurn passed.";
            playerTurn++;
            if (playerTurn > personList.length)playerTurn = 1;
          });
        }
      ),
    );
  }

  Widget confirmButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('Confirm'),
        color: Colors.purple,
        textColor: Colors.black,
        onPressed: (){
          setState(() {
            if (gameOver == true){
              status = "GAME OVER. Return to beginning.";
              if(numberOfPlayers>2)toggleVisbility();
              return;
            }
            //turns dropdown off
            if(numberOfPlayers>2)toggleVisbility();
            pressed = false;
            status = "";
            //Finds the index of the player that you want to attack
            int index = -1 ;
            for (Person p in personList){
              index++;
              if (p.name == _selectedPlayer){
                break;
              }
            }
            

            personList[playerTurn-1].nation.nationAttack(personList[index].nation, 10);
            //personList.forEach((p) => status += p.nation.armyHealthString() + "\n")
            List <Person> toRemove = [];
            if (personList[playerTurn-1].health <= 0){
                 //marks army members for removal
                  personList[playerTurn-1].nation.armyList.forEach((p) => toRemove.add(p));
                  //adds them to attacker's armyList
                  personList[index].nation.armyList.addAll(toRemove);
                  //removes army members from current player
                  personList[playerTurn-1].nation.armyList.removeWhere((p) => toRemove.contains(p));
                
            }
            if(personList[index].health <= 0){
                 //marks army members for removal
                  personList[index].nation.armyList.forEach((p) => toRemove.add(p));
                  //adds them to current player's armyList
                  personList[playerTurn-1].nation.armyList.addAll(toRemove);
                  //removes army members from attacker
                  personList[index].nation.armyList.removeWhere((p) => toRemove.contains(p));
            }
            int countOfAlivePlayers = 0;
            int indexOfWinner = 0;

         
            for(int i = 0; i < personList.length; i++){
     
              if (personList[i].nation.armyList.length != 0 && personList[i].health > 0){
                //if there is a alive player, add it to countOfAlivePlayers
                countOfAlivePlayers++; 
                indexOfWinner = i;
                
              }
              else{
                status += "\nThe leader of ${personList[i].name} is dead!";
                
                playerList.remove(personList[i].name);
                loadData();
              }
            }
    
            personList.forEach((p) => status += p.nation.armyHealthString() + "\n");
            if (countOfAlivePlayers == 1){
              status+= "\n${personList[indexOfWinner].name} is the winner!";
              gameOver = true;
              return;
            }
            if (countOfAlivePlayers == 0){
              status += "\n Everyone is dead!";
              gameOver = true;
              return;
            }

            
            loadData();
            playerTurn++;
            if (playerTurn > personList.length)playerTurn = 1;
          });
        }
      ),
    );
  }

  Widget restartButton(BuildContext context){
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text('RESTART'),
        color: Colors.blueAccent,
        textColor: Colors.black,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCustomApp()),
          );
        }
        
      ),
    );
  }
  
  void toggleVisbility(){
    setState(() {
      isVisible = !isVisible;
    });
  }

}










//******************************************** */
//gamePerson source code

class Person {
  
  
  String name;
  int age;
  String eyecolor;
  int height;
  String superpower;
  int health;
  int defense;
  Nation nation;
  
  bool escape = false;
  static bool silentMode = false;

  List <String> backpack = new List();
  
  static int hands = 2;
  List <String> objectsInHand = new List();
  
  static var fruitPower = {'apple':1, 'strawberry':2, 'watermelon': 3, 'lychee': -2};
  static var vegetablePower = {'kale': 1, 'broccoli': 2, 'carrot': 4};
  static var weaponPower = {'fist': 1, 'baseball bat': 2, 'sword': 4, 'magical rays of fruit': 7};
  
  
  
  //constructor
  Person(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon, Nation nationObject) {
    name = nameString;
    age = ageNum;
    eyecolor = eyeString;
    height = heightNum;
    superpower = superpowerString;
    health = healthNum;
    defense = defenseNum;
    nation = nationObject;
    
    backpack.add("apple");
    backpack.add("broccoli");
    backpack.add(weapon);
    if (weapon != "fist"){
       backpack.add("fist");
    }
    
    
    
  }
  

  
  //method
  void printHelper(String sentence){
    if (silentMode == false){
      //prints name of the object then put quotes around the string
      print(this.name + "(Nation of " + this.nation.leader.name + "):" + '"' + sentence + '"');
    }
    else{
      //do nothing
    }
    
  }
  
  bool isAlive(){
    if (health <= 0){
      this.printHelper("I died!");
      return false;
    }
    else{
      return true;
    }
  }
  void introduce() { 
    if (isAlive() == true){
    
    this.printHelper("Hi my name is " + name + ".  I am " + age.toString() + ".  I have " + eyecolor + " eyes!  I have " + hands.toString() + " hands! I am " + height.toString() + " feet tall and my superpower is " + superpower + ". My health is " + health.toString() + " and my defense is " + defense.toString()); 
   
    }
  }
  String introduceString() { 
    if (isAlive() == true){
    
      return("Hi my name is " + name + ".  I am " + age.toString() + ".  I have " + eyecolor + " eyes!  I have " + hands.toString() + " hands! I am " + height.toString() + " feet tall and my superpower is " + superpower + ". My health is " + health.toString() + " and my defense is " + defense.toString() + "."); 
   
    }
    return("");
  }
  
  bool checkFruit(food){
    if (fruitPower.containsKey(food)){
      return true;
    }
    else{
      return false;
    }
  }
  
  void eat(String food){
    if (isAlive() == true){
      if (backpack.contains(food) && checkFruit(food)){
        health = health + fruitPower[food];
        this.printHelper("I just ate a " + food + "! My health is now " + health.toString());
        backpack.remove(food);
      }
      else if (backpack.contains(food) && !checkFruit(food)){
        defense = defense + vegetablePower[food];
        this.printHelper("I just ate a " + food + "! My defense is now " + defense.toString());
        backpack.remove(food);
      }
      else{
        this.printHelper("I don't have a " + food);
      }
      if (health <= 0){
        this.printHelper("I died!!");
      }
      }
  }
  void starve(){
    if (isAlive() == true){
    health = health - 1;
    print("I'm starving! My health is now " + health.toString());
   }
  }
  
  void checkBackpack(){
    print(backpack);
  }
  
  void equip(String item){
    if (objectsInHand.contains(item)){
     this.printHelper("I took out my " + item + ".");
    }
    else if (objectsInHand.length == hands){
      this.printHelper("My hands are full");
    }
    else if(backpack.contains(item)){
      backpack.remove(item);
      objectsInHand.add(item);
      this.printHelper("I took out my " + item + ".");
    }
    else{
      this.printHelper("I don't have that.");
    }
    if (silentMode == false) print("");
      
  }
   
  void dropItemsInHand(){
    objectsInHand.removeRange(0,objectsInHand.length);
    print("Oh no I dropped all my items!");
  }  
  
  void revive(){
    health = 10;
    print("I have been revived!! :)");
  }
 
  String findWeaponInHand(){
    String weapon;
    weaponPower.forEach((k,v) => objectsInHand.contains(k)? weapon = k: weapon = weapon);
    
    return weapon;
  }

  
  void attack(Person human){
   
    if(human.health <= 3){
      if (checkSuperpower()){
          human.printHelper("I used my superpower to escape!");
          return;
        }
    }
   
    String weapon = this.findWeaponInHand();
     if (weapon == null){
       this.equip("fist");
       weapon = "fist";
    }
    int damageTaken = human.defense - getPower(weapon);
    if (damageTaken >= 0){
      human.printHelper("I didn't take any damage! I was able to defend the attack! My health is now " + human.health.toString());
    }
    else{
      human.health = human.health - damageTaken.abs();
      human.printHelper("I wasn't able to defend the attack! I took " + damageTaken.toString() + " damage and my health is now " + human.health.toString());
    }
    if (isAlive() == true){
      human.defense = human.defense - getPower(weapon);
      if (human.defense <= 0){
        human.defense = 0;
      }
      human.printHelper("My defense is now " + human.defense.toString());
    }else{
      //uses boolean isAlive
    }
    if (silentMode == false) print("");
    
  }
  
  bool checkSuperpower(){
    if (this.superpower == "flying"){
      Random superpowerProbability = new Random();
      int number = superpowerProbability.nextInt(101);
      if(number < 20){
        escape = true;
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  
  }
  
  void criticalAttack(Person human){
    for (int i=0; i<human.objectsInHand.length;i++){
      this.backpack.add(human.objectsInHand[i]);
    }
    human.dropItemsInHand();
    
  }
  int getPower(weapon){
    return weaponPower[weapon];
  }
  
  void attackSeveralTimes(Person human, int numberOfTimes){
    this.introduce();
    this.printHelper("PREPARE TO DIE");
    if (silentMode == false) print("");
    
    human.introduce();
    human.printHelper("Give me your best shot!");
    if (silentMode == false) print("");
    
    for (int i=0; i < numberOfTimes; i++){
      if (escape == true){
        escape = false;
        break;
      }
      if (silentMode == false){
        print("Attack #" + (i+1).toString());
      }
      this.attack(human);
      
      if (human.health <= 0){
        print("Attack stopped because " + human.name + " died.");
        print(this.name + " is victorious!");
        break;
      }
      human.attack(this);
      
      if (this.health <= 0){
        print("Attack stopped because " + this.name + " died.");
        print(human.name + " is victorious!");
        break;
      }
    }
    
    if (human.health > 0 && this.health > 0){
      if (human.health > this.health){
        human.printHelper("I won this battle, I'll get you next time.");
      } 
      else if (this.health > human.health){
        this.printHelper("I won this battle, I'll get you next time.");
      }
      else{
        this.printHelper("This was a draw, I'll see you next time.");
      }
    }
    
    
  }
  static void fruitStorm(){
    
    fruitPower.forEach((k,v) => fruitPower[k] = (v.abs())*-1);
    print("FRUIT STORM!!!!! " + '$fruitPower');
    
  }
  
  static void fruitParadise(){
    fruitPower.forEach((k,v) => fruitPower[k] = v.abs());
    print("FRUIT PARADISE!!! " + '$fruitPower');
  }
  
  static void fruitChallenge(){
    Random fruitWeather = new Random();
    int number = fruitWeather.nextInt(2);
    if (number == 0){
      fruitStorm();
    }
    else{
    fruitParadise();
    }
  }
  
  void changehands(int h) {
    hands = h;
  }
 
}

class Superhero extends Person{
  
  int superMultiplier;
  
  Superhero(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon, Nation nationObject, this.superMultiplier) : super(nameString, ageNum, eyeString, heightNum, superpowerString, healthNum*superMultiplier, defenseNum*superMultiplier, weapon, nationObject);
 
  @override void introduce(){
    super.introduce();
    this.printHelper("I am a superhero! My Supermultiplier is " + superMultiplier.toString());
  }
  
  @override int getPower(weapon){

    return super.getPower(weapon)*superMultiplier;

  }
  
}

class Nation {
  Person leader;
  Superhero superhero;
  int armySize;
  var numberOfWeaponsMap  = new Map();

  List <Person> armyList = new List();
  static List <String> minionNames = ["Jerry", "Bobby", "Minion", "Moose", "Apple", "Daisy", "Vexx", "ZHC", "Pacon", "Texas Instruments"];
  static List <String> colorList = ["brown", "yellow", "black", "blue"];
  static List <String> superpowerList = ["flying", "eating", "invisibility", "super strength"];
  List<String> weaponList = new List();

  Nation(Person leaderPerson, String superheroName, int armyMembers){
    leader = leaderPerson;
    superhero = Superhero(superheroName, 22, "yellow", 8, "invisibility", 15, 10, "sword", this, 2);
    armySize = armyMembers;
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
  }

  void generateArmy(){
   for(int i = 0; i < armySize; i++){
    
    
    Random index = new Random();
    String name = minionNames[index.nextInt(minionNames.length)];
    int age = 234;
    String eyecolor = colorList[index.nextInt(colorList.length)];
    int height = index.nextInt(7)+1;
    String superpower = superpowerList[index.nextInt(superpowerList.length)];
    int health = 10;
    int defense = index.nextInt(11);
    
    String weapon = weaponList[index.nextInt(weaponList.length)];
    
    armyList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon, this));
     
   }
   armyList.add(this.leader);
   armyList.add(this.superhero);
  }

  String nationInfo(){
    String info = "";
    info += "\n";
    info += ("Leader name: " + leader.name);
    info += "\n";
    info += ("Leader health: ${leader.health}");
    info += "\n";
    info += ("Army size: $armySize");
    info += "\n";
    info += ("Superhero: " + superhero.name);
    info += "\n";
    
    int nationHealth = 0;
    armyList.forEach((v)=> nationHealth = nationHealth + v.health);
    info += ("Total Nation Health: $nationHealth");
    info += "\n";
    
    int nationDefense = 0;
    armyList.forEach((v)=> nationDefense = nationDefense + v.defense);
    info += ("Total Nation Defense: $nationDefense");
    info += "\n";

    //finds the number of weapons for each weapon
    for (Person p in armyList){
      //goes through p's backpack and finds their weapons
      for (String w in p.backpack){

        if(weaponList.contains(w)){
          //if this weapon has been added as a key to the Map before, then update the number of weapons
          if(numberOfWeaponsMap.containsKey(w)){
              numberOfWeaponsMap[w] = numberOfWeaponsMap[w] + 1;
          }
          //else create new key
          else{
              numberOfWeaponsMap[w] = 1;
          }

        }
      }
    }
    int nationPower = 0;
    numberOfWeaponsMap.forEach((k,v)=> nationPower = nationPower + v*(Person.weaponPower[k]));
    info += ("Total Nation Power: $nationPower");
    info += "\n";
    info += ("Weapons are: $numberOfWeaponsMap");
    info += "\n";

    return(info);
  }
  void armyHealth(){
    //number of army members, army name: health
    print("Size of " + this.leader.name + "'s army: " + this.armyList.length.toString());
    this.armyList.forEach((v) => print(v.name + ": " + v.health.toString()));
  }

  String armyHealthString(){
    //number of army members, army name: health
    String armyHealth = "";
    armyHealth += "Size of " + this.leader.name + "'s army: " + 
    this.armyList.length.toString();
    armyHealth += "\n";
    //armyHealth += this.leader.name + "'s health: ${this.leader.health}";
    //armyHealth += "\n";
    this.armyList.forEach((v) => (armyHealth+= v.name + ": " + v.health.toString() + "\n"));
    
    int nationHealth = 0;
    armyList.forEach((v)=> nationHealth = nationHealth + v.health);
    armyHealth += ("Total Nation Health: $nationHealth");
    armyHealth += "\n";
    
    int nationDefense = 0;
    armyList.forEach((v)=> nationDefense = nationDefense + v.defense);
    armyHealth += ("Total Nation Defense: $nationDefense");
    armyHealth += "\n";
    
    return armyHealth;
  }


  void feedArmy(){
    this.armyList.forEach((p)=> p.eat("apple"));
    //this.nationInfo();
  }
  void nationAttack(Nation opponentNation, int numberOfTimes){
    bool win = false;
    //round robin style 
    for (int i = 0; i<numberOfTimes; i++){
      //flag that checks if anyone has won. if so, stop the attack
      if (win == true) break;
      for (int i = 0; i <this.armyList.length; i++){
        
        //if either army is smaller than the other, break out of the loop so we don't exceed list index
        if (i>=this.armyList.length || i>=opponentNation.armyList.length){
          break;
        }
        this.armyList[i].attackSeveralTimes(opponentNation.armyList[i], 1);
        
        //removes dead army members
        for(int j = 0; j < this.armyList.length; j++){
          if(this.armyList[j].health <= 0){
            this.armyList.removeAt(j);
          }
        }
        //removes dead army members
        for(int j = 0; j<opponentNation.armyList.length; j++){
          if(opponentNation.armyList[j].health <= 0){
            opponentNation.armyList.removeAt(j);
          }
        }
        if(this.armyList.length == 0){
          print(opponentNation.leader.name + "'s army is victorious!!");
          win = true;
          break;
        }
        if(opponentNation.armyList.length == 0){
          print(this.leader.name + "'s army is victorious!!");
          win = true;
          break;
        }
      }

      if (win == false){
        //shifts opponent's army by one for the round robin
        opponentNation.armyList.insert(0, opponentNation.armyList.removeLast());
        print("************************************");
        print("Attack # ${i+1}");
        print("");
        this.armyHealth();
        print("");
        opponentNation.armyHealth();
        print("");
      }
      

    }
      


  }

}

/*void main () {
  
  /*Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10, 9, "sword");
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10, 7, "baseball bat");
  */
  
  

  print ("Hello and welcome to gamePerson! How many players will be joining?");
  int numberOfPlayers = int.parse(stdin.readLineSync());
  List <Person> personList = new List();
  
  for (int v = 0;v < numberOfPlayers; v++){
    print("Player ${v+1}, What is your name?");
    String name = stdin.readLineSync();
    Random index = new Random();
    int age = index.nextInt(100)+1;
    String eyecolor = Nation.colorList[index.nextInt(Nation.colorList.length)];
    int height = index.nextInt(7)+1;
    String superpower = Nation.superpowerList[index.nextInt(Nation.superpowerList.length)]; 
    int health = 10;
    int defense = index.nextInt(11);
  
    List<String> weaponList = new List();
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
    String weapon = weaponList[index.nextInt(weaponList.length)];
    

    

    personList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon, null));
  }

  //Person person1 = Person(name, age, eyecolor, 5, "flying", 10, 9, "sword");
  for(int i = 0; i< personList.length; i++){
    personList[i].nation = Nation(personList[i], "bob", 3);
    personList[i].introduce();
    personList[i].nation.generateArmy();
    personList[i].nation.nationInfo();
    print("");
  
  }

  while(1 == 1){
    for(int i = 0; i<personList.length; i++){
      if (personList[i].nation.armyList.length == 0){
        print("Skipped Player ${i+1}'s turn");
        continue;
      }
      print("Player ${i+1}, what would you like to do? \nAttack or Feed Army");
      var commands = stdin.readLineSync();
      if (commands == "Exit"){
        print("Thanks for playing!");
        return;
      }
      if (commands == "Attack"){
        print("****************");
        Person.silentMode = true;
        print("Which player do you want to attack? (1-${personList.length})");
        int player = int.parse(stdin.readLineSync());
        print("How many times would you like to attack?");
        int numberOfTimes = int.parse(stdin.readLineSync());
        if (personList[player-1].nation.armyList.length == 0){
          print("Player ${player} is already dead");
        }
        else{
          personList[i].nation.nationAttack(personList[player-1].nation, numberOfTimes);
        } 
       List<bool> aliveList = new List();
        for (Person n in personList){
          if (n.nation.armyList.length == 0){
            aliveList.add(false);
          }
          else{
            aliveList.add(true);
          }
        }

        int winner = -1;
        for(int i = 0; i < aliveList.length; i++){
          if (aliveList[i] == true){
            if(winner == -1){
              winner = i;
             
            }
            else{
              //there is more than one person alive
              winner = -2;
            }
          }
        }
        if(winner == -2){
            //the game is still going on
          }
          else if(winner == -1){
            //everyone is dead
          }
          else if(winner != -1){
            
            print("Player ${winner + 1} is the winner!!!!!!!!");
            return;
          }
        
      }

      else if (commands == "Feed Army"){
        Person.silentMode = true;
        personList[i].nation.feedArmy();
      }
      
      else{
        print("Unknown command");
      }
    }
  }
 
  
  
}*/


