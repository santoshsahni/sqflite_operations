import 'package:flutter/material.dart';
import 'package:sqlfdatabase/dbhelper.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: mydb(),
    );
  }
}

class mydb extends StatefulWidget {
  @override
  State<mydb> createState() => _mydbState();
}

class _mydbState extends State<mydb> {
  final dbhelper = databaseHelper.instance;

  void insertdata() async {
    Map<String, dynamic> row = {
      databaseHelper.columnName: "sahni",
      databaseHelper.columnAge: 15
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbhelper.queryall();
    // allrows.forEach((row) {
    //   print(row);
    // });
    print(allrows);
  }

  void queryspecific() async {
    var allrows = await dbhelper.queryspecific(15);
    print(allrows);
  }

  void delete() async {
    var id = await dbhelper.delete(5);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: insertdata,
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text("INSERT")),
            ElevatedButton(
                onPressed: queryall,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text("QUERY")),
            ElevatedButton(
                onPressed: queryspecific,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text("QUERY SPECIFIC")),
            ElevatedButton(onPressed: () {}, child: Text("UPDATE")),
            ElevatedButton(
                onPressed: delete,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text("DELETE")),
          ],
        ),
      ),
    );
  }
}
