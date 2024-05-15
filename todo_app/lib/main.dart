import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-DO List'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue, 
        ),
        body: ToDoListScreen(),
      ),
    );
  }
}
