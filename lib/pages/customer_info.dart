import 'package:flutter/material.dart';
import '../widget/const.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerInfo extends StatelessWidget {

  final String id;
  final  data;

  const CustomerInfo({
    Key key,
    @required this.id,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text("Settings"),
          gradient: LinearGradient(colors: [color3, color2])
      ),
      body: Container(
          color: const Color(0xFFf0f0f0),
          child: _buildBody(context),
      ),
    );
  }


  Widget _buildBody(BuildContext context) {

    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[
      SizedBox(height: 30),

      Stack(
      children: <Widget>[

            Container(
            height: 300,
            child:Card(
            margin: EdgeInsets.fromLTRB(10, 90, 10, 10),
            child: InkWell(
              onTap: () {
                // Function is executed on tap.
              },
              child:Column(
                children: [
                  SizedBox(height: 80),
                  Center(child: Text(data['name'], style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ) )),
                  SizedBox(height: 15),
                  Center(child: Text("Address: "+data['address'], style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ) )),
                  Center(child: Text("Mobile No: "+data['mobileNo'], style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ) )),
                  Center(child: Text("Birth Date: "+data['birthdate'], style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ) )),

                ],
              ),
            ))),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: c4,
            child: ClipOval(
              child: new SizedBox(
                width: 150.0,
                height: 150.0,
                child: Image.network(
                  data['imageURL'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ]),


      Container(
          height: 150,
          child:Card(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child:InkWell(
        onTap: () {
        // Function is executed on tap.
        },
        child:Column(
        children: [
        SizedBox(height: 20),
        Center(child: Text("Profrssion: "+data['profession'], style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        ) )),
        SizedBox(height: 5),
        Center(child: Text("Net Worth: "+data['networth'], style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        ) )),

        Center(child: Text("Make Deposit: "+data['makedeposit'], style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        ) )),

        ],
        ),
        ))),

    ]);
  }

}
