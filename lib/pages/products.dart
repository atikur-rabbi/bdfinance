import 'package:flutter/material.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../widget/const.dart';
import '../widget/deposit.dart';
import '../widget/loan.dart';
// void main() => runApp(new MyApp());



class ProductPage extends StatefulWidget {
  final BuildContext context;

  const ProductPage({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  _ProductPageState createState() => new _ProductPageState( );
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Deposit'),
    new Tab(text: 'Loan'),
  ];

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(gradient: LinearGradient(colors: [color3, color2]),),
            height: 45.0,
            child: new TabBar(
              controller: _controller,
              // labelColor: Colors.red,
                    labelColor: Colors.orangeAccent,              
                    unselectedLabelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 16.0,fontFamily: 'Family Name'),  //For Selected tab
                    unselectedLabelStyle: TextStyle(fontSize: 14.0,fontFamily: 'Family Name'), //For Un-selected Tabs
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator:  BoxDecoration(
                        //gradient: LinearGradient(colors: [color3, color2]), 
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0)),
                        color: Colors.white,
                    ),
              tabs: myTabs,
            ),
          ),
          new Container(
            height: height-45.0,
            child: new TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                DepositPage(context: context),
                LoanPage(),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}