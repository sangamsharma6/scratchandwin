import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //TODO:import Images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  //TODO:get an Array
  List<String> itemArray =  List<String>.generate(
      25, (index) => "empty");

  int luckyNumber;

  //TODO:INIT ARRAY WITH 25 ELEMENTS
  @override
  void init() {
    super.initState();
   //shortcut for generating list of 25 arrays
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //TODO:DEFINE  getImage METHOD
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  //TODO: PLAY GAME METHOD

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  //TODO: showAll

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //TODO: resetAll
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,

              ),
              itemCount: itemArray.length,
              itemBuilder: (context,i)=> SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                onPressed: (){
                  this.playGame(i);
                },
                  child: Image(
                    image: this.getImage(i),
                  ),
              )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(50.0),
            child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text('Show All'),
            ),
          ),
         Container(
             margin: EdgeInsets.all(20.0),
             child: RaisedButton(
               onPressed: (){
                 this.resetGame();
               },
               color: Colors.pink,
               padding: EdgeInsets.all(20.0),
               child: Text('Reset All'),
             )
         )
        ],
      ),
    );
  }
}
