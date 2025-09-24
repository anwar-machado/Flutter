import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

// The Class responsible for the design of the UI
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Method that exits de App
  void exit() {
    SystemNavigator.pop();
  }

  // Counter variable started with 0
  int counter = 0;

  // Increment method, responsible to increment the counter value
  void increment() {
    // The opertion that increments the counter variable
    counter++;

    // A print to the console to make sure it's really incrementing
    print('Counter : $counter');
  }

  // Decrement method, responsible to decrement the counter value
  void decrement() {
    // Condition to make sure we dont have negative numbers
    if (counter > 0) {
      // The opertion that decrements the counter variable
      counter--;

      // A print to the console to make sure it's really decrementing
      print('Counter : $counter');
    }
  }

  // Method that sets the counter value to 0
  void clear() {
    counter = 0;

    // A print to see the counter value in the console
    print('Counter : $counter');
  }

  @override
  Widget build(BuildContext context) {
    // The responsible that makes sure every widget will exist in the GUI
    return Scaffold(
      // The App Bar of our "App"
      appBar: AppBar(
        title: Text(
          'Counter',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),

      // The Column widget that will hold other widgets
      body: Column(
        // Align the Column content to the center
        mainAxisAlignment: MainAxisAlignment.center,

        // The list of items that belong to the Column
        children: [
          // Item 1
          Row(
            // Align the content to the center
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // Setting size
                height: 90,
                width: 100,

                // Setting a Padding widget to make some space between the widgets
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),

                  // The Container that will hold the button 'IN"
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: increment,
                      child: Text('In', style: TextStyle(fontSize: 50)),
                    ),
                  ),
                ),
              ),

              // Setting the size of the widget
              SizedBox(
                height: 90,
                width: 100,

                // Setting a Padding widget to make some space between the widgets
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                  // The Container that will hold the button 'OUT"
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: decrement,
                      child: Text('Out', style: TextStyle(fontSize: 50)),
                    ),
                  ),
                ),
              ),
            ],
          ),


          // Item 2
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Counter : $counter',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // The Bottom App Bar
      bottomNavigationBar: BottomAppBar(

        // Setting up a row to hold the icons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // The icons, organized
            IconButton(
                onPressed: exit,
                icon: Icon(Icons.home_filled)),
            IconButton(
              onPressed: clear,
              icon: Icon(Icons.cleaning_services_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
