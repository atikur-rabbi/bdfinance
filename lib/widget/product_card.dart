import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

class ProductCardsdemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('1st app'),
          ),
          body: mylistWidget),
    );
  }
}

Widget mylistWidget = new ListView(
  children: <Widget>[
    productCard,
    productCard,
  ],
);

var data = "images/basic.png";
Widget productCard = Card(
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 120,
          child: Image.asset(data),
        ),
        flex: 2,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                //height: 600,
                alignment: Alignment.topLeft,
                child: Text(
                  "Babe",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(20, 5,5, 0),
                alignment: Alignment.topLeft,
                //height: 600,
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: TextStyle(
                      fontSize: 16,
                    ))),
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                alignment: Alignment.bottomRight,
                //height: 600,
                child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child:
                  const Text('Select', style: TextStyle(color: Colors.white)),
            ),)
          ],
        ),
        flex: 4,
      ),
    ],
  ),
);
