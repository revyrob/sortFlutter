/* Flutter/Dart application that displays 10 random numbers with three buttons
on the top of the application.
The Ascending and Descending buttons put the list in Descending or Ascending order.
The Add button adds a random number to the list of buttons and if the list of numbers
is in Descending or Ascending order the added random number will be sorted in the
correct location in regards to the other numbers.
 */
import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  //added const for MyApp
  runApp(const MyApp());
}

/// Write code that compiles and executes for each of the three buttons listed above the list of numbers
/// Fix and/or tweak the code as you would if this were a code review
/// Add comments where needed

//My App was reduced since athe StatefulWidget of ChangeWidget is used
//to change the numbers without refreshing page
class MyApp extends StatelessWidget {
  //add key contructor for MyApp
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // initNumbers(numbers);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,

      //bring in our ChangeWidget here for the statefulWidget
      home: const ChangeWidget(),
    );
  }
}

//Create state for the numbers list so that numbers can be changed as the
//buttons are clicked
class ChangeWidget extends StatefulWidget {
  const ChangeWidget({super.key});

  @override
  State<ChangeWidget> createState() => ChangeWidgetState();
}

//ChangeWidgetState extends the ChangedWidget and we write the
//code and the buttons within this widget
class ChangeWidgetState extends State<ChangeWidget> {
  // List of integers is declared
  List<int> numbers = [];

  //booleans to determin weather the list is ascending and descending
  bool isDescending = false;
  bool isAscending = false;

  //The state is initalized for the number list with 10 random numbers
  //this helps the list add once when initalized and not continue to add
  //everytime a buttons is pushed.
  @override
  void initState() {
    super.initState();
    initNumbers();
  }

// This button adds a number to the list of numbers generated
  // This button adds a number to the list and determining if the
  // has been selected as ascending, descending, or neither.  The
  // boolean value will help decide where the number will be located
  TextButton add() {
    return TextButton(
        onPressed: () {
          //create a variable for the new number and use the
          //flutter Random() to find a random integer between 1-100
          var newNum = Random().nextInt(100);

          //set the new state of the list of numbers with the added
          //newNum
          setState(() {
            //numbers.add(newNum);
            //if ascending is true then sort the new list in ascending
            if (isAscending == true) {
              numbers.add(newNum);
              //ascending order
              numbers.sort((b, a) => b - a);
            } else if (isDescending == true) {
              numbers.add(newNum);
              //descending order
              numbers.sort((a, b) => b - a);
            } else {
              //list is unsorted and a random number gets added to the bottom
              //of the list
              numbers.add(newNum);
            }
          });
        },
        //removed unnecessary container
        child: const Text("Add"));
  }

// Widget low lists the numbers in ascending order
  Widget low() => GestureDetector(
      //onTap we want to take the numbers listed and sort them from
      //lowest to highest
      onTap: () async {
        //use setState to change the list in ascending order
        setState(() {
          //sort numbers list in ascending order
          numbers.sort((b, a) => b - a);
          //change state of isAscending to true if it is not
          if (isAscending == false) {
            isAscending = !isAscending;
          }
          // changes state of descending to false if it is not
          if (isDescending == true) {
            isDescending = !isDescending;
          }
        });
      },
      child: Container(
          //add const to improve performance
          padding: const EdgeInsets.all(16),
          color: Colors.purple,
          //add const to improve performance
          child: const Text("Ascending")));

  // Widget high lists the numbers in descending order
  Widget high() => GestureDetector(
      //onTap we want to take the numbers listed and sort them from
      //highest to lowest
      onTap: () async {
        setState(() {
          //sort numbers list in descending order
          numbers.sort((a, b) => b - a);
          //change state of isDescending to true if not
          if (isDescending == false) {
            isDescending = !isDescending;
          }
          //change state of isAscending to false if not
          if (isAscending == true) {
            isAscending = !isAscending;
          }
        });
      },
      child: Container(
          //add constructor to improve performance
          padding: const EdgeInsets.all(16),
          color: Colors.purple,
          //add construnctor to improve performance
          child: const Text("Descending")));

  //function for get 10 random integers for the list
  initNumbers() {
    //removed new to Random(), not necessary
    Random rnd = Random();
    //add a nums int for the quantity of numbers in the list
    int nums = 10;
    int min = 1;
    int max = 100;
    for (int i = 0; i < nums; i++) {
      numbers.add(min + rnd.nextInt(max - min));
    }
  }

  //build the stateful widget
  @override
  Widget build(BuildContext context) {
    //initNumbers(numbers);
    //print(numbers);
    return Scaffold(
        body: Container(
            //add constructor to improve performance
            padding: const EdgeInsets.only(top: 16),
            child: Center(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [low(), add(), high()],
                ),
                // map out and the random numbers and use Expand and
                //SingleChildScrollView so that the screen is scrollable
                Expanded(
                  child: SingleChildScrollView(
                    // child: buildList(),
                    child: Column(
                      children: numbers
                          .map((number) => Container(
                                width: 50,
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.all(16),
                                color: Colors.purple,
                                child: Text("$number"),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
